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
#//  file: -                                                 //
#//  -                                                       //
#//  Source: https://unix.stackexchange.com/a/334148/359833                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////


type ffmpeg >/dev/null 2>&1 || { echo "ffmpeg could not be found" >&2; exit 1; }

if (( $# == 1 )); then
    ffmpeg -f x11grab -thread_queue_size 64 -video_size 1920x1080 -framerate 60 -i :0 \
       -f v4l2 -thread_queue_size 64 -video_size 720x480 -framerate 30 -i /dev/video0 \
       -filter_complex 'overlay=main_w-overlay_w:main_h-overlay_h:format=yuv444' \
       -vcodec libx264 -preset ultrafast -qp 0 -pix_fmt yuv444p \
       "$1"
else
    echo "Usage: ${0##*/} <output file>"
    exit 1
fi

