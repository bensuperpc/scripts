#!/bin/bash
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
#//  Created: 15, July, 2021                                 //
#//  Modified: 24, July, 2021                                //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: https://github.com/dockcross/dockcross                                                //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////
if (( $# == 2 )); then
    image=$1
    build_file=build-${image%:*}
    shift 1
    cmake_arg=$@
    echo "cmake arg: $cmake_arg"

    echo "Pulling dockcross/$image"
    docker pull dockcross/$image
    echo "Make script dockcross-$image"
    docker run --rm dockcross/$image > ./dockcross-$image
    chmod +x ./dockcross-$image
    echo "Build $build_file"
    ./dockcross-$image cmake -B$build_file -H. -GNinja $cmake_arg
    ./dockcross-$image ninja -C$build_file
else
    echo "Usage: ${0##*/} <docker imag (ex: linux-x64/linux-arm64...)> <cmake arg.>"
    exit 1
fi
