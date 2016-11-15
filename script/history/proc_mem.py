#!/usr/bin/env python
from __future__ import print_function
import subprocess
import sys


def main():
    proc_name = sys.argv[1] if len(sys.argv) >=2 else "Google Chrome"
    proc_list = subprocess.check_output(["ps", "-Ao", "rss,comm"])
    print(str(sum([int(proc.split()[0])
                   for proc in proc_list.split('\n')
                     if proc.count(proc_name)>0])/1024.0) + " M")

if __name__ == "__main__":
    main()
