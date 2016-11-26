#!/usr/bin/env python
"""
Update your daily tools!
"""
# -*- coding: utf-8 -*-

import sys
import argparse
import traceback
import subprocess
import shlex
import os


VIM_SOURCE_URL = "https://github.com/vim/vim.git"
VIM_SRC = "local/src/vim"
IMAGEMAGICK_SRC = "local/src/ImageMagick"

def usage():
    print("no update")

def process_command(commands, path):
    subprocess.check_call(shlex.split(commands), cwd=path)


def update_tool(src_location):
    env_vars = os.environ.copy()
    abs_location = os.path.join(env_vars["HOME"], src_location)
    process_command("git pull origin master", abs_location)
    process_command("./configure --prefix={}".format(os.path.join(os.path.join(env_vars["HOME"], "local"))), abs_location)
    process_command("make", abs_location)
    process_command("make install", abs_location)

def main():
    parser = argparse.ArgumentParser(description="Update good tools")
    parser.add_argument("tool_name", type=str, help="a tool name which is to be updated")
    args = parser.parse_args()
    try:
        if args.tool_name == "vim":
            update_tool(VIM_SRC)
        elif args.tool_name == "imagemagick":
            update_tool(IMAGEMAGICK_SRC)
        else:
            usage()
    except Exception as e:
        traceback.print_exc()
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
