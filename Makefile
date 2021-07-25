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
	@echo "Install: done"

uninstall:
	@echo "Removing libraries"
	sudo ./uninstall.sh --yes
	@echo "Uninstall: done"

reinstall: uninstall install

update:
	@echo "Update submodule..."
	git submodule update --init --recursive --jobs=2
	git submodule update --recursive --remote --jobs=2
	@echo "Update: done"

dist: clean
	mkdir -p package_build
	rsync -azh --progress --exclude='package_build/' --exclude='*.gitignore' --exclude='*.git/' --exclude='*.circleci/' --exclude='*.github/' --exclude='*.png' --exclude='*.jpeg' . package_build/
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
	find . -type f -name "*.sh" ! -path "*./git/*" ! -path "*/install.sh" ! -path "*/uninstall.sh" ! -path "*/Bash-Snippet/*" ! -path "*/git-scripts/*" ! -path "*/git-extras/*" ! -path "*/git-extra-commands/*" ! -path "*/cryptr/*" ! -path "*/others-dist/*" ! -path "*/bash-scripts/*" ! -path "*/fff/*" -exec $(SHELL) -n {} \;
	
clean:
	$(RM) -rf package_build/
	$(RM) -f $(PROJECT_NAME)-$(VERSION).tar.xz
	$(RM) -f $(PROJECT_NAME)-$(VERSION).tar.xz.sha384
	$(RM) -f $(PROJECT_NAME)-full-$(VERSION).tar.xz
	$(RM) -f $(PROJECT_NAME)-full-$(VERSION).tar.xz.sha384
	@echo "Clean OK"

purge: clean uninstall
	@echo "Purge OK"

check-dep:
	@echo "Check dependency:"
	@echo ""
	@bash --version > /dev/null 2>&1 && echo "bash: OK" || echo "bash: Missing"
	@parallel --version > /dev/null 2>&1 && echo "parallel: OK" || echo "parallel: Missing"
	@find --version > /dev/null 2>&1 && echo "find: OK" || echo "find: Missing"
	@xargs --version > /dev/null 2>&1 && echo "xargs: OK" || echo "xargs: Missing"
	@git --version > /dev/null 2>&1 && echo "git: OK" || echo "git: Missing"
	@docker --version> /dev/null 2>&1 && echo "docker: OK" || echo "docker: Missing"
	@openssl version > /dev/null 2>&1 && echo "openssl: OK" || echo "openssl: Missing"
	@cryptsetup --version > /dev/null 2>&1 && echo "cryptsetup: OK" || echo "cryptsetup: Missing"
	@xz --version > /dev/null 2>&1 && echo "xz: OK" || echo "xz: Missing"
	@tar --version > /dev/null 2>&1 && echo "tar: OK" || echo "tar: Missing"
	@mount --version > /dev/null 2>&1 && echo "mount: OK" || echo "mount: Missing"
	@mkfs.btrfs --version > /dev/null 2>&1 && echo "mkfs.btrfs: OK" || echo "mkfs.btrfs: Missing"
	@gource --help > /dev/null 2>&1 && echo "gource: OK" || echo "gource: Missing"
	@youtube-dl --version > /dev/null 2>&1 && echo "youtube-dl: OK" || echo "youtube-dl: Missing"
	@ffmpeg -version > /dev/null 2>&1 && echo "ffmpeg: OK" || echo "ffmpeg: Missing"
	@cwebp -version > /dev/null 2>&1 && echo "cwebp: OK" || echo "cwebp: Missing"
	@avifenc --version > /dev/null 2>&1 && echo "avifenc: OK" || echo "avifenc: Missing"
	@magick -version > /dev/null 2>&1 && echo "magick: OK" || echo "magick: Missing"
	@pacman --version > /dev/null 2>&1 && echo "pacman: OK" || echo "pacman: Missing (If Archlinux based)"
	@apt --version > /dev/null 2>&1 && echo "apt: OK" || echo "apt: Missing (If debian based)"
	@clang-format --version > /dev/null 2>&1 && echo "clang-format: OK" || echo "clang-format: Missing"
	@cmake --version > /dev/null 2>&1 && echo "cmake: OK" || echo "cmake: Missing"
	@ninja --version > /dev/null 2>&1 && echo "ninja: OK" || echo "ninja: Missing"
	@gpg --version > /dev/null 2>&1 && echo "gpg: OK" || echo "gpg: Missing"
	@ruby --version > /dev/null 2>&1 && echo "ruby: OK" || echo "ruby: Missing"


.PHONY: check check-dep dist dist-full clean purge install uninstall reinstall update
