FROM steamcmd/steamcmd:ubuntu-18

STOPSIGNAL SIGTERM

##############BASE IMAGE##############

####Labels####
LABEL maintainer="vinanrra"
LABEL build_version="version: 0.0.1"

#####Dependencies####

RUN dpkg --add-architecture i386 && \
	apt update -y && \
	apt install -y --no-install-recommends \
		nano \
		iproute2 \
		curl \
		wget \
		file \
		bzip2 \
		gzip \
		unzip \
		bsdmainutils \
		python3 \
		util-linux \
		ca-certificates \
		binutils \
		bc \
		jq \
		tmux \
		lib32gcc1 \
		lib32stdc++6 \
		libstdc++6 \
		libstdc++6:i386 \
		telnet \
		expect \
		netcat \
		locales \
		libgdiplus \
		cron \
		tclsh \
		cpio \
		libsdl2-2.0-0:i386 \
		xz-utils

####Environments####

ENV PUID=1000
ENV PGID=1000
ENV START_MODE=1
ENV TEST_ALERT=no
ENV TimeZone=Europe/Madrid
ENV VERSION=stable
ENV MONITOR=yes
ENV BACKUP=yes
ENV LANG=en_US.utf8

##Need use xterm for LinuxGSM##
ENV TERM=xterm
ENV DEBIAN_FRONTEND noninteractive

####Environments####

# Install latest su-exec
RUN  set -ex; \
     \
     curl -o /usr/local/bin/su-exec.c https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c; \
     \
     fetch_deps='gcc libc-dev'; \
     apt-get install -y --no-install-recommends $fetch_deps; \
     gcc -Wall \
         /usr/local/bin/su-exec.c -o/usr/local/bin/su-exec; \
     chown root:root /usr/local/bin/su-exec; \
     chmod 0755 /usr/local/bin/su-exec; \
     rm /usr/local/bin/su-exec.c; \
     \
     apt-get purge -y --auto-remove $fetch_deps

# Clear unused files
RUN apt clean && \
    rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

##############BASE IMAGE##############

# Create user
RUN adduser --disabled-password --shell /bin/bash --disabled-login --gecos "" sfserver

# Base dir
WORKDIR /home/sfserver

RUN set -ex; \
wget https://raw.githubusercontent.com/GameServerManagers/LinuxGSM/master/linuxgsm.sh

RUN chmod +x linuxgsm.sh && su-exec sfserver bash linuxgsm.sh sfserver

# Add files
ADD install.sh user.sh /home/sfserver/
ADD scripts /home/sfserver/scripts
ADD lgsm/config-lgsm/sfserver/common.cfg /home/sfserver/
ADD lgsm /home/sfserver/lgsm

# Apply permissions
RUN chmod +x install.sh user.sh

##############EXTRA CONFIG##############
#Ports
EXPOSE 26900 26900/UDP 26901/UDP 26902/UDP 8082 8081 8080
#Shared folders to host
VOLUME /home/sfserver/serverfiles/ /home/sfserver/log/ /home/sfserver/lgsm/backup/ /home/sfserver/lgsm/config-lgsm/sfserver/
##############EXTRA CONFIG##############
ENTRYPOINT ["/home/sfserver/user.sh", "/home/sfserver/install.sh"]
