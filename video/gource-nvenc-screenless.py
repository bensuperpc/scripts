import subprocess
from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument("--resolution", nargs='?', default="2560x1440x24", help="Resolution of the video with x as separator and 24 as default color depth")
parser.add_argument("--fps", type=int, nargs='?', choices=[24, 30, 60], default=60, help="Frames per second")

# ffmpeg settings
parser.add_argument("--bitrate", nargs='?', default="40M", help="Everage bitrate")
parser.add_argument("--minrate", nargs='?', default="1M", help="Minimum bitrate")
parser.add_argument("--maxrate", nargs='?', default="800M", help="Maximum bitrate")
parser.add_argument("--vcodec", nargs='?', default="hevc_nvenc", help="define the video codec")
parser.add_argument("--output", nargs='?', default="test_video.mkv")

# Gource settings
parser.add_argument("--key", action="store_true", help="Display file count")
parser.add_argument("--title", nargs='?', default="git_test", help="title in the video")
parser.add_argument("--seconds_per_day", nargs='?', type=float, default=0.1, help="title in the video")

args = parser.parse_args()

# TODO: create class and pip package for Gource
if (args.key):
    args.key = "--key"
else:
    args.key = ""


git_command = ["git", "config", "--get", "remote.origin.url"]

xvfb_command = ["xvfb-run", "-a", "-s", "\"-screen 0 " + args.resolution + "\""]

gource_command = ["gource", "--stop-at-end", "--fullscreen", "--multi-sampling", "--seconds-per-day", str(args.seconds_per_day), "--highlight-users",
 "--max-files", "0", "--auto-skip-seconds", "0.1", "--background-colour", "000000", "--bloom-multiplier", "0.8", args.key, "--output-framerate", str(args.fps), 
 "--hide", "mouse", "--file-extension-fallback", "--path", ".", "--output-ppm-stream", "-", "--title", args.title]

ffmpeg_command = ["ffmpeg", "-y", "-r", str(args.fps) , "-f", "image2pipe", "-vcodec", "ppm", "-i", "-", "-vcodec", args.vcodec, "-pix_fmt", "rgb0", 
 "-gpu:v", "0", "-bf:v", "3", "-rc-lookahead:v", "32", "-refs:v", "16", "-b_ref_mode:v", "middle", "-tier:v", "high", "-tune:v", "hq",
 "-rc:v", "vbr", "-cq:v", "0", "-b:v", args.bitrate, "-minrate:v", args.minrate, "-maxrate:v", args.maxrate, "-bufsize:v", "800M", args.output]

full_cmd = " ".join(xvfb_command + gource_command + ["|"] + ffmpeg_command)
print(full_cmd)

ps = subprocess.run(full_cmd, shell=True, check=True, bufsize=0)
