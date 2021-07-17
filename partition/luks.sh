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
#//  Script, 2020                                            //
#//  Created: 20, June, 2020                                 //
#//  Modified: 16, July, 2020                                //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: -                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

if [[ "$EUID" = 0 ]]; then
    echo "(1) already root"
else
    sudo -k # make sure to ask for password on next sudo
    if sudo true; then
        echo "(2) correct password"
    else
        echo "(3) wrong password"
        exit 1
    fi
fi

if (( $# == 2 )); then
    UUID=$(uuidgen)
    echo "UUID: ${UUID}"
    umount $1 || true
    sudo cryptsetup -v --type luks --cipher aes-xts-plain64 --key-size 512 --hash sha512 --iter-time 1000 --use-urandom --verify-passphrase luksFormat --label=$2 $1
    sudo cryptsetup luksOpen $1 ${UUID}
    sudo mkfs.btrfs --force --checksum crc32c --label $2 /dev/mapper/${UUID}
    sudo cryptsetup luksClose ${UUID}
    echo "Partition: OK"
    echo "Now you can unplug, replug device and use it :) "
else
    echo "Usage: ${0##*/} <Device> <Label>"
    exit 1
fi
