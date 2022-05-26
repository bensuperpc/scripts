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
#//  Modified: 26, September, 2021                           //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: https://superuser.com/questions/1236275/how-can-i-use-crf-encoding-with-nvenc-in-ffmpeg/1236387#1236387                                               //
#//          https://superuser.com/questions/1633516/convert-ffmpeg-encoding-from-libx264-to-h264-nvenc/1650962#1650962
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

if (( $# == 2 )); then
    ffmpeg -strict 2 \
        -i "$1" \
        -c:v hevc_nvenc \
        -gpu:v 0 \
        -tier:v high \
        -preset:v p7 \
        -tune:v hq \
        -rc:v vbr \
        -cq:v 14 \
        -b:v 0 -minrate:v 1M -maxrate:v 100M -bufsize:v 400M \
        -bf:v 3 -b_ref_mode:v middle \
        -c:a copy -map 0 "$2"
fi
#-filter:v hwupload_cuda,scale_npp=w=1920:h=1080:interp_algo=lanczos