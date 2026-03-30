#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

SOURCE_FOLDER="$HOME/main"
# DEST_DIR="/run/media/veracrypt1/backup"
DEST_DIR="/mnt/veracrypt/backup"
BACKUP_NAME="main_$(date +%Y-%m-%d).tar"

# BACKUP_DIR="/run/media/veracrypt1/backup"
BACKUP_DIR="/mnt/veracrypt/backup"
RESTORE_DIR="$HOME"

create() {
    echo "Backup process started..."

    [[ ! -d "$DEST_DIR" ]] && {
        echo "Backup destination not mounted"
        exit 1
    }

    [[ ! -e ~/main/secrets ]] && mkdir -p ~/main/secrets

    cp -av ~/.ssh ~/.password-store ~/.gnupg ~/main/secrets/

    tar --create \
        --verbose \
        --file="$DEST_DIR/$BACKUP_NAME" \
        -C "$HOME" main

    if ! tar -tf "$DEST_DIR/$BACKUP_NAME" >/dev/null; then
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

restore() {
    echo "Restore process started..."

    tar --extract \
        --verbose \
        --directory="$RESTORE_DIR" \
        --file="$1"

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
-r) restore "$2" ;;
*)
    echo "Usage: $0 -c | -r"
    exit 1
    ;;
esac
