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
#//  Modified: 29, July, 2021                                //
#//  file: -                                                 //
#//  -                                                       //
#//  Source:  https://medium.com/@bn121rajesh/rsa-sign-and-verify-using-openssl-behind-the-scene-bf3cac0aade2                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

readonly VERSION="1.1.0"

# Values can by override
CHECKSUM_TYPE_RHASH=${CHECKSUM_TYPE_RHASH:-sha3-512}
CHECKSUM_TYPE_OPENSSL=${CHECKSUM_TYPE_OPENSSL:-sha512}
RSA_KEY_SIZE=${RSA_KEY_SIZE:-4096}
OPENSSL_CIPHER_TYPE=${OPENSSL_CIPHER_TYPE:-aes-256-cbc}
PRIVATE_KEY=${PRIVATE_KEY:-myprivate.pem}
PUBLIC_KEY=${PUBLIC_KEY:-mypublic.pem}

PASSWORD=${PASSWORD:-password}
FILE=${FILE:-myfile.txt}

DS_version() {
    echo "digital-signature-gen-RSA $VERSION"
}


DS_check_software() {
    # Check software
    openssl version > /dev/null 2>&1 && echo "openssl: OK" || echo "ERROR: openssl is missing !"
    rhash --version > /dev/null 2>&1 && echo "rhash: OK" || echo "ERROR: rhash is missing !"
}

DS_help() {
    echo "Usage: ${0##*/} sign <file> <password>"
    echo "Usage: ${0##*/} check <file>"
    echo "Optional override values"
    echo "Usage: PRIVATE_KEY=myprivate.pem PUBLIC_KEY=mypublic.pem ${0##*/} sign <file> <password>"
    echo "Usage: CHECKSUM_TYPE_RHASH=sha3-512 CHECKSUM_TYPE_OPENSSL=sha512 ${0##*/} sign <file> <password>"
    echo "Usage: RSA_KEY_SIZE=4096 OPENSSL_CIPHER_TYPE=saes-256-cbc ${0##*/} sign <file> <password>"
}


DS_main() {
  local _command="$1"

  if [[ -z $_command ]]; then
    DS_version
    echo
    DS_help
    exit 0
  fi

  shift 1
  case "$_command" in
    "sign")
      DS_sign "$@"
      ;;

    "check")
      DS_check "$@"
      ;;

    "version")
      DS_version
      ;;

    "help")
      DS_help
      ;;

    *)
      DS_help 1>&2
      exit 1
  esac
}

DS_check() {
    if (( $# == 1 )); then
        FILE=$1
        openssl dgst -"$CHECKSUM_TYPE_OPENSSL" -verify "$PUBLIC_KEY" -signature "$CHECKSUM_TYPE_OPENSSL".sign "$FILE"
        echo "signature check: OK"
    else
        DS_help
    fi
}

DS_sign() {
    if (( $# == 2 )); then
        FILE=$1
        PASSWORD=$2
        DS_check_software

        openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:"$RSA_KEY_SIZE" -pkeyopt rsa_keygen_pubexp:3 -out "$PRIVATE_KEY" -"$OPENSSL_CIPHER_TYPE" -pass pass:"$PASSWORD"
        echo "Private key: OK"
        # Ed25519 Not supported now (In 1.1.1k)
        # See https://github.com/openssl/openssl/issues/11677

        openssl pkey -in "$PRIVATE_KEY" -passin pass:"$PASSWORD" -pubout > "$PUBLIC_KEY"
        echo "Public key: OK"
        
        openssl dgst -"$CHECKSUM_TYPE_OPENSSL" -sign "$PRIVATE_KEY" -passin pass:"$PASSWORD" -out "$CHECKSUM_TYPE_OPENSSL".sign "$FILE"
        echo "signature: OK"
        
        DS_check "$FILE"
        
        rhash --"$CHECKSUM_TYPE_RHASH" > checksums."$CHECKSUM_TYPE_RHASH" "$FILE"
        echo "Checksum: OK"

        rhash --"$CHECKSUM_TYPE_RHASH" -c checksums."$CHECKSUM_TYPE_RHASH"
        echo "Checksum check: OK"
    else
        DS_help
    fi
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
  DS_main "$@"
fi
