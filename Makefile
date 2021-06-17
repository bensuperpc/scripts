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
#//  Created: 17, June, 2021                                 //
#//  Modified: 17, June, 2021                                //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: https://github.com/metal3d/bashsimplecurses     //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////
PROJECT_NAME := scripts
SHELL := bash
VERSION := 1.0

all: install

install:
	@echo "Install libraries..."
	sudo ./install.sh --yes
	@echo "done"

uninstall:
	@echo "Removing libraries"
	sudo ./uninstall.sh --yes
	@echo "done"

sync-submodule:
	git submodule update --init --recursive
	git submodule update --recursive --remote

dist: clean sync-submodule
	mkdir -p package_build
	rsync -a --progress --exclude='package_build/' --exclude='*.gitignore' --exclude='*.git/' --exclude='*.circleci/' --exclude='*.github/' . package_build/
	7z a $(PROJECT_NAME)-$(VERSION).7z package_build/ -m0=lzma2 -mx=7 -mmt -ms
	@echo "$(PROJECT_NAME)-$(VERSION).7z done"

clean:
	rm -rf package_build/
	rm -f $(PROJECT_NAME)-$(VERSION).7z
