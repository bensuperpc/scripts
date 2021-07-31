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

readonly VERSION="1.0.0"

DS_version() {
    echo "screen-capture $VERSION"
}

# Values can by override
ENCODING_LIB=${ENCODING_LIB:-libx264}
RESOLUTION=${RESOLUTION:-1920x1080}
FRAMERATE=${FRAMERATE:-60}
SCREEN=${SCREEN:-:0}
QUALITY=${QUALITY:-0}
PRESET=${PRESET:-ultrafast}
OUTPUT=${OUTPUT:-screen_capture.mkv}
PIXEL=${PIXEL:-yuv444p}

TESTS=${TESTS:-none}
COPY=${COPY:-true}

DS_check() {
    type ffmpeg >/dev/null 2>&1 || { echo "ffmpeg could not be found" >&2; exit 1; }
}

DS_help() {
    echo "Usage: ${0##*/} --output <output file>"
    echo "Others option:
    --lib libx264 or libx265
    --resolution 1920x1080
    --framerate 60
    --quality 0
    --screen :0
    --preset ultrafast, fast, slow...
    --pixel yuv444p
    -h or --help
    -v or --version"
    exit 0
}


DS_main() {
    if [[ -z $* ]]; then
        DS_version
        DS_help
        exit 0
    fi
  
    while [[ $# -gt 0 ]] && ([[ "$1" == "--"* ]] || [[ "$1" == "-"* ]]) ;
    do
        opt="$1";
        echo "opt: $opt"
        shift; 
        case "$opt" in
            "--lib" )
            ENCODING_LIB="$1"; shift;;
            "--test="* )     # alternate format: --first=date
            TESTS="${opt#*=}";;
            "--screen" )
            SCREEN="$1"; shift;;
            "--framerate" )
            FRAMERATE="$1"; shift;;
            "--quality" )
            QUALITY="$1"; shift;;
            "--preset" )
            PRESET="$1"; shift;;
            "--pixel" )
            PIXEL="$1"; shift;;
            "--resolution" )
            RESOLUTION="$1"; shift;;
            "--output" )
            OUTPUT="$1"; shift;;
            "--help" | "-h" )
            DS_help;;
            "--version" | "-v" )
            DS_version;;
            "--copy" )
            COPY=true;;
            *) echo >&2 "Invalid option: $*"; exit 1;;
    esac
    done
    DS_check
    DS_exec
}

DS_exec() {
    ffmpeg -f x11grab -video_size "$RESOLUTION" -framerate "$FRAMERATE" -i "$SCREEN" \
    -vcodec "$ENCODING_LIB" -preset "$PRESET" -qp "$QUALITY" -pix_fmt "$PIXEL" \
    "$OUTPUT"
    
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
  DS_main "$@"
fi
