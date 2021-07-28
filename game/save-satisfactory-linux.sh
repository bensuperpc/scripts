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

Save_path="$HOME/.local/share/Steam/steamapps/compatdata/526870/pfx/drive_c/users/steamuser/Local Settings/Application Data/FactoryGame/Saved/"

Z_OPT="-T0 -e9" tar cJvf satisfactory-"$(date +%Y-%m-%d_%H_%M_%S)".tar.xz -C "$Save_path" SaveGames/
