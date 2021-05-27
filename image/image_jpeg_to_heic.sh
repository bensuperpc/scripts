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
#//  Script, 2020                                            //
#//  Created: 20, december, 2020                             //
#//  Modified: 20, december, 2020                            //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: -                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////
#Convert jpeg to Webp
find . -name "*.jpeg" | parallel -eta magick {} -quality 95 {.}.heic
find . -name "*.jpg" | parallel -eta magick {} -quality 95 {.}.heic
#Copy atime and mtime
find . -name "*.jpeg" -exec sh -c 'touch -r "${0%.*}.jpeg" "${0%.*}.heic"' {} ';'
find . -name "*.jpg" -exec sh -c 'touch -r "${0%.*}.jpeg" "${0%.*}.heic"' {} ';'

#find ./png -type f -name "*.heic" -exec mv {} ./heic_loss_80 \;
