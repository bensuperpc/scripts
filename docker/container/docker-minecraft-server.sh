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

if [ $# -eq 0 ]
then
    echo "No arguments supplied"
    exit 1
fi

docker run -d -v $1:/data \
    -e TYPE=PAPER -e MEMORY=2G \
    -p 25565:25565 -e EULA=TRUE \
    -e ALLOW_NETHER=true -e DIFFICULTY=hard \
    -e SERVER_PORT=25566 -e ENABLE_COMMAND_BLOCK=true \
    -e USE_AIKAR_FLAGS=true -e MOTD="My Server" \
    --name mc itzg/minecraft-server
