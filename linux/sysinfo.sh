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
#//  Created: 24, July, 2021                                 //
#//  Modified: 24, July, 2021                                //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: https://github.com/spektom/shell-utils/blob/master/sysinfo.sh                                               //
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

tmpdir="sysinfo-$(date +'%Y%m%d-%H%M%S-%Z')"
mkdir "$tmpdir" || exit $?

#PATH=/usr/sbin:/usr/bin:/sbin:/bin

gather() {
	file=$1
	shift
	bash -c "$*" >> "$tmpdir"/"$file".txt 2>&1 || true
}

echo
echo -n "Gathering statistics ..."
gather uname uname -a
gather uptime uptime
gather selinux sestatus
gather dmesg dmesg -T

# Partition
gather df df -h
gather mount mount
gather fdisk fdisk -lu

gather ps ps faux
gather sysctl sysctl -A

# GPU
gather glxinfo glxinfo
gather nvidia-smi nvidia-smi -a
gather aticonfig aticonfig --odgt

# CPU
#gather cpuinfo cat /proc/cpuinfo
gather cpuinfo lscpu lscpu

# Memory
gather meminfo cat /proc/meminfo

# PCIe, USB, SCSI
gather lspci lspci -v
gather lsusb lsusb -v
gather lsscsi lsscsi -s
gather grubline cat /proc/cmdline

gather lsmod lsmod
gather lshw lshw
gather dmidecode dmidecode
gather chkconfig chkconfig --list

# Network
gather netstat netstat -npl
gather ip-rules ip rule show
gather ip-routes ip route show
gather ifconfig ifconfig -a
gather route route -n

# Package
gather dpkg-packages dpkg -l
gather rpm-packages rpm -qa
gather arch-packages-all pacman -Q
gather arch-packages-installed pacman -Qe
gather arch-packages-yay pacman -Qm
gather pip3 pip3 list
gather npm npm list -g --depth=0
gather brew brew list

echo "Done"

find . -type f -empty -delete

XZ_OPT=-e9 tar cJf "${tmpdir}.tar.xz" "$tmpdir"
rm -rf "$tmpdir"

echo
echo "System information archive has been created:"
echo "${tmpdir}.tar.xz"
echo

