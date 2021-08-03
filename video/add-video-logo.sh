#!/usr/bin/env bash
set -euo pipefail
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
#//  Created: 02, August, 2021                               //
#//  Modified: 03, August, 2021                              //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: https://arccoder.medium.com/ffmpeg-add-a-logo-on-video-bf1f4652792a                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////


type ffmpeg >/dev/null 2>&1 || { echo "ffmpeg could not be found" >&2; exit 1; }

if (( $# == 5 )); then
    ffmpeg -i "$1" -i "$2" -filter_complex "overlay='$3':'$4'" "$5" \
        -c:v libx264 -crf 18 -bf 2 -profile:v high -c:a copy 
else
    echo "Usage: ${0##*/} <input video> <logo> <overlay X (from from the top-left)> <overlay Y (from from the top-left)> <output>"
    exit 1
fi
