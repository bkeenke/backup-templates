#!/bin/bash

set -e

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

DOCKER_COMPOSE_PATH="/opt/shm"
BACKUP_DIR="/opt/backups"
TELEGRAM_BOT_TOKEN="1234567890:XXXXXXXXXXXXXXXXXXXXXXXXXXX"
TELEGRAM_CHAT_ID="-1234567890"
TIMESTAMP=$(date +%d-%m-%Y)

mkdir -p ${BACKUP_DIR}

DB_BACKUP_FILE="shm_${TIMESTAMP}.sql"
cd ${DOCKER_COMPOSE_PATH}
docker compose exec -T mysql /bin/bash -c 'MYSQL_PWD=${MYSQL_ROOT_PASSWORD} mysqldump -u root shm' > ${BACKUP_DIR}/${DB_BACKUP_FILE}

BACKUP_ARCHIVE="${BACKUP_DIR}/backup_shm_${TIMESTAMP}.tar.gz"
tar -czf ${BACKUP_ARCHIVE} -C ${BACKUP_DIR} ${DB_BACKUP_FILE}

curl -s -F chat_id="${TELEGRAM_CHAT_ID}" -F document=@"${BACKUP_ARCHIVE}" "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendDocument"

find ${BACKUP_DIR} -type f -mtime +7 -delete