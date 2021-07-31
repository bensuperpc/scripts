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
#//  Created: 31, July, 2021                                 //
#//  Modified: 31, July, 2021                                //
#//  file: https://gist.github.com/jhamfler/cb21414d70696ba4a8957db80f186374                                                 //
#//  -                                                       //
#//  Source: -                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

# --highlight-users
if (( $# == 1 )); then
    gource --multi-sampling --output-framerate 60 --seconds-per-day 3.0 --auto-skip-seconds 0.2 ./ -1920x1080 -o - | ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - -vcodec libx265 -preset slow -pix_fmt yuv420p -crf 21 -bf 0 "$1"
else
    echo "Usage: ${0##*/} <ouput file>"
    exit 1
fi
