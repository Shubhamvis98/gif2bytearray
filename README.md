<pre>
       _    ___                _
      (_)  / __)             F(_)SSFROG's      _
  ____ _ _| |__    _____ ____  _ ____  _____ _| |_ ___   ____
 / _  | (_   __)  (____ |  _ \| |    \(____ (_   _) _ \ / ___)
( (_| | | | |     / ___ | | | | | | | / ___ | | || |_| | |
 \___ |_| |_|     \_____|_| |_|_|_|_|_\_____|  \__)___/|_|
(_____|                                   gif to bytearray

git|twitter: shubhamvis98
web: https://fossfrog.in
---------------------------------------------------------------------------------
USAGE:
        g2bconv.sh -h # for help
        g2bconv.sh -i gif_file -o output_directory -s widthxheight -f frameskip

        # width, height and frameskip values are optional
        # default values for width=128, height=64 with no frameskip

EXAMPLE:
        g2bconv.sh -i cat.gif -o cat -s 64x32 -f 4
        g2bconv.sh -i cat.gif -o cat -s 64x32
        g2bconv.sh -i cat.gif -o cat -s 100 # same width and height
        g2bconv.sh -i cat.gif -o cat
</pre>

This tool creates a file names as per {output_directory}.py wich contains the list of bytearray.<br>So you can use the file by importing in micropython. eg. the output is "cat.py"
<br><pre>
from cat.py import img
<code># micropython or circuitpython</code>
<code># img will be a list so use it as the image sequence</code>
</pre>


![b](https://user-images.githubusercontent.com/43336210/189738647-ef7e2b04-4076-46e7-83b0-8f0452081069.gif)
