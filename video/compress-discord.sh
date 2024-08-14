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
ARG3=${3:-"0"}
ARG4=${4:-"4"}
ARG5=${5:-"250K"}
ARG6=${6:-"8M"}


if (( $# >= 2 )); then
    ffmpeg -loglevel debug -threads 1 -hwaccel cuvid \
    -hwaccel_output_format cuda -i "$ARG1" \
    -filter:v scale_cuda=w=1920:h=1080:interp_algo=lanczos \
    -c:v hevc_nvenc -b:v 4M -maxrate:v 5M -bufsize:v 8M -profile:v main \
    -level:v 4.1 -rc:v vbr -preset:v p7 -tune:v hq -rc-lookahead:v 32 -refs:v 16 \
    -bf:v 3 -coder:v cabac -b_ref_mode:v middle \
    -f mp4 "$ARG2"
else
    echo "Usage: ${0##*/} <input video> <output video>"
    echo "Optional: <constant quality 0-51)> <bitrate (0-800M)> <min bitrate (1M-800M)> <max bitrate (1M-800M)>"
    exit 1
fi

