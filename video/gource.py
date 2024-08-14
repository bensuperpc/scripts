import subprocess
from argparse import ArgumentParser

class Gource:
    def __init__(self, args):

        self.hide_list = ["mouse", ]

        # Defaults values

        # Window settings
        self.fullscreen = False
        self.windowed = True
        self.frameless = False
        self.no_vsync = False
        self.high_dpi = False

        self.stop_at_end = False
        self.multi_sampling = False
        self.highlight_users = False
        self.max_files = 0
        self.auto_skip_seconds = 0.1
        self.background_colour = "000000"
        self.bloom_multiplier = 0.8
        self.key = False
        self.title = ""
        self.seconds_per_day = 0.1
        self.auto_skip_seconds = 0.1
        self.output_framerate = 60
        self.hide = []
        self.file_extension_fallback = False
        self.path = "."
        self.output_ppm_stream = False
        self.output = ""
    
    def generate_cmd(self):
        cmd = []

        # Window settings
        if (self.fullscreen):
            cmd.append("--fullscreen")

            
            if "--windowed" in cmd:
                cmd.remove("--windowed")
            if "--frameless" in cmd:
                cmd.remove("--frameless")

        if (self.windowed):
            cmd.append("--windowed")

            if "--fullscreen" in cmd:
                cmd.remove("--fullscreen")
            if "--frameless" in cmd:
                cmd.remove("--frameless")

        if (self.frameless):
            cmd.append("--frameless")

            if "--fullscreen" in cmd:
                cmd.remove("--fullscreen")
            if "--windowed" in cmd:
                cmd.remove("--windowed")



