#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import subprocess
import os

XELATEX_HEADER="""%!TEX TS-program = xelatex
%!TEX encoding = UTF-8 Unicode

\documentclass[12pt, fleqn, landscape]{article}
\usepackage[b5paper, left=2.5cm, right=2.5cm, top=2.5cm, bottom=3.5cm]{geometry}

\usepackage{parskip}
\setlength{\parskip}{.2cm}

\usepackage{fontspec}
\usepackage{xeCJK}
\setCJKmainfont[ItalicFont={DFHei Std W7}, BoldFont={DFHei Std W7},Vertical=RotatedGlyphs]{DFMing Std W5}

\\renewcommand\CJKglue{\hskip -0.3pt plus 0.08\\baselineskip}
\linespread{1.15}
\parindent=0pt
\\renewenvironment{quote}
  {\list{}{\\topsep 0ex\parsep 0ex\setlength\leftmargin{1.5em}%
\\rightmargin\leftmargin}\item\\relax\linespread{1.0}\small}%
{\endlist}

\XeTeXlinebreaklocale "zh"
\XeTeXlinebreakskip = 0pt plus 1pt 

\\title{}
\\author{}
\\pagestyle{empty}

\\begin{document}
"""

XELATEX_FOOTER="""
\\end{document}
"""

def generate_contents(fn, temp_fn):
    # convert content encoding from big5-2003 to utf8
    utf8_contents = subprocess.check_output((["iconv", "-f", "big5-2003", "-t", "utf8", temp_fn]))
    
    f = open(temp_fn, 'w')
    f.write(utf8_contents)
    f.close()

    # generate latex contents 
    f = open(temp_fn, 'r')
    read_lines = f.readlines()
    f.close()

    return read_lines 

def extract_contents_from_pdb(fn, out_fn):
    f = open(fn, 'rb')

    # read pdb header
    t = f.read(76)
    record = f.read(2)
    record = ord(record[0])*256 + ord(record[1])
    t = f.read(record*8)

    # read contents encoding with big5-2003
    s = f.read()
    s = s.replace('\x0d', '').replace('\x1b', '\x0a').replace('\x00', '\x0a\x0a')

    f.close()

    # write contents encoding with big5-2003
    out_f = open(out_fn, 'w')
    out_f.write(s[:-4] + "\n\n")
    out_f.close()
    
    return generate_contents(fn, out_fn)


def write_tex_file(tex_fn, tex_contents, latex_header, latex_footer):
    f = open(tex_fn, 'w')

    # add header and footer
    f.write(latex_header)
    f.writelines(tex_contents)
    f.write(latex_footer)

    f.close()

def remove_temporary_files(fn, *unrm_fn_list):
    remove_file_list = [f for f in os.listdir(".") if f.startswith(fn[:-4])]
    for unrm_fn in unrm_fn_list:
        if unrm_fn in remove_file_list:
            remove_file_list.remove(unrm_fn)

    cmd = ["rm", "-f"]
    cmd.extend(remove_file_list)
    subprocess.call(cmd)
    return " ".join(remove_file_list)

def main():
    fn_list = sys.argv[1:] if len(sys.argv) > 1 else []

    for fn in fn_list:
        if fn.endswith(".pdb"):
            temp_fn = fn[:-4]
            tex_fn = fn[:-4] + ".tex"
            pdf_fn = tex_fn[:-4] + ".pdf"

            print "read pdb file: " + fn
            tex_contents = extract_contents_from_pdb(fn, temp_fn)
            
            print "generate tex file: " + tex_fn
            write_tex_file(tex_fn, tex_contents, XELATEX_HEADER, XELATEX_FOOTER)


            # xelatex compile
            # print "generate pdf file through xelatex: " + pdf_fn
            # xelatex_complie_output = subprocess.check_output(["xelatex", tex_fn])

            rm_files_str = remove_temporary_files(fn, fn, tex_fn, pdf_fn)
            print "remove temporary files: " + rm_files_str 

if __name__ == "__main__":
    main()
