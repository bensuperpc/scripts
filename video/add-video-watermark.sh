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

if (( $# == 3 )); then
    ffmpeg -i "$1" -vf "drawtext=text='$2':fontcolor=white@1.0:fontsize=26: \
        box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/1.0625:y=(h-text_h)/1.0625" \
        -c:v libx264 -crf 18 -preset slow -pix_fmt yuv420p \
        -bf 2 -profile:v high -c:a copy "$3"
else
    echo "Usage: ${0##*/} <input video> <text> <output>"
    exit 1
fi
