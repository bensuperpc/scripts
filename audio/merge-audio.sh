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
#//  Created: 28, September, 2021                            //
#//  Modified: 28, September, 2021                           //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: https://superuser.com/a/587553/1057976                                                //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

if (($# == 3)); then
    ffmpeg -i "$1" -i "$2" \
        -filter_complex '[0:0][1:0]concat=n=2:v=0:a=1[out]' \
        -map '[out]' "$3"
elif (($# == 4)); then
    ffmpeg -i "$1" -i "$2" -i "$3" \
        -filter_complex '[0:0][1:0][2:0]concat=n=3:v=0:a=1[out]' \
        -map '[out]' "$4"
elif (($# == 5)); then
    ffmpeg -i "$1" -i "$2" -i "$3" -i "$4" \
        -filter_complex '[0:0][1:0][2:0][3:0]concat=n=4:v=0:a=1[out]' \
        -map '[out]' "$5"
else
    echo "Usage: ${0##*/} <input audio file 1> <input audio file 2> <output audio file>"
    echo "Usage: ${0##*/} <input audio file 1> <input audio file 2> <input audio file 3> <output audio file>"
    echo "Usage: ${0##*/} <input audio file 1> <input audio file 2> <input audio file 3> <input audio file 4> <output audio file>"
    exit 1
fi
