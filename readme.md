Counter-Striek Global Offensive
===============================

The following repo contains the source files for building a Counter-Strike: Global Offensive server.

Running the conatiner
---------------------

To run the container, issue the following comand:
```
docker run -d \
-p 27015:27015/tcp \
-p 27015:27015/udp \
netwarlan/csgo
```