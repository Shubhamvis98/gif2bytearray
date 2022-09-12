#!/bin/bash

set -e

banner()
{
cat << 'EOF'
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
EOF
}

help()
{
cat << 'EOF'
USAGE:
        ./g2bconv gif_file output_directory width height

        # width and height values are optional
        # default values for width=128 and height=64

EXAMPLE:
        ./g2bconv cat.gif cat 64 64
        ./g2bconv cat.gif cat
--------------------------------------------------------------

EOF
}

[[ -z $2 ]] && banner && help && exit || banner
[ ! -d $2 ] && mkdir -p $2
if [[ -z $4 ]]
then
	WIDTH=128
	HEIGHT=64
else
	WIDTH=$3
	HEIGHT=$4
fi
[[ -z $5 ]] && FSKIP=1 || FSKIP=$5

GIF=$1
OUT=$2
OUTPY=${OUT}.py

echo '[+]Converting to JPG...'
convert $GIF -coalesce -set colorspace Gray $OUT/_tmp.jpg

echo "[+]Resizing in ${WIDTH}x${HEIGHT}..."
for i in `ls $OUT/*.jpg`
do
	convert $i -resize ${WIDTH}x${HEIGHT}! $i
done

echo '[+]Convert PBM to bytearray...'
TMP=`mktemp --suffix='.pbm'`
[ -f $OUTPY ] && rm $OUTPY
C=0
for i in `ls ${OUT}/*jpg`
do
	convert "${OUT}/_tmp-${C}.jpg" $TMP
	python pbm2array.py $TMP $WIDTH $HEIGHT >> ${OUTPY}
	C=`expr $C + 1`
done

[ $FSKIP -gt 1 ] && echo "[+]Frameskip -> ${FSKIP}..." || echo '[*]No Frameskip'
python frameskip.py ${OUTPY} ${OUTPY} $FSKIP

sed -i -e 's/$/,/; 1 iimg = [' -i -e '$a]' ${OUTPY}

echo '[+]Removing TEMP...'
rm $TMP

