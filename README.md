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

⚠️ Change paths before using the command, these path are examples

```bash
docker run -d \
  --name sfserver \
  --restart unless-stopped \
  -v "./ServerFiles:/home/sfserver/serverfiles/" \
  -v "./LogFolder:/home/sfserver/log/" \
  -v "./BackupFolder:/home/sfserver/lgsm/backup/" \
  -v "./LGSM-Config:/home/sfserver/lgsm/config-lgsm/sfserver/" \
  -v "./SavesGames:/home/sfserver/.config/Epic/FactoryGame/Saved/SaveGames/server" \
  -p 15777:15777/udp \
  -p 15000:15000/udp \
  -p 7777:7777/udp \
  -e START_MODE=1 \
  -e TEST_ALERT=NO \
  -e VERSION=public \
  -e BACKUP=YES \
  -e MONITOR=YES \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TimeZone=Europe/Madrid \
  vinanrra/satisfactory-server
```

### docker-compose

⚠️ Change paths before using the command, these path are examples

```yaml
version: '2'
services:
  sfserver:
    image: vinanrra/satisfactory-server
    container_name: sfserver
    environment:
      - START_MODE=1 # Change between START MODES
      - PUID=1000 # Remember to use same as your user
      - PGID=1000 # Remember to use same as your user
      - TimeZone=Europe/Madrid
      - TEST_ALERT=NO
      - BACKUP=YES # Backup server at 5 AM
      - MONITOR=YES # Keeps server up if crash
      - VERSION=public # Change between server versions
    volumes:
      - ./ServerFiles:/home/sfserver/serverfiles/ # Optional, serverfiles
      - ./log:/home/sfserver/log/ # Optional, logs
      - ./backups:/home/sfserver/lgsm/backup/ # Optional, backups
      - ./LGSM-Config:/home/sfserver/lgsm/config-lgsm/sfserver # Optional, LGSM-Config
      - ./SavesGames:/home/sfserver/.config/Epic/FactoryGame/Saved/SaveGames/server # Satisfactory Saves
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
| `/path/to/SavesGames:/home/sfserver/.config/Epic/FactoryGame/Saved/SaveGames/server` | Game save files path |
| `15777:15777/udp` | Default Satisfactory port **required** |
| `15000:15000/udp` | Default Satisfactory port **required** |
| `7777:7777/udp` | Default Satisfactory port **required** |  
| `START_MODE=1` | Start mode of the container - see below for explanation **required** |
| `TEST_ALERT=YES` | Test alerts at start of server **optional** |
| `BACKUP=YES` | Backup server at 5 AM (Only the latest 5 backups will be keep, maximum 30 days) [More info](https://docs.linuxgsm.com/commands/backup) **optional** |
| `MONITOR=YES` | Monitor server status, if server crash this will restart it [More info](https://docs.linuxgsm.com/commands/monitor) **optional** |
| `VERSION=public` | Change server version, check [Branches](https://steamdb.info/app/1690800/depots/) to know the names **optional** |
| `PUID=1000` | for UserID - see below for explanation **optional** |
| `PGID=1000` | for GroupID - see below for explanation **optional** |
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

## Backups

The backup command allows the creation of .tar.gz archives of a game server, alter these three settings by editing LinuxGSM Config

* maxbackups
* maxbackupdays
* stoponbackup

Backups settings can be changed in */path/to/LGSM-Config/common.cfg*

If you wants to force a backup run this command:

```bash
  docker-compose exec sfserver ./sfserver backup
```

## Alerts

LinuxGSM allows alerts to be received using various methods, multiple alerts can be enable at same time:

* Discord
* Email
* IFTTT
* Mailgun
* Pushbullet
* Pushover
* Telegram
* Slack

Alerts settings can be changed in */path/to/LGSM-Config/common.cfg*

You recieve alerts only if the server crashes or updates itself.

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```bash
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Support Info

* Shell access whilst the container is running: `docker exec -it sfserver /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f sfserver`
* container version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' sfserver`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' vinanrra/satisfactory-server`

## Updating Info

### Via Docker Run/Create

* Update the image: `docker pull vinanrra/satisfactory-server`
* Stop the running container: `docker stop sfserver`
* Delete the container: `docker rm sfserver`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your folders and settings will be preserved)
* Start the new container: `docker start sfserver`
* You can also remove the old dangling images: `docker image sfserver`

### Via Docker Compose

* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull sfserver`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d sfserver`
* You can also remove the old dangling images: `docker image prune`
