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
#//  Source: https://superuser.com/questions/1236275/how-can-i-use-crf-encoding-with-nvenc-in-ffmpeg/1236387#1236387                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

if (( $# == 2 )); then
    # Old CUDA version
    #ffmpeg -strict 2 -hwaccel auto -i "$1"  -c:v hevc_nvenc -preset slow -rc vbr_hq -cq 18 -qmin 16 -qmax 20 -profile:v main10 -b:v 0K -c:a copy -map 0 "$2"
    ffmpeg -strict 2 -i "$1" -c:v hevc_nvenc -preset:v p7 -tune:v hq -rc:v vbr -cq:v 18 -b:v 0 -c:a copy -map 0 "$2"
fi
