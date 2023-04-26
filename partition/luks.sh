#!/usr/bin/env bash
set -e
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
#//  Modified: 26, April, 2023                               //
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

    UUID=$(uuidgen)
    echo "UUID: ${UUID}"

    SECTORSIZESIZE=$(sudo blockdev --getpbsz "$PARTITION")
    echo "Sector size: ${SECTORSIZESIZE}"

    echo "Unmount partition..."
    sudo umount "$PARTITION" || true

    # head -c 512 /dev/random > KEYFILE
    # cryptsetup luksAddKey --key-file /chemin/vers/nouveau_keyfile /dev/sdb1
    # --integrity hmac-sha512

    echo "Create LUKS2 partition..."
    sudo cryptsetup -v --type luks2 --pbkdf argon2id --key-slot 0 \
        --cipher aes-xts-plain64 --key-size 512 --hash sha512 --sector-size "${SECTORSIZESIZE}" \
        --iter-time 5000 --use-urandom --verify-passphrase luksFormat --label="$LABEL" "$PARTITION"
    
    echo "Backup header: $LABEL-luks_header_backup"
    rm -f "$LABEL-luks_header_backup" || true
    sudo cryptsetup luksHeaderBackup "$PARTITION" --header-backup-file "$LABEL-luks_header_backup"

    echo "Add keyfile..."
    rm -f "keyfile-$LABEL" || true
    dd if=/dev/urandom of="keyfile-$LABEL" bs=512 count=1
    sudo cryptsetup luksAddKey --keyslot-cipher aes-xts-plain64 --keyslot-key-size 512 --hash sha512 \
        --key-slot 1 --pbkdf argon2id --iter-time 5000 "$PARTITION" "keyfile-$LABEL"
    echo "Test keyfile..."
    sudo cryptsetup open --test-passphrase --key-file "keyfile-$LABEL" "$PARTITION"
    # echo "Remove keyfile..."
    # sudo cryptsetup luksRemoveKey "$PARTITION" "keyfile-$LABEL"
    
    echo "Open partition..."
    sudo cryptsetup --type luks open --allow-discards "$PARTITION" "${UUID}"

    echo "Format partition with BTRFS..."
    sudo mkfs.btrfs --force --checksum blake2 --label "$LABEL" "/dev/mapper/${UUID}"

    #echo "Chown partition: $USER:$GROUP"
    #sudo chown -R $USER:$GROUP "$PARTITION" "/dev/mapper/${UUID}"
    
    echo "Close partition..."
    sudo cryptsetup --type luks close "${UUID}"

    sudo cryptsetup luksDump "$PARTITION"

    echo "Now you can unplug, replug device and use it :) "
else
    echo "Usage: ${0##*/} <Device> <Label>"
    exit 1
fi
