#!/bin/bash

set -e

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

MARZBAN_PATH="/var/lib/marzban"
BACKUP_DIR="/opt/backups"
TELEGRAM_BOT_TOKEN="1234567890:XXXXXXXXXXXXXXXXXXXXXXXXXXX"
TELEGRAM_CHAT_ID="-1234567890"
TIMESTAMP=$(date +%d-%m-%Y)

mkdir -p ${BACKUP_DIR}

BACKUP_ARCHIVE="${BACKUP_DIR}/backup_marzban_${TIMESTAMP}.tar.gz"
tar -czf ${BACKUP_ARCHIVE} -C ${MARZBAN_PATH} db.sqlite3 xray_config.json

curl -s -F chat_id="${TELEGRAM_CHAT_ID}" -F document=@"${BACKUP_ARCHIVE}" "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendDocument"

find ${BACKUP_DIR} -type f -mtime +7 -delete