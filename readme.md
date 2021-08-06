# Counter Strike: Global Offensive
              
The following repository contains the source files for building a CSGO server.


### Running
To run the container, issue the following example command:
```
docker run -d \
-p 27015:27015/udp \
-p 27015:27015/tcp \
-e CSGO_SERVER_HOSTNAME="DOCKER CSGO" \
netwarlan/csgo
```

### Environment Variables
We can make dynamic changes to our CSGO containers by adjusting some of the environment variables passed to our image.
Below are the ones currently supported and their (defaults):

```
CSGO_SERVER_PORT (27015)
CSGO_SERVER_MAXPLAYERS (16)
CSGO_SERVER_MAP (de_dust2)
CSGO_SERVER_HOSTNAME (CSGO Server)
CSGO_SERVER_PW (No password set)
CSGO_SERVER_RCONPW (No password set)
CSGO_SERVER_TICKRATE (128)
CSGO_SERVER_UPDATE_ON_START (false)
CSGO_SERVER_GAME_TYPE (0)
CSGO_SERVER_GAME_MODE (0)
CSGO_SERVER_MAPGROUP (mg_active)
CSGO_SERVER_ENABLE_REMOTE_CFG (false)
CSGO_SERVER_REMOTE_CFG (n/a)

```

#### Descriptions

* `CSGO_SERVER_PORT` Determines the port our container runs on.
* `CSGO_SERVER_MAXPLAYERS` Determines the max number of players the * server will allow.
* `CSGO_SERVER_MAP` Determines the starting map.
* `CSGO_SERVER_HOSTNAME` Determines the name of the server.
* `CSGO_SERVER_PW` Determines the password needed to join the server.
* `CSGO_SERVER_RCONPW` Determines the RCON password needed to administer the server.
* `CSGO_SERVER_TICKRATE` Sets the servers tickrate.
* `CSGO_SERVER_UPDATE_ON_START` Determines whether the server should update itself to latest when the container starts up.
* `CSGO_SERVER_GAME_TYPE` Sets the Game Type.
* `CSGO_SERVER_GAME_MODE` Sets the Game Mode.
* `CSGO_SERVER_MAPGROUP` Sets the Map Group
* `CSGO_SERVER_ENABLE_REMOTE_CFG` Enables the option of downloading a remote server config (Useful for large changes to server.cfg)
* `CSGO_SERVER_REMOTE_CFG` URL of remote CFG (Only available when CSGO_SERVER_ENABLE_REMOTE_CFG is set to "true")


### Competitive Play
Recommended values for competitive play:
```
CSGO_SERVER_MAXPLAYERS="10"
CSGO_SERVER_TICKRATE="128"
CSGO_SERVER_GAME_TYPE="0"
CSGO_SERVER_GAME_MODE="1"
```
