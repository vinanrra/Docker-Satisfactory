# [vinanrra/Docker-Satisfactory](https://github.com/vinanrra/Docker-Satisfactory)

# Satisfactory server using LinuxGSM script in Docker

[![Docker Pulls](https://img.shields.io/badge/dynamic/json?color=red&label=pulls&query=pull_count&url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Fvinanrra%2Fsatisfactory-server%2F?style=flat-square&color=E68523&logo=docker&logoColor=white)](https://hub.docker.com/r/vinanrra/satisfactory-server)
[![Docker Stars](https://img.shields.io/badge/dynamic/json?color=red&label=stars&query=star_count&url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Fvinanrra%2Fsatisfactory-server%2F?style=flat-square&color=E68523&logo=docker&logoColor=white)](https://hub.docker.com/r/vinanrra/Satisfactory-server)
[![Docker Last Updated](https://img.shields.io/badge/dynamic/json?color=red&label=Last%20Update&query=last_updated&url=https%3A%2F%2Fhub.docker.com%2Fv2%2Frepositories%2Fvinanrra%2Fsatisfactory-server%2F?style=flat-square&color=E68523&logo=docker&logoColor=white)](https://hub.docker.com/r/vinanrra/satisfactory-server)

![Satisfactory](https://img2.storyblok.com/fit-in/0x300/filters:format(webp)/f/110098/5405x1416/10decfbcac/hero-logo.png)

## Information

* If you have any problems open a [github ticket](https://github.com/vinanrra/Docker-Satisfactory/issues).
* This container have: Automatic backups and auto-restart if crash.
* The first time you start the container it will be auto-installed.
* If you want to recieve alerts check [ALERTS](https://github.com/vinanrra/Docker-Satisfactory#alerts).
* Read everything to avoid any errors.

## Usage

### Docker

```bash
docker run -d \
  --name sfserver \
  --restart unless-stopped \
  -v "./ServerFiles:/home/sfserver/serverfiles/" \
  -v "./LogFolder:/home/sfserver/log/" \
  -v "./BackupFolder:/home/sfserver/lgsm/backup/" \
  -v "./LGSM-Config:/home/sfserver/lgsm/config-lgsm/sfserver/" \
  -p 15777:15777/udp \
  -p 15000:15000/udp \
  -p 7777:7777/udp \
  -e START_MODE=1 \
  -e TEST_ALERT=NO \
  -e BACKUP=YES \
  -e MONITOR=YES \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TimeZone=Europe/Madrid \
  vinanrra/satisfactory-server
```

### docker-compose

```yaml
version: '2'
services:
  7dtdserver:
    image: vinanrra/satisfactory-server
    container_name: sfserver
    environment:
      - START_MODE=1 #Change between START MODES
      - PUID=1000 # Remember to use same as your user
      - PGID=1000 # Remember to use same as your user
      - TimeZone=Europe/Madrid
      - TEST_ALERT=NO
      - BACKUP=YES # Backup server at 5 AM
      - MONITOR=YES # Keeps server up if crash
    volumes:
      - ./ServerFiles:/home/sfserver/serverfiles/ #Optional, serverfiles
      - ./Satisfactory:/home/sfserver/.local/share/7DaysToDie/ #Optional, maps files
      - ./log:/home/sfserver/log/ #Optional, logs
      - ./backups:/home/sfserver/lgsm/backup/ #Optional, backups
      - ./LGSM-Config:/home/sfserver/lgsm/config-lgsm/sfserver # Optional, LGSM-Config
    ports:
      - 15777:15777/udp
      - 15000:15000/udp
      - 7777:7777/udp
    restart: unless-stopped #NEVER USE WITH START_MODE=4 or START_MODE=0
```

## Parameters

| Parameter | Function |
| :----: | --- |
| `/path/to/ServerFiles:/home/sfserver/serverfiles/` | Satisfactory server config files. |
| `/path/to/Logs:/home/sfserver/log/` | Satisfactory server log files. |
| `/path/to/BackupFolder:/home/sfserver/lgsm/backup/` | Satisfactory server backups files. |
| `/path/to/LGSM-Config:/home/sfserver/lgsm/config-lgsm/sfserver/` | LGSM config files. [More info](https://docs.linuxgsm.com/commands/monitor) |
| `15777:15777/udp` | Default Satisfactory port **required** |
| `15000:15000/udp` | Default Satisfactory port **required** |
| `7777:7777/udp` | Default Satisfactory port **required** |  
| `START_MODE=1` | Start mode of the container - see below for explanation **required** |
| `TEST_ALERT=YES` | Test alerts at start of server **optional** |
| `BACKUP=YES` | Backup server at 5 AM (Only the latest 5 backups will be keep, maximum 30 days) [More info](https://docs.linuxgsm.com/commands/backup) **optional** |
| `MONITOR=YES` | Monitor server status, if server crash this will restart it [More info](https://docs.linuxgsm.com/commands/monitor) **optional** |
| `PUID=1000` | for UserID - see below for explanation |
| `PGID=1000` | for GroupID - see below for explanation |
| `TimeZone=Europe/Madrid` | for TimeZone - see [TZ Database](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) for time zones **recomendable**|
| `--restart unless-stopped` | Restart container always unlesss stopped manually **NEVER USE WITH START_MODE=4** |

### START MODES

| START_MODE | Information |
| :----: | ---- |
| 0 | Install server |
| 1 | Start server |
| 2 | Update server |
| 3 | Update server and start |
| 4 | Backup server and STOP the container|
