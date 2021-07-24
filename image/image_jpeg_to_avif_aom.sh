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
#//  Script, 2020                                            //
#//  Created: 20, December, 2020                             //
#//  Modified: 24, July, 2021                                //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: -                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////
#Convert jpeg to Webp
find . -name "*.jpeg" | parallel -eta avifenc -c aom -l -s 8 {} -o {.}.avif
find . -name "*.jpg" | parallel -eta avifenc -c aom -l -s 8 {} -o {.}.avif
#Copy atime and mtime
find . -name "*.jpeg" -exec sh -c 'touch -r "${0%.*}.jpeg" "${0%.*}.avif"' {} ';'
find . -name "*.jpg" -exec sh -c 'touch -r "${0%.*}.jpeg" "${0%.*}.avif"' {} ';'

