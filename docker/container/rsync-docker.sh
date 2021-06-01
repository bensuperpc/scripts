#!/bin/bash
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
#//  Script, 2021                                            //
#//  Created: 30, May, 2021                                  //
#//  Modified: 31, May, 2021                                 //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: https://github.com/axiom-data-science/rsync-server                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

DOCKER_IMAGE=bensuperpc/rsync-server:latest

USERNAME_SIZE=16
PASSWORD_SIZE=64

USERNAME=$(tr -dc A-Za-z </dev/urandom | head -c ${USERNAME_SIZE} ; echo '')
PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c ${PASSWORD_SIZE} ; echo '')

SSH_USERS=""
RSYNC_USER=""
USER_VOL_KEY=""

VOLUME_PATH="$PWD/data"

SSH_PORT=9000
RSYNC_PORT=8000

for i in "$@"
do
case $i in
    -i=*|--image=*)
    DOCKER_IMAGE="${i#*=}"
    shift # past argument=value
    ;;
    -v=*|--volumepath=*)
    VOLUME_PATH="${i#*=}"
    shift # past argument=value
    ;;
    -p=*|--sshport=*)
    SSH_PORT="${i#*=}"
    shift # past argument=value
    ;;
    -u=*|--user=*)
    SSH_USERS+="${i#*=} "
    shift # past argument=value
    ;;
    -r=*|--rsyncuser=*)
    RSYNC_USER+="${i#*=} "
    shift # past argument=value
    ;;
    -h|--help)
    echo "Usage: ${0##*/} [-u=<name1> -u=<name2> -p=<ssh port> -v=<volume_path> or nothing with default values]"
    exit 0
    ;;
    *)
        # unknown option
    ;;
esac
done

echo 'USERNAME Rsync (not Rsync + SSH):' ${USERNAME}
echo 'PASSWORD Rsync (not Rsync + SSH):' ${PASSWORD}
echo 'Usage ex 1: rsync -azv -e "ssh -i <Private key> -p '${SSH_PORT}' -l <USER>" localhost:/data/ $PWD'
echo 'Usage ex 2: rsync -azv rsync://'${USERNAME}'@localhost:8000/volume/ $PWD'
echo 'Replace <localhost> with <Your IP>'
echo ''
echo 'DOCKER_IMAGE:' ${DOCKER_IMAGE}
echo 'VOLUME_PATH:' ${VOLUME_PATH}
echo 'SSH_PORT:' ${SSH_PORT}
echo 'RSYNC_PORT:' ${RSYNC_PORT} 'cannot be changed currently'
echo 'SSH_USERS:' ${SSH_USERS}
echo 'RSYNC_USER:' ${RSYNC_USER} 'cannot be changed currently'
echo ''

setup_sshkey()
{
    mkdir -p $PWD/.ssh
    if [ ! -f $PWD/.ssh/$1 ]; then
        ssh-keygen -o -a 256 -b 512 -t ed25519 -C "ed25519-key" -f $PWD/.ssh/$1 -q -N ""
    else
        echo 'File:' $1 'exist.'
    fi
}

# Create multiple user
for USER in $SSH_USERS; do
    setup_sshkey "$USER"
    USER_VOL_KEY+=" -v  $PWD/.ssh/$USER.pub:/home/$USER/.ssh/authorized_keys"
done

# Create root user
setup_sshkey "root"

docker pull ${DOCKER_IMAGE}
docker run \
    -v "${VOLUME_PATH}":/data \
    -e USERNAME=${USERNAME} \
    -e PASSWORD=${PASSWORD} \
    -e VOLUME=/data \
    -e ALLOW="*" \
    -e DENY="" \
    -v $PWD/.ssh/root.pub:/root/.ssh/authorized_keys \
    -e SSH_USERS="${SSH_USERS}" \
    -e RSYNC_USER="${RSYNC_USER}" \
    ${USER_VOL_KEY} \
    -p ${SSH_PORT}:22 \
    -p ${RSYNC_PORT}:873 \
    ${DOCKER_IMAGE}