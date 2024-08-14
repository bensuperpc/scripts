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
#//  Created: 30, September, 2021                            //
#//  Modified: 30, September, 2021                           //
#//  file: -                                                 //
#//  -                                                       //
#//  Source: https://gist.github.com/rafi/365926             //
#//          https://github.com/acaudwell/Gource/issues/137  //
#//  OS: ALL                                                 //
#//  CPU: ALL                                                //
#//                                                          //
#//////////////////////////////////////////////////////////////

# 720p: 1280x720x24
# 1080p: 1920x1080x24
# 2K: 2560x1440x24
# 4K: 3840x2160x24
# 5ĸ: 4800x2700x24 # Not tested
# 8K: 7680x4320x24 # 30fps (On nvidia ampere)

# -2560x1440 # If not --fullscreen # --date-format "%Y-%m-%d" --elasticity 0.1 --max-user-speed 500
# FFMPEG -pix_fmt yuv420p yuvj420p rgb0

git_url=$(git config --get remote.origin.url)

xvfb-run -a -s "-screen 0 2560x1440x24" \
  gource \
    --stop-at-end \
    --fullscreen \
    --multi-sampling \
    --seconds-per-day 0.1 \
    --highlight-users \
    --max-files 0 \
    --auto-skip-seconds 0.1 \
    --background-colour 000000 \
    --bloom-multiplier 0.8 \
    --key \
    --filename-time 2 \
    --file-idle-time 0 \
    --output-framerate 60 \
    --hide mouse \
    --file-extension-fallback \
    --path . \
    --output-ppm-stream - \
    --title "$git_url" \
    | ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i - \
    -vcodec hevc_nvenc \
    -pix_fmt rgb0 \
    -gpu:v 0 \
    -bf:v 3 -rc-lookahead:v 32 -refs:v 16 -b_ref_mode:v middle \
      -tier:v high \
      -preset:v p7 \
      -tune:v hq \
      -rc:v vbr \
      -cq:v 0 -b:v 20M \
      -minrate:v 1M -maxrate:v 800M -bufsize:v 800M "$1"
