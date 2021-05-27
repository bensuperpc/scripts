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
#//  Created: 21, November, 2020                             //
#//  Modified: 21, November, 2020                            //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: -                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////
if (( $# < 3 )); then
    sudo cryptsetup -v --type luks --cipher aes-xts-plain64 --key-size 512 --hash sha512 --iter-time 2000 --use-urandom --verify-passphrase luksFormat --label=$2 $1
    sudo cryptsetup luksOpen $1 test
    sudo mkfs.btrfs /dev/mapper/test
    sudo mkfs.btrfs -f --label $2 /dev/mapper/test
    sudo cryptsetup luksClose test
fi
