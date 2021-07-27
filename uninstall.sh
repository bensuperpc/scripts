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
#//  Created: 27, May, 2021                                  //
#//  Modified: 24, July, 2021                                //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: https://unix.stackexchange.com/a/39341/359833                                               //
#//          https://stackoverflow.com/a/42876846/10152334                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

if [ $# -eq 0 ]; then
    read -r -p "Uninstall Software ? [Y/n]: " answ
    if [ "$answ" == 'n' ]; then
        exit 1
    fi
fi


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

DIR="/usr/bin/ben_script/"
if [ ! -d "$DIR" ]; then
  # Take action if $DIR exists. #
  echo "${DIR} does not exist..."
  exit 0
fi

echo "Removing Bash-Snippet..."
cd /usr/bin/ben_script/Bash-Snippet
sudo ./uninstall.sh all
echo "Removing Bash-Snippet done"

echo "Removing git-extras..."
cd /usr/bin/ben_script/git/git-extras
sudo make uninstall
echo "Removing git-extras done"

echo "Removing git-quick-stats..."
cd /usr/bin/ben_script/git/git-quick-stats
sudo make uninstall
echo "Removing git-quick-stats done"

echo "Removing fff..."
cd /usr/bin/ben_script/fff
sudo make uninstall
echo "Removing fff done"

echo "Removing ben's scripts, git-scripts, git-extra-commands, cryptr, bash-scripts, shell-scripts, docker-scripts and gpg-encrypt..."
echo "Remove symlink..."
sudo find /usr/bin -lname '/usr/bin/ben_script/*' -delete
echo "Remove symlink done"

echo "Remove ben_script file from /usr/bin..."
sudo rm -fr /usr/bin/ben_script
echo "Remove ben_script done"

echo "Removing ben's scripts, git-scripts, git-extra-commands, cryptr done"
#sudo rm -fr /usr/bin/ben_script && sudo find /usr/bin/ -xtype l -delete
echo "Removing done"
