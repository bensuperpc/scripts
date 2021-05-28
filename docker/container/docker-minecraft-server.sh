#!/bin/bash
#//////////////////////////////////////////////////////////////
#//   ____                                                   //
#//  | __ )  ___ _ __  ___ _   _ _ __   ___ _ __ _ __   ___  //
#//  |  _ \ / _ \ '_ \/ __| | | | '_ \ / _ \ '__| '_ \ / __| //
#//  | |_) |  __/ | | \__ \ |_| | |_) |  __/ |  | |_) | (__  //
#//  |____/ \___|_| |_|___/\__,_| .__/ \___|_|  | .__/ \___| //
#//                             |_|             |_|          //
#//////////////////////////////////////////////////////////////
#//                                                          //
#//  Script, 2021                                            //
#//  Created: 27, May, 2021                                  //
#//  Modified: 27, May, 2021                                 //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: -                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

CONTAINER_NAME=$1
VOLUME_NAME=$2

usage() {
  echo "Usage: $0 [container name] [volume name or path]"
  exit 1
}

if [ -z $CONTAINER_NAME ]
then
  echo "Error: missing container/volume name parameter."
  usage
fi
#-e ENABLE_RCON=false -e RCON_PASSWORD=minecraft -e RCON_PORT=28016 \
docker run -d -v ${VOLUME_NAME}:/data \
    -e TYPE=PAPER -e MEMORY=4G -e ONLINE_MODE=true \
    -e OPS=Bensuperpc -e OVERRIDE_SERVER_PROPERTIES=true \
    -e BUILD_FROM_SOURCE=false -e VERSION=1.16.5 \
    -e SPIGET_RESOURCES=9089,34315 \
    -p 25565:25565 -e EULA=true -e EXEC_DIRECTLY=false \
    -e SERVER_PORT=25565 -e LEVEL=world \
    -e ALLOW_NETHER=true -e DIFFICULTY=hard \
    -e MAX_PLAYERS=50 -e GENERATE_STRUCTURES=true \
    -e VIEW_DISTANCE=10 -e PVP=true -e LEVEL_TYPE=default \
    -e SERVER_PORT=25565 -e ENABLE_COMMAND_BLOCK=true \
    -e USE_AIKAR_FLAGS=true -e USE_LARGE_PAGES=false \
    -e ENABLE_AUTOPAUSE=false -e GUI=false \
    -e MOTD="My Server" \
    --name ${CONTAINER_NAME} itzg/minecraft-server:latest
