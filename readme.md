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

Environment Variable | Default Value
-------------------- | -------------
CSGO_SERVER_PORT | 27015
CSGO_SERVER_MAXPLAYERS | 16
CSGO_SERVER_MAP | de_dust2
CSGO_SERVER_HOSTNAME | CSGO Server
CSGO_SERVER_PW | No password set
CSGO_SERVER_RCONPW | No password set
CSGO_SERVER_TICKRATE | 128
CSGO_SERVER_UPDATE_ON_START | true
CSGO_SERVER_VALIDATE_ON_START | false
CSGO_SERVER_GAME_TYPE | 0
CSGO_SERVER_GAME_MODE | 0
CSGO_SERVER_MAPGROUP | mg_active
CSGO_SERVER_ENABLE_REMOTE_CFG | false
CSGO_SERVER_REMOTE_CFG | n/a
CSGO_SERVER_GOTV_ENABLE | 0
CSGO_SERVER_GOTV_PORT | 27020


### Competitive Play
Recommended values for competitive play:

Environment Variable | Default Value
-------------------- | -------------
CSGO_SERVER_MAXPLAYERS | 10
CSGO_SERVER_TICKRATE | 128
CSGO_SERVER_GAME_TYPE | 0
CSGO_SERVER_GAME_MODE | 1
