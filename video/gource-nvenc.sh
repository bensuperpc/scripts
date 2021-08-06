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
#//  Modified: 24, July, 2021                                //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: -                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

if (( $# == 1 )); then
    #gource --multi-sampling --output-framerate 60 --seconds-per-day 2.0 --auto-skip-seconds 0.1 ./ -1920x1080 -o - | ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - -vcodec hevc_nvenc -preset slow -b:v 64M -maxrate 96M -bufsize 384M $1
    gource --multi-sampling --output-framerate 60 --seconds-per-day 1.0 \
    --auto-skip-seconds 0.2 ./ -1920x1080 -o - | ffmpeg -y -r 60 \
    -f image2pipe -vcodec ppm -i - -vcodec hevc_nvenc -rc vbr_hq -cq 6 "$1"
else
    echo "Usage: ${0##*/} <ouput file>"
    exit 1
fi
