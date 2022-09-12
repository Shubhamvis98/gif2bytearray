#!/usr/bin/env python3

import sys
import os

try:
    SRC = sys.argv[1]
    OUT = sys.argv[2]
except:
    print(f'Usage:\n\t{sys.argv[0]} input_file output frames_to_skip(default=4)')
    sys.exit()

try:
    SKIP = int(sys.argv[3])
except IndexError:
    SKIP = 1

sys.exit("[!]Input file not found") if not os.path.exists(SRC) else True

def frameskip(SRC, OUT, SKIP):
    with open(SRC, 'r') as f:
        TMP = f.readlines()
    
    with open(OUT, 'w') as n:
        n.write('')

    for i in range(0, len(TMP), SKIP):
        with open(OUT, 'a') as n:
            n.writelines(TMP[i])

frameskip(SRC, OUT, SKIP)

