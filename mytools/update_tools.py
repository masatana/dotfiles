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
from pathlib import Path

BASE = Path.home() / ".local"
SRC_BASE = BASE / "src"
VIM_SRC = SRC_BASE / "vim"
IMAGEMAGICK_SRC = SRC_BASE / "ImageMagick"
PYTHON_SRC = SRC_BASE / "cpython"


def process_command(commands: str, path: Path):
    """ Process OS Command """
    subprocess.check_call(shlex.split(commands), cwd=path)


def update_tool(src_location: Path, init: bool, configure_option: str=""):
    """ update tools """
    process_command("git pull origin master", src_location)
    # tools will be installed in `/home/username/local/bin`
    # you should include the path in the $PATH environment
    process_command("./configure --prefix={0} {1}".format(BASE, configure_option), src_location)
    process_command("make", src_location)
    process_command("make install", src_location)

def main():
    """ main entrance """
    parser = argparse.ArgumentParser(description="Update good tools")
    parser.add_argument("tool_name", type=str, help="a tool name which is to be updated")
    parser.add_argument("--init", action="store_true")
    args = parser.parse_args()
    try:
        if args.tool_name == "vim":
            update_tool(VIM_SRC, init, "--with-features=huge")
        elif args.tool_name == "imagemagick":
            update_tool(IMAGEMAGICK_SRC, init)
        elif args.tool_name == "cpython":
            update_tool(PYTHON_SRC, init)
        else:
            return 1
    except subprocess.CalledProcessError:
        traceback.print_exc()
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
