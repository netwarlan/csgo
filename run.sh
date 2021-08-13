#!/usr/bin/env bash

echo "


╔═══════════════════════════════════════════════╗
║                                               ║
║       _  _____________      _____   ___       ║
║      / |/ / __/_  __/ | /| / / _ | / _ \      ║
║     /    / _/  / /  | |/ |/ / __ |/ , _/      ║
║    /_/|_/___/ /_/   |__/|__/_/ |_/_/|_|       ║
║                                 OFFICIAL      ║
║                                               ║
╠═══════════════════════════════════════════════╣
║ Thanks for using our DOCKER image! Should you ║
║ have issues, please reach out or create a     ║
║ github issue. Thanks!                         ║
║                                               ║
║ For more information:                         ║
║ github.com/netwarlan                          ║
╚═══════════════════════════════════════════════╝
"


## Set default values if none were provided
## ==============================================
[[ -z "$CSGO_SERVER_PORT" ]] && CSGO_SERVER_PORT="27015"
[[ -z "$CSGO_SERVER_MAXPLAYERS" ]] && CSGO_SERVER_MAXPLAYERS="16"
[[ -z "$CSGO_SERVER_MAP" ]] && CSGO_SERVER_MAP="de_dust2"
[[ -z "$CSGO_SVLAN" ]] && CSGO_SVLAN="0"
[[ -z "$CSGO_SERVER_HOSTNAME" ]] && CSGO_SERVER_HOSTNAME="CSGO Server"
[[ ! -z "$CSGO_SERVER_PW" ]] && CSGO_SERVER_PW="sv_password $CSGO_SERVER_PW"
[[ ! -z "$CSGO_SERVER_RCONPW" ]] && CSGO_SERVER_RCONPW="rcon_password $CSGO_SERVER_RCONPW"
[[ -z "$CSGO_SERVER_GAME_TYPE" ]] && CSGO_SERVER_GAME_TYPE="0"
[[ -z "$CSGO_SERVER_GAME_MODE" ]] && CSGO_SERVER_GAME_MODE="0"
[[ -z "$CSGO_SERVER_MAPGROUP" ]] && CSGO_SERVER_MAPGROUP="mg_active"
[[ -z "$CSGO_SERVER_ENABLE_REMOTE_CFG" ]] && CSGO_SERVER_ENABLE_REMOTE_CFG=false
[[ -z "$CSGO_SERVER_UPDATE_ON_START" ]] && CSGO_SERVER_UPDATE_ON_START=true
[[ -z "$CSGO_SERVER_VALIDATE_ON_START" ]] && CSGO_SERVER_VALIDATE_ON_START=false
[[ -z "$CSGO_SERVER_TICKRATE" ]] && CSGO_SERVER_TICKRATE="128"



## Update on startup
## ==============================================
if [[ "$CSGO_SERVER_UPDATE_ON_START" = true ]] || [[ "$CSGO_SERVER_VALIDATE_ON_START" = true ]]; then
echo "
╔═══════════════════════════════════════════════╗
║ Checking for updates                          ║
╚═══════════════════════════════════════════════╝
"
  if [[ "$CSGO_SERVER_VALIDATE_ON_START" = true ]]; then
    VALIDATE_FLAG='validate'
  else 
    VALIDATE_FLAG=''
  fi

  $STEAMCMD_DIR/steamcmd.sh \
  +login $STEAMCMD_USER $STEAMCMD_PASSWORD $STEAMCMD_AUTH_CODE \
  +force_install_dir $GAME_DIR \
  +app_update $STEAMCMD_APP $VALIDATE_FLAG \
  +quit

fi


## Download config if needed
## ==============================================
if [[ "$CSGO_SERVER_ENABLE_REMOTE_CFG" = true ]]; then
echo "
╔═══════════════════════════════════════════════╗
║ Downloading remote config                     ║
╚═══════════════════════════════════════════════╝
"
  ## Check if we are casual or competitive gamemode
  if [[ "$CSGO_SERVER_GAME_MODE" -eq "0" ]]; then
    echo "  Downloading Casual config..."
    wget -q $CSGO_SERVER_REMOTE_CFG -O $GAME_DIR/csgo/cfg/gamemode_casual_server.cfg

  elif [[ "$CSGO_SERVER_GAME_MODE" -eq "1" ]]; then
    echo "  Downloading Competitive config..."
    wget -q $CSGO_SERVER_REMOTE_CFG -O $GAME_DIR/csgo/cfg/gamemode_competitive_server.cfg
  fi

fi



## Build server config
## ==============================================
echo "
╔═══════════════════════════════════════════════╗
║ Building server config                        ║
╚═══════════════════════════════════════════════╝
"
cat <<EOF >> $GAME_DIR/csgo/cfg/server.cfg
// Values passed from Docker environment
$CSGO_SERVER_PW
$CSGO_SERVER_RCONPW
EOF


## Run
## ==============================================
echo "
╔═══════════════════════════════════════════════╗
║ Starting SERVER                               ║
╚═══════════════════════════════════════════════╝
  Hostname: $CSGO_SERVER_HOSTNAME
  Port: $CSGO_SERVER_PORT
  Max Players: $CSGO_SERVER_MAXPLAYERS
  Map: $CSGO_SERVER_MAP
  Game Type: $CSGO_SERVER_GAME_TYPE
  Game Mode: $CSGO_SERVER_GAME_MODE
  Map Group: $CSGO_SERVER_MAPGROUP
  Tickrate: $CSGO_SERVER_TICKRATE
"
$GAME_DIR/srcds_run -game csgo -console -usercon +hostname \"${CSGO_SERVER_HOSTNAME}\" +game_type $CSGO_SERVER_GAME_TYPE +game_mode $CSGO_SERVER_GAME_MODE +mapgroup $CSGO_SERVER_MAPGROUP +port $CSGO_SERVER_PORT -maxplayers_override $CSGO_SERVER_MAXPLAYERS +map $CSGO_SERVER_MAP +sv_lan $CSGO_SVLAN -tickrate $CSGO_SERVER_TICKRATE