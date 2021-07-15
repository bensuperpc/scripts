#!/bin/bash
set -euo pipefail

git_directory=$(find . -name .git -type d)
date_now=$(date +"%Y%m%d%H%M")
mkdir -p log/

echo "$git_directory" | xargs -n1 -P$(nproc) -I% git --git-dir=% --work-tree=%/.. fetch --jobs=2 --all --recurse-submodules --force --multiple --progress 2>&1 | tee -a log/log-${date_now}.txt
echo "$git_directory" | xargs -n1 -P$(nproc) -I% git --git-dir=% --work-tree=%/.. reset --hard --recurse-submodules HEAD 2>&1 | tee -a log/log-${date_now}.txt
echo "$git_directory" | xargs -n1 -P$(nproc) -I% git --git-dir=% --work-tree=%/.. pull --jobs=2 --all --recurse-submodules --force --progress 2>&1 | tee -a log/log-${date_now}.txt

#git clone --recurse-submodules --remote-submodules https://github.com/TheAlgorithms/Python.git
