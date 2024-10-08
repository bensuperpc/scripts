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
#//  Script, 2020                                            //
#//  Created: 21, November, 2020                             //
#//  Modified: 28, May, 2021                           //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: https://superuser.com/questions/1236275/how-can-i-use-crf-encoding-with-nvenc-in-ffmpeg/1236387#1236387                                               //
#//          https://superuser.com/questions/1633516/convert-ffmpeg-encoding-from-libx264-to-h264-nvenc/1650962#1650962
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

ARG1=${1:-"input.mp4"}
ARG2=${2:-"output.mp4"}
ARG3=${3:-"40"}
ARG4=${4:-"0"}
ARG5=${5:-"1M"}
ARG6=${6:-"100M"}


if (( $# >= 2 )); then
    ffmpeg -strict 2 \
        -i "$ARG1" \
        -c:v hevc_nvenc \
        -gpu:v 0 \
        -tier:v high \
        -preset:v p7 \
        -tune:v hq \
        -rc:v vbr \
        -cq:v "$ARG3" -b:v "$ARG4" \
        -minrate:v "$ARG5" -maxrate:v "$ARG6" -bufsize:v 800M \
        -c:a copy -map 0 "$ARG2"
else
    echo "Usage: ${0##*/} <input video> <output video>"
    echo "Optional: <constant quality 0-51)> <bitrate (0-800M)> <min bitrate (1M-800M)> <max bitrate (1M-800M)>"
    exit 1
fi

