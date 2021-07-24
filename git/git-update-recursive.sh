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
#//  Created: 15, July, 2021                                 //
#//  Modified: 20, July, 2021                                //
#//  file: -                                                 //
#//  -                                                       //
#//  Source:                                                 //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

git_directory=$(find . -name .git -type d)
date_now=$(date +"%Y%m%d%H%M")
mkdir -p log/

echo "$git_directory" | xargs -n1 -P$(nproc) -I% git --git-dir=% --work-tree=%/.. fetch --jobs=2 --all --recurse-submodules --force --multiple --progress 2>&1 | tee -a log/log-${date_now}.txt
echo "$git_directory" | xargs -n1 -P$(nproc) -I% git --git-dir=% --work-tree=%/.. reset --hard --recurse-submodules HEAD 2>&1 | tee -a log/log-${date_now}.txt
echo "$git_directory" | xargs -n1 -P$(nproc) -I% git --git-dir=% --work-tree=%/.. pull --jobs=2 --all --recurse-submodules --force --progress 2>&1 | tee -a log/log-${date_now}.txt

#git clone --recurse-submodules --remote-submodules https://github.com/TheAlgorithms/Python.git
