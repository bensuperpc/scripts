#!/usr/bin/env bash
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
#//  Created: 28, May, 2021                                  //
#//  Modified: 24, July, 2021                                 //
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
    echo "Usage: ${0##*/} <file to check>"
    exit 1
fi

#TYPE=sha512
#less -f checksums.${TYPE} | parallel --pipe -N100 -j "$(nproc)" ${TYPE}sum --quiet -c -

TYPE=sha3-512
less -f checksums."${TYPE}" | parallel --pipe -N100 -j "$(nproc)" rhash --"${TYPE}" -c -
echo "OK"
