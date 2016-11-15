#!/usr/bin/evn python

from sys import argv as sys_argv
import os
import stat

def recfilelist(path_name, pathlist):
    if stat.S_ISDIR(os.stat(path_name).st_mode):
        for p in os.listdir(path_name):
            next_path_name = os.path.join(path_name, p)
            if stat.S_ISDIR(os.stat(next_path_name).st_mode):
                recfilelist(next_path_name, pathlist)
            else:
                pathlist.append(next_path_name)

commands = lambda fn_list: map(lambda fn: "ffmpeg -i \"" + fn + "\" -acodec libmp3lame -ab 320k \"" + fn[:-3] + "mp3\"", filter(lambda x:x.endswith(".m4a"), fn_list))

def main():
    if len(sys_argv) > 1:
        dir_list = sys_argv[1:]

    for dn in dir_list:
        fn_list = []
        recfilelist(dn, fn_list)
        for cmd in commands(fn_list):
            print cmd


if __name__ == "__main__":
    main()
