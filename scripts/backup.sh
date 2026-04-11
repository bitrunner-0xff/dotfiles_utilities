#!/usr/bin/env bash

set -euo pipefail

SOURCE_FOLDER="$HOME/main"
BACKUP_DIR="/mnt/veracrypt/backup"

OBSIDIAN_DICTIONARY_DIR="~/.var/app/md.obsidian.Obsidian/config/obsidian"
OBSIDIAN_DICTIONARY="Custom\ Dictionary.txt"

RESTORE_DIR="$HOME"

create() {
    echo "Backup process started..."

    [[ ! -d "$BACKUP_DIR" ]] && {
        echo "Backup destination not mounted"
        exit 1
    }

    BACKUP_NAME="main_$(date +%Y-%m-%d).tar"

    [[ ! -e ~/main/secrets ]] && mkdir -p ~/main/secrets

    cp -av \
        ~/.ssh \
        ~/.password-store \
        ~/.gnupg tor.txt \
        ~/mom_parols.txt \
        ~/.Ack.kdbx \
        ~/main/secrets

    cp "$OBSIDIAN_DICTIONARY_DIR/$OBSIDIAN_DICTIONARY" ~/main/Obsidian/

    tar --create \
        --verbose \
        --file="$BACKUP_DIR/$BACKUP_NAME" \
        -C "$HOME" \
        main

    if tar -tf "$BACKUP_DIR/$BACKUP_NAME" >/dev/null 2>&1; then
        echo " ✓ Backup verified: $BACKUP_NAME ($(du -h "$BACKUP_DIR/$BACKUP_NAME" | cut -f1))"
        exit 1
    fi

    if [ $? -ne 0 ]; then
        echo " ✗ Backup failed"
        exit 1
    fi

    echo " ✓ Backup created: $BACKUP_NAME"
}

get_last_file() {
    LATEST=$(find "$BACKUP_DIR" -maxdepth 1 -type f -name "main_*.tar" 2>/dev/null |
        sort -r |
        head -n 1)

    echo $LATEST
}

restore() {
    echo "Restore process started..."

    FILE=$(get_last_file)

    tar --extract \
        --verbose \
        --directory="$RESTORE_DIR" \
        --file="$FILE"

    cp -a ~/main/secrets/. ~/
    cp ~/main/Obsidian/$OBSIDIAN_DICTIONARY $OBSIDIAN_DICTIONARY_DIR

    if [ $? -ne 0 ]; then
        echo " ✗ Restoration failed"
        exit 1
    fi

    echo " ✓ Restore completed in: $RESTORE_DIR"
}

case "$1" in
-c) create ;;
-r) restore ;;
*)
    echo "Usage: $0 -c | -r"
    exit 1
    ;;
esac
