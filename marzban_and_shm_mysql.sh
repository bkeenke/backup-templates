#!/bin/bash

set -e

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

SHM_DOCKER_COMPOSE_PATH="/opt/shm"
MZ_DOCKER_COMPOSE_PATH="/opt/marzban"
BACKUP_DIR="/opt/backups"
MARZBAN_PATH="/var/lib/marzban"
TELEGRAM_BOT_TOKEN="1234567890:XXXXXXXXXXXXXXXXXXXXXXXXXXX"
TELEGRAM_CHAT_ID="-1234567890"
TIMESTAMP=$(date +%d-%m-%Y-%H-%M-%S)

mkdir -p ${BACKUP_DIR}

SHM_DB_BACKUP_FILE="shm_${TIMESTAMP}.sql"
cd ${SHM_DOCKER_COMPOSE_PATH}
docker compose exec -T mysql /bin/bash -c 'MYSQL_PWD=${MYSQL_ROOT_PASSWORD} mysqldump -u root shm' > ${BACKUP_DIR}/${SHM_DB_BACKUP_FILE}

MZ_DB_BACKUP_FILE="mz_${TIMESTAMP}.sql"
cd ${MZ_DOCKER_COMPOSE_PATH}
docker compose exec -T mysql /bin/bash -c 'MYSQL_PWD=${MYSQL_ROOT_PASSWORD} mysqldump -u root marzban' > ${BACKUP_DIR}/${MZ_DB_BACKUP_FILE}

BACKUP_ARCHIVE="${BACKUP_DIR}/backup_${TIMESTAMP}.tar.gz"

tar -czf ${BACKUP_ARCHIVE} -C ${MARZBAN_PATH} xray_config.json -C ${BACKUP_DIR} ${SHM_DB_BACKUP_FILE} -C ${BACKUP_DIR} ${MZ_DB_BACKUP_FILE}

curl -s -F chat_id="${TELEGRAM_CHAT_ID}" -F document=@"${BACKUP_ARCHIVE}" "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendDocument"

find ${BACKUP_DIR} -type f -mtime +7 -delete