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
#//  Script, 2021                                            //
#//  Created: 27, May, 2021                                  //
#//  Modified: 27, May, 2021                                 //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: https://unix.stackexchange.com/a/39341/359833                                               //
#//          https://stackoverflow.com/a/42876846/10152334                                               //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

read -p "Install Software ? [Y/n]: " answ
 if [ "$answ" == 'n' ]; then
   exit 1
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


echo "Pull Submodule..."
git submodule update --init --recursive
git submodule update --recursive --remote
echo "Pull Submodule done"


echo "Install ben's scripts"

echo "copy..."
sudo mkdir -p /usr/bin/ben_script && sudo cp -a . /usr/bin/ben_script
echo "copy done"

echo "create symlink..."
find /usr/bin/ben_script -type f -name "*.sh" ! -path "*./git/*" ! -path "*/install.sh" ! -path "*/uninstall.sh" ! -path "*/Bash-Snippet/*" -exec sudo ln -s {} /usr/bin \;
echo "create symlink done"
echo "Install ben's scripts done"

echo "Install Bash-Snippet..."
cd /usr/bin/ben_script/Bash-Snippet
sudo ./install.sh all
echo "Install Bash-Snippet done"

echo "Install git-extras..."
cd /usr/bin/ben_script/git-extras
sudo ./install.sh
echo "Install git-extras done"

echo "Install done"
