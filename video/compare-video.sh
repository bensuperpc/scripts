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
#//  Source: https://stackoverflow.com/a/29504397/10152334                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////


type ffmpeg >/dev/null 2>&1 || { echo "ffmpeg could not be found" >&2; exit 1; }

if (( $# == 2 )); then
    ffmpeg -i "$1" -i "$2" -filter_complex "psnr" -f null /dev/null
    ffmpeg -i "$1" -i "$2" -filter_complex "ssim" -f null /dev/null
else
    echo "Usage: ${0##*/} <file 1> <file 2>"
    exit 1
fi
