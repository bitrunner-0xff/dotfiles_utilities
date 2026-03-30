#!/usr/bin/env bash

set -euo pipefail

SOURCE_FOLDER="$HOME/main"
BACKUP_DIR="/mnt/veracrypt/backup"

RESTORE_DIR="$HOME"

create() {
    echo "Backup process started..."

    [[ ! -d "$BACKUP_DIR" ]] && {
        echo "Backup destination not mounted"
        exit 1
    }

    BACKUP_NAME="main_$(date +%Y-%m-%d).tar"

    [[ ! -e ~/main/secrets ]] && mkdir -p ~/main/secrets

    cp -av ~/.ssh ~/.password-store ~/.gnupg ~/main/secrets/

    tar --create \
        --verbose \
        --file="$BACKUP_DIR/$BACKUP_NAME" \
        -C "$HOME" main

    if ! tar -tf "$BACKUP_DIR/$BACKUP_NAME" >/dev/null; then
        echo "Your backup is busted."
        exit 1
    fi

    if [ $? -eq 0 ]; then
        echo " ✓ Backup created: $BACKUP_NAME"
    else
        echo " ✗ Backup failed"
        exit 1
    fi
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

    cp -a ~/main/secrets/. ~/ && rm -rf ~/main/secrets

    if [ $? -eq 0 ]; then
        echo " ✓ Restore completed in: $RESTORE_DIR"
    else
        echo " ✗ Restoration failed"
        exit 1
    fi
}

case "$1" in
-c) create ;;
-r) restore ;;
*)
    echo "Usage: $0 -c | -r"
    exit 1
    ;;
esac
