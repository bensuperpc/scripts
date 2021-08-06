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
#//  Script, 2021                                            //
#//  Created: 25, July, 2021                                 //
#//  Modified: 27, July, 2021                                //
#//  file: -                                                 //
#//  -                                                       //
#//  Source:  https://medium.com/@bn121rajesh/rsa-sign-and-verify-using-openssl-behind-the-scene-bf3cac0aade2                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

# Values can by override
CHECKSUM_TYPE_RHASH=${CHECKSUM_TYPE_RHASH:-sha3-512}
CHECKSUM_TYPE_OPENSSL=${CHECKSUM_TYPE_OPENSSL:-sha512}
PUBLIC_KEY=${PUBLIC_KEY:-mypublic.pem}

FILE=${FILE:-myfile.txt}

# Check software
openssl version > /dev/null 2>&1 && echo "openssl: OK" || echo "ERROR: openssl is missing !"
rhash --version > /dev/null 2>&1 && echo "rhash: OK" || echo "ERROR: rhash is missing !"

if (( $# == 1 )); then
    FILE=$1
    
    openssl dgst -"$CHECKSUM_TYPE_OPENSSL" -verify "$PUBLIC_KEY" -signature "$CHECKSUM_TYPE_OPENSSL".sign "$FILE"
    echo "signature check: OK"

    rhash --"$CHECKSUM_TYPE_RHASH" -c checksums."$CHECKSUM_TYPE_RHASH"
    echo "Checksum check: OK"
else
    echo "Usage: ${0##*/} <file to check>"
    echo "Optional override values"
    echo "Usage: PUBLIC_KEY=mypublic.pem ${0##*/} <file to check>"
    echo "Usage: CHECKSUM_TYPE_RHASH=sha3-512 CHECKSUM_TYPE_OPENSSL=sha512 ${0##*/} <file to check>"
    exit 1
fi
