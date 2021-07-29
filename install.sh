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
#//          https://stackoverflow.com/a/3837487/10152334
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

echo "Install ben's scripts"

echo "Clean..."
sudo find /usr/bin -lname '/usr/bin/ben_script/*' -delete
sudo rm -rf /usr/bin/ben_script
echo "Clean done"

echo "copy..."
sudo mkdir -p /usr/bin/ben_script && sudo cp -a . /usr/bin/ben_script
echo "copy done"

echo "Install ben's scripts (docker-scripts and gpg-encrypt)..."
echo "create symlink..."
find /usr/bin/ben_script -type f \( -name "*.sh" -o -name "*.py" \) ! -path "*./git/*" \
    ! -path "*/install.sh" ! -path "*/uninstall.sh" ! -path "*/Bash-Snippet/*" \
    ! -path "*/git-scripts/*" ! -path "*/git-extras/*" ! -path "*/git-extra-commands/*" \
    ! -path "*/cryptr/*" ! -path "*/others-dist/*" ! -path "*/bash-scripts/*" ! -path "*/fff/*" \
    ! -path "*/shell-scripts/*" -print0 | xargs -0 -P"$(nproc)" -I{} sudo ln -s "{}" /usr/bin || true
echo "create symlink done"
echo "Install ben's scripts done"

echo "Install Bash-Snippet..."
cd /usr/bin/ben_script/Bash-Snippet
sudo ./install.sh all
echo "Install Bash-Snippet done"

echo "Install git-extras..."
cd /usr/bin/ben_script/git/git-extras
sudo make install
echo "Install git-extras done"

echo "Install git-quick-stats..."
cd /usr/bin/ben_script/git/git-quick-stats
sudo make install
echo "Install git-quick-stats done"

echo "Install fff..."
cd /usr/bin/ben_script/fff
sudo make install
echo "Install fff done"

echo "Install git-scripts..."
find /usr/bin/ben_script/git/git-scripts -type f -name "git-*" \
    ! -path "*./git/*" -print0 | xargs -0 -P"$(nproc)" -I{} sudo ln -s "{}" /usr/bin || true
echo "Install git-scripts done"

echo "Install git-extra-commands..."
find /usr/bin/ben_script/git/git-extra-commands/bin -type f -name "*" \
    ! -path "*./git/*" -print0 | xargs -0 -P"$(nproc)" -I{} sudo ln -s "{}" /usr/bin || true
echo "Install git-extra-commands done"

echo "Install cryptr..."
ln -s /usr/bin/ben_script/cryptography/cryptr/cryptr.bash /usr/bin/cryptr
echo "Install cryptr done"

echo "Install spoofpoint..."
ln -s /usr/bin/ben_script/internet/spoofpoint/spoofpoint /usr/bin/spoofpoint
echo "Install spoofpoint done"

echo "Install others-dist..."
find /usr/bin/ben_script/others-dist/Scripts -type f -name "*.sh" \
    ! -path "*./git/*" -print0 | xargs -0 -P"$(nproc)" -I{} sudo ln -s "{}" /usr/bin || true
echo "Install others-dist done"

echo "Install shell-scripts..."
find /usr/bin/ben_script/shell-scripts -type f -name "*.sh" \
    ! -path "*./git/*" -print0 | xargs -0 -P"$(nproc)" -I{} sudo ln -s "{}" /usr/bin || true
echo "Install shell-scripts done"

echo "Install bash-scripts..."
find /usr/bin/ben_script/bash-scripts -type f -name "*.sh" \
    ! -path "*./git/*" -print0 | xargs -P"$(nproc)" -0 -I{} sudo ln -s "{}" /usr/bin || true
echo "Install bash-scripts done"

echo "Remove *.sh ..."
# Move it by remove file extension (if does not exit)
find /usr/bin -lname '/usr/bin/ben_script/*.sh' | while read -r NAME ; do sudo mv -nv "${NAME}" "${NAME%.sh}" || echo "Fail: ${NAME}" ; done
echo "Remove *.sh done"

echo "Remove *.py ..."
# Move it by remove file extension (if does not exit)
find /usr/bin -lname '/usr/bin/ben_script/*.py' | while read -r NAME ; do sudo mv -nv "${NAME}" "${NAME%.sh}" || echo "Fail: ${NAME}" ; done
echo "Remove *.py done"

echo "Install done"
