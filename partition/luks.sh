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
#//  Created: 20, June, 2020                                 //
#//  Modified: 28, July, 2021                                //
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
    PARTITION=$1
    LABEL=$2
    shift 2

    if [ $# -eq 0 ]; then
        read -r -p "you are going to format a partition/device with LUKS and BTRFS.
        All data on the partition/devices will be erased ! Do you want to continue ? [Y/n]: " answ
        if [ "$answ" == 'n' ]; then
            exit 1
        fi
    fi

    UUID=$(uuidgen)
    echo "UUID: ${UUID}"
    sudo umount "$PARTITION" || true
    sudo cryptsetup -v --type luks2 --pbkdf argon2id --cipher aes-xts-plain64 --key-slot 1 --key-size 512 --integrity hmac-sha512 --hash sha512 --iter-time 2000 --use-urandom --verify-passphrase luksFormat --label="$LABEL" "$PARTITION"
    sudo cryptsetup luksHeaderBackup "$PARTITION" --header-backup-file "$LABEL-luks_header_backup"
    
    sudo cryptsetup -v luksOpen "$PARTITION" "${UUID}"
    sudo mkfs.btrfs --force --checksum blake2 --label "$LABEL" "/dev/mapper/${UUID}"

    # sudo chown -R $USER:$GROUP "$PARTITION"
    
    sudo cryptsetup -v luksClose "${UUID}"
    echo "Partition: OK"
    echo "Now you can unplug, replug device and use it :) "
else
    echo "Usage: ${0##*/} <Device> <Label>"
    exit 1
fi
