#!/bin/bash
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
#//  Created: 27, May, 2021                                  //
#//  Modified: 27, May, 2021                                 //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: -                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////
echo "copy..."
sudo mkdir -p /usr/bin/ben_script && sudo cp -a . /usr/bin/ben_script
echo "copy done"
echo "create symlink..."
find /usr/bin/ben_script -type f -name "*.sh" ! -path "./git/*" ! -path "*/install.sh" ! -path "*/uninstall.sh" -exec sudo ln -s {} /usr/bin \;
echo "create symlink done"
echo "work done"
