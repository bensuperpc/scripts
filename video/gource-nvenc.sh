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
#//  Modified: 29, September, 2021                           //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: https://gist.github.com/rafi/365926                                               //
#//          https://superuser.com/a/1296511/1057976
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

if (($# == 1)); then
    git_url=$(git config --get remote.origin.url)
    # -2560x1440 # If not --fullscreen # --date-format "%Y-%m-%d" --elasticity 0.1 --max-user-speed 500
    # FFMPEG -pix_fmt yuv420p yuvj420p rgb0
    gource --fullscreen --disable-input --multi-sampling --output-framerate 60 --seconds-per-day 0.1 \
        --hide mouse --filename-time 2 --max-files 0 --bloom-multiplier 0.8 --highlight-users --file-extension-fallback --path . \
        --auto-skip-seconds 0.1 --background-colour 000000 --key --stop-at-end --title "$git_url" --output-ppm-stream - | ffmpeg -y -r 60 \
        -f image2pipe -vcodec ppm -i - -vcodec hevc_nvenc \
        -bf:v 3 -rc-lookahead:v 32 -refs:v 16 -b_ref_mode:v middle \
        -pix_fmt rgb0 -preset:v p7 -tune:v hq -rc:v vbr -cq:v 10 -b:v 0 -minrate:v 1M -maxrate:v 400M -bufsize:v 800M "$1"
else
    echo "Usage: ${0##*/} <ouput file>"
    exit 1
fi
