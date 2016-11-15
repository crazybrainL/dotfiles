#!/usr/bin/env python
#-*- coding: utf8 -*-
import zipfile
from sys import argv as sargv
from subprocess import Popen, PIPE
import optparse

OPENCC_BIN_PATH='/usr/local/bin/opencc'

def opencc_convert_s2t(text, opencc_bin_path=OPENCC_BIN_PATH):
    proc = Popen([opencc_bin_path], stdin=PIPE , stdout=PIPE)
    proc.stdin.write(text.encode('utf8'))
    proc.stdin.close()
    
    code = proc.wait()
    if code:
        raise RuntimeError('Failed to call opencc with exit code %s' % code)
    
    result = proc.stdout.read()
    return result.decode('utf8')


def convert_epub_sc2tc(input_fn, output_fn):
    # read epub file and convert
    input_fh = zipfile.ZipFile(input_fn, "r")
    fn_list_sc, fn_list_bin = reduce(lambda (fn_sc, fn_bin), fn: (fn_sc + [fn], fn_bin) if any(fn.endswith(x) for x in ['html', 'htm', 'ncx', 'opf']) else (fn_sc, fn_bin + [fn]), input_fh.namelist(), ([], []))

    content_list_tc = map(lambda fn: opencc_convert_s2t(input_fh.read(fn).replace('zh-CN', 'zh-TW').decode('utf8')), fn_list_sc)
    content_list_bin = map(lambda fn: input_fh.read(fn), fn_list_bin)

    input_fh.close()

    # write epub file
    out_fh = zipfile.ZipFile(output_fn, "w")
    map(lambda (fn, content): out_fh.writestr(fn, content.encode('utf8')), zip(fn_list_sc, content_list_tc))
    map(lambda (fn, content): out_fh.writestr(fn, content), zip(fn_list_bin, content_list_bin))
    
    out_fh.close()

def main():
    epub_fn_list = []
    if len(sargv) < 2:
        print "python epubs2t.py sample.epub"
    else:
        epub_fn_list = filter(lambda fn: fn.endswith('.epub'), sargv[1:])

    for epub_fn in epub_fn_list:
        convert_epub_sc2tc(epub_fn, epub_fn[:-5] + "_tc.epub")
        print "Convert " + epub_fn + " to " + epub_fn[:-5] + "_tc.epub Sucessfully."

if __name__ == "__main__":
    main()
