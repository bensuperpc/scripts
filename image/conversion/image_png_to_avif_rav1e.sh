#!/usr/bin/env bash
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
#//  Modified: 18, November, 2023                            //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: -                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////
#Convert png to Webp
find . -name "*.png" | parallel -eta avifenc -c rav1e --speed 3 --lossless "{}" -o "{.}.avif"
find . -name "*.png" | parallel -eta avifenc -c rav1e --speed 3 --lossless "{}" -o "{.}.avif"
#Copy atime and mtime
find . -name "*.png" -exec sh -c 'touch -r "${0%.*}.png" "${0%.*}.avif"' "{}" ';'
find . -name "*.png" -exec sh -c 'touch -r "${0%.*}.png" "${0%.*}.avif"' "{}" ';'
