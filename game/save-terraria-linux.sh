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
#//  Created: 28, July, 2021                                 //
#//  Modified: 28, July, 2021                                //
#//  file: -                                                 //
#//  -                                                       //
#//  Source:                                                 //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

Save_path="$HOME/.local/share/"

Z_OPT="-T0 -e9" tar cJvf terraria-offline-"$(date +%Y-%m-%d_%H_%M_%S)".tar.xz -C "$Save_path" Terraria/

Save_path="$HOME/.local/share/Steam/userdata/"


for dir in "$Save_path"*; do
    Z_OPT="-T0 -e9" tar cJvf terraria-online-"$(basename "$dir")"-"$(date +%Y-%m-%d_%H_%M_%S)".tar.xz -C "$dir"/105600/ remote/
done
