# Backup template

## 🛠 Настройки

> **`marzban_only.sh` Для cоздание архивной копии Marzban с SQLite без использование MySQL**

> **`marzban_only_mysql.sh` Для cоздание архивной копии Marzban с использованием MySQL**

> **`marzban_and_shm.sh` Для cоздание архивной копии Marzban + SHM с SQLite без использование MySQL**

> **`marzban_and_shm_mysql.sh` Для cоздание архивной копии SHM + Marzban с использованием MySQL**

> **`shm_only.sh` Для cоздание архивной копии c использованием MySQL dump как на примере <a href="https://docs.myshm.ru/docs/manage/mysql/#%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%B0%D1%80%D1%85%D0%B8%D0%B2%D0%BD%D0%BE%D0%B9-%D0%BA%D0%BE%D0%BF%D0%B8%D0%B8-backup">официальной документации</a>**


1. Скачать файл

   #marzban_only
   ```shell
   wget -O- https://raw.githubusercontent.com/bkeenke/backup-templates/master/marzban_only.sh > /opt/marzban_only.sh
   ```
   #marzban_only_mysql
   ```shell
   wget -O- https://raw.githubusercontent.com/bkeenke/backup-templates/master/marzban_only_mysql.sh > /opt/marzban_only_mysql.sh
   ```
   #marzban_and_shm
   ```shell
   wget -O- https://raw.githubusercontent.com/bkeenke/backup-templates/master/marzban_and_shm.sh > /opt/marzban_and_shm.sh
   ```
   #marzban_and_shm_mysql
   ```shell
   wget -O- https://raw.githubusercontent.com/bkeenke/backup-templates/master/marzban_and_shm_mysql.sh > /opt/marzban_and_shm_mysql.sh
   ```
   #shm_only
   ```shell
   wget -O- https://raw.githubusercontent.com/bkeenke/backup-templates/master/shm_only.sh > /opt/shm_only.sh
   ```
2. Заполнить переменные

| Переменная                | Описание                                                             | По умолчанию           |
| ------------------------- | -------------------------------------------------------------------- | ---------------------- |
| `DOCKER_COMPOSE_PATH`     | Директория yml файла SHM `docker-compose.yml`                        | `/opt/shm`             |
| `SHM_DOCKER_COMPOSE_PATH` | Директория yml файла SHM `docker-compose.yml` для `SHM`              | `/opt/shm`             |
| `MZ_DOCKER_COMPOSE_PATH`  | Директория yml файла SHM `docker-compose.yml` для `Marzban`          | `/opt/shm`             |
| `MARZBAN_PATH`            | Директория файлов `Marzban`                                          | `/var/lib/marzban`     |
| `BACKUP_DIR`              | Директория где будут храниться архивы                                | `/opt/backups` |
| `TELEGRAM_BOT_TOKEN`      | Токен вашего бота от <a href="https://t.me/BotFather">@BotFather</a> | -                      |
| `TELEGRAM_CHAT_ID`        | `chqt_id` вашей группы в Телеграмм                                   | -                      |

  > **Бот должен быть админом в данной группе**

3. Настроить `cron`

    1. Ввести команду `crontab -e`
    2. Выбрать редактор
    3. Задать время для `cron`
```shell
0 23 * * * * /opt/shm_only.sh >> /opt/backup.log 2>&1
```
  > **Где `shm_only.sh` название нужного скрипта**

Cхема:
```shell
* * * * * *
| | | | | | 
| | | | | +--- Годы       (диапазон: 1900-3000)
| | | | +----- Дни недели (диапазон: 1-7)
| | | +------- Месяцы     (диапазон: 1-12)
| | +--------- Дни месяца (диапазон: 1-31)
| +----------- Часы       (диапазон: 0-23)
+------------- Минуты     (диапазон: 0-59)
```