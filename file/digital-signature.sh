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
#//  Created: 25, July, 2021                                 //
#//  Modified: 26, July, 2021                                //
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
PRIVATE_KEY=${PRIVATE_KEY:-myprivate.pem}
PUBLIC_KEY=${PUBLIC_KEY:-mypublic.pem}

PASSWORD=${PASSWORD:-password}
FILE=${FILE:-myfile.txt}

# Check software
openssl version > /dev/null 2>&1 && echo "openssl: OK" || echo "ERROR: openssl is missing !"
rhash --version > /dev/null 2>&1 && echo "rhash: OK" || echo "ERROR: rhash is missing !"

if (( $# == 2 )); then
    FILE=$1
    PASSWORD=$2

    openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 -pkeyopt rsa_keygen_pubexp:3 -out "$PRIVATE_KEY" -aes-256-cbc -pass pass:"$PASSWORD"
    echo "Private key: OK"
    # Ed25519 Not supported now (In 3.0)
    # See https://github.com/openssl/openssl/issues/11677

    openssl pkey -in "$PRIVATE_KEY" -passin pass:"$PASSWORD" -pubout > "$PUBLIC_KEY"
    echo "Public key: OK"
    
    openssl dgst -"$CHECKSUM_TYPE_OPENSSL" -sign "$PRIVATE_KEY" -passin pass:"$PASSWORD" -out "$CHECKSUM_TYPE_OPENSSL".sign "$FILE"
    echo "signature: OK"
    
    openssl dgst -"$CHECKSUM_TYPE_OPENSSL" -verify "$PUBLIC_KEY" -signature "$CHECKSUM_TYPE_OPENSSL".sign "$FILE"
    echo "signature check: OK"
    
    rhash --"$CHECKSUM_TYPE_RHASH" > checksums."$CHECKSUM_TYPE_RHASH" "$FILE"
    echo "Checksum: OK"

    rhash --"$CHECKSUM_TYPE_RHASH" -c checksums."$CHECKSUM_TYPE_RHASH"
    echo "Checksum check: OK"
else
    echo "Usage: ${0##*/} <file> <password>"
    echo "Optional override values"
    echo "Usage: PRIVATE_KEY=myprivate.pem PUBLIC_KEY=mypublic.pem ${0##*/} <file> <password>"
    echo "Usage: CHECKSUM_TYPE_RHASH=sha3-512 CHECKSUM_TYPE_OPENSSL=sha512 ${0##*/} <file> <password>"
    exit 1
fi
