<pre>
       _    ___                _
      (_)  / __)             F(_)SSFROG's      _
  ____ _ _| |__    _____ ____  _ ____  _____ _| |_ ___   ____
 / _  | (_   __)  (____ |  _ \| |    \(____ (_   _) _ \ / ___)
( (_| | | | |     / ___ | | | | | | | / ___ | | || |_| | |
 \___ |_| |_|     \_____|_| |_|_|_|_|_\_____|  \__)___/|_|
(_____|                             gif to bytesarray

git|twitter: shubhamvis98
web: https://fossfrog.in
--------------------------------------------------------------
USAGE:
        ./g2bconv gif_file output_directory width height frameskip

        # width, height and frameskip values are optional
        # default values for width=128, height=64 with no frameskip

EXAMPLE:
        ./g2bconv cat.gif cat 64 64
        ./g2bconv cat.gif cat
--------------------------------------------------------------
</pre>

This tool creates a file names as per {output_directory}.py wich contains the list of bytearray.<br>So you can use the file by importing in micropython. eg. the output is "cat.py"
<br><pre>
from cat.py import img
<code># micropython or circuitpython</code>
<code># img will be a list so use it as the image sequence</code>
</pre>


![b](https://user-images.githubusercontent.com/43336210/189738647-ef7e2b04-4076-46e7-83b0-8f0452081069.gif)
