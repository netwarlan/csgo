FROM centos:latest

## Update our container and install a few packages
RUN yum update -y \
    && yum install -y \
       gdb \
       glibc.i686 \
       libcurl.i686 \
       libgcc.i686 \
       libgcc.x86_64 \
       ncompress \
       ncurses-libs.i686 \
       zlib.i686 \
    && yum clean all

## Create Environment Variables
## Game Specific
ENV GAME="csgo" \
    USER="steam" \
    GAME_DIR="/docker/csgo" \

## SteamCMD Specific
    STEAMCMD_APP="740" \
    STEAMCMD_USER="anonymous" \
    STEAMCMD_PASSWORD="" \
    STEAMCMD_AUTH_CODE="" \
    STEAMCMD_DIR="/docker/steamcmd"

## Setup USER and HOME directory
RUN useradd -m -d /docker $USER -s /bin/bash \

## Fix library name issue (Ubuntu vs CentOS)
    && ln -s /usr/lib/libcurl.so.4 /usr/lib/libcurl-gnutls.so.4

## Change USER
USER $USER

## Create base folders
RUN mkdir -p $GAME_DIR \
    && mkdir -p $STEAMCMD_DIR \

    ## Download SteamCMD
    && curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -xzC $STEAMCMD_DIR \
    && $STEAMCMD_DIR/steamcmd.sh \
        +login $STEAMCMD_USER $STEAMCMD_PASSWORD $STEAMCMD_AUTH_CODE \
        +force_install_dir $GAME_DIR \
        +app_update $STEAMCMD_APP validate \
        +quit \

    ## Create Scripting for the game
    && echo '#!/bin/bash' > $GAME_DIR/start.sh \
    && echo './srcds_run -game $GAME -console -usercon $@' >> $GAME_DIR/start.sh \

    ## Create symlinks and appdata for Steam
    && mkdir -p ~/.steam/sdk32 \
    && ln -s $GAME_DIR/bin/steamclient.so ~/.steam/sdk32/steamclient.so \
    && echo "$STEAMCMD_APP" > $GAME_DIR/steam_appid.txt \

    ## Flatten permissions
    && chmod -R ug+rwx ~

## Set working directory and normal start up process
WORKDIR $GAME_DIR

## Start here
ENTRYPOINT ["./start.sh"]
CMD ["+game_type", "0", "+game_mode", "0", "+mapgroup", "mg_active", "+map", "de_dust2"]