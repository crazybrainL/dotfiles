#!/usr/bin/env python3

"""
Basic CPU & Memory Usage for Tmux

Author: Zaiste! <oh@zaiste.net>

Dash-meter inspired by tmux-mem-cpu
and code from psutil top.py.
"""

import os
import sys

import psutil


def cpu_mem_info():
    # Cal mem usage
    mem = psutil.virtual_memory()
    mem_used = mem.used
    mem_total = mem.total
    mem_percent = int(mem_used / mem_total * 100.0)

    # Get cpu usage
    cpu_percent = int(psutil.cpu_percent(interval=0.1))

    # Pretty print
    line = "{cpu_percent}% {mem_percent}%".format(
            cpu_percent = str(cpu_percent), mem_percent = str(mem_percent))

    return line


def cpu_info():
    # Get cpu usage
    cpu_percent = int(psutil.cpu_percent(interval=0.1))

    # Pretty print
    line = "{cpu_percent}%".format(
            cpu_percent = str(cpu_percent))

    return line


def main():
    # if os.name != 'posix':
        # sys.exit('platform not supported')

    try:
        print(cpu_info())
    except (KeyboardInterrupt, SystemExit):
        pass

if __name__ == '__main__':
    main()
