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
#//  Created: 21, June, 2021                                 //
#//  Modified: 25, July, 2021                                //
#//  file: -                                                 //
#//  -                                                       //
#//  Source:                                                 //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

if (( $# == 0 )); then
    git format-patch -n HEAD^
elif (( $# == 1 )); then
    git format-patch HEAD~$1..HEAD --stdout > last-$1-commit.patch
elif (( $# == 2 )); then
    git diff "$1" "$2" -- > $1-$2.patch
else
    echo "Usage: ${0##*/} (patch HEAD)"
    echo "Usage: ${0##*/} <nbr from HEAD>"
    echo "Usage: ${0##*/} <tag or hash 1> <tag or hash 2>"
    exit 1
fi
