#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Update your daily tools!
"""

import sys
import argparse
import traceback
import subprocess
import shlex
import os


VIM_SRC = "local/src/vim"
IMAGEMAGICK_SRC = "local/src/ImageMagick"
PYTHON_SRC = "local/src/cpython"


def process_command(commands, path):
    """ Process OS Command """
    subprocess.check_call(shlex.split(commands), cwd=path)


def update_tool(src_location, configure_option=""):
    """ update tools """
    env_vars = os.environ.copy()
    # abs_location would be `/home/username/local/src/...`
    abs_location = os.path.join(env_vars["HOME"], src_location)
    process_command("git pull origin master", abs_location)
    # tools will be installed in `/home/username/local/bin`
    # you should include the path in the $PATH environment
    process_command("./configure --prefix={0} {1}".format(\
            os.path.join(os.path.join(env_vars["HOME"], "local")), configure_option), abs_location)
    process_command("make", abs_location)
    process_command("make install", abs_location)

def main():
    """ main entrance """
    parser = argparse.ArgumentParser(description="Update good tools")
    parser.add_argument("tool_name", type=str, help="a tool name which is to be updated")
    args = parser.parse_args()
    try:
        if args.tool_name == "vim":
            update_tool(VIM_SRC, "--with-features=huge")
        elif args.tool_name == "imagemagick":
            update_tool(IMAGEMAGICK_SRC)
        elif args.tool_name == "cpython":
            update_tool(PYTHON_SRC)
        else:
            return 1
    except subprocess.CalledProcessError:
        traceback.print_exc()
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
