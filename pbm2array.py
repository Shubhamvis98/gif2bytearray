#!/usr/bin/env python3

import sys
import re

WIDTH = sys.argv[2]
HEIGHT = sys.argv[3]

with open(sys.argv[1], 'rb') as i:
    print(str(i.read()).replace(r'P4\n{} {}\n'.format(WIDTH, HEIGHT), ''))
