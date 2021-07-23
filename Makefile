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
#//  Modified: 15, July, 2021                                //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: https://github.com/metal3d/bashsimplecurses     //
#//			 https://superuser.com/questions/281573/what-are-the-best-options-to-use-when-compressing-files-using-7-zip
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////
PROJECT_NAME := scripts
SHELL := bash
VERSION := 1.0.1
RM := rm

all: install

install:
	@echo "Install libraries..."
	sudo ./install.sh --yes
	@echo "done"

uninstall:
	@echo "Removing libraries"
	sudo ./uninstall.sh --yes
	@echo "done"

update: uninstall install

sync-submodule:
	git submodule update --init --recursive
	git submodule update --recursive --remote

dist: clean
	mkdir -p package_build
	rsync -azh --progress --exclude='package_build/' --exclude='*.gitignore' --exclude='*.git/' --exclude='*.circleci/' --exclude='*.github/' --exclude='*.png' . package_build/
	#7z a -t7z $(PROJECT_NAME)-$(VERSION).7z package_build/ -m0=lzma2 -mx=9 -mfb=273 -ms -md=31 -myx=9 -mtm=- -mmt -mmtf -md=1536m -mmf=bt3 -mmc=10000 -mpb=0 -mlc=0
	XZ_OPT=-e9 tar cJf $(PROJECT_NAME)-$(VERSION).tar.xz package_build/
	sha384sum $(PROJECT_NAME)-$(VERSION).tar.xz > $(PROJECT_NAME)-$(VERSION).tar.xz.sha384
	sha384sum --check $(PROJECT_NAME)-$(VERSION).tar.xz.sha384
	@echo "$(PROJECT_NAME)-$(VERSION).tar.xz done"

dist-full: clean
	mkdir -p package_build
	rsync -azh --progress --exclude='package_build/' . package_build/
	#7z a $(PROJECT_NAME)-full-$(VERSION).7z package_build/ -m0=lzma2 -mx=9 -mmt -ms
	XZ_OPT=-e9 tar cJf $(PROJECT_NAME)-full-$(VERSION).tar.xz package_build/
	sha384sum $(PROJECT_NAME)-full-$(VERSION).tar.xz > $(PROJECT_NAME)-full-$(VERSION).tar.xz.sha384
	sha384sum --check $(PROJECT_NAME)-full-$(VERSION).tar.xz.sha384
	@echo "$(PROJECT_NAME)-full-$(VERSION).tar.xz done"

check:
	find . -type f -name "*.sh" ! -path "*./git/*" ! -path "*/install.sh" ! -path "*/uninstall.sh" ! -path "*/Bash-Snippet/*" ! -path "*/git-scripts/*" ! -path "*/git-extras/*" ! -path "*/git-extra-commands/*" ! -path "*/cryptr/*" ! -path "*/others-dist/*"  -exec $(SHELL) -n {} \;

clean:
	$(RM) -rf package_build/
	$(RM) -f $(PROJECT_NAME)-$(VERSION).tar.xz
	$(RM) -f $(PROJECT_NAME)-$(VERSION).tar.xz.sha384
	$(RM) -f $(PROJECT_NAME)-full-$(VERSION).tar.xz
	$(RM) -f $(PROJECT_NAME)-full-$(VERSION).tar.xz.sha384
	@echo "Clean OK"

.PHONY: check dist-full clean dist sync-submodule install uninstall update
