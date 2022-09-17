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
(_____|                                   gif to bytearray

git|twitter: shubhamvis98
web: https://fossfrog.in
---------------------------------------------------------------------------------
EOF
}

help()
{
cat << EOF
USAGE:
        `basename $0` -h # for help
        `basename $0` -i gif_file -o output_directory -s widthxheight -f frameskip

        # width, height and frameskip values are optional
        # default values for width=128, height=64 with no frameskip

EXAMPLE:
        `basename $0` -i cat.gif -o cat -s 64x32 -f 4
        `basename $0` -i cat.gif -o cat -s 64x32
        `basename $0` -i cat.gif -o cat -s 100 # same width and height
        `basename $0` -i cat.gif -o cat

EOF
}

while getopts "hi:o:s:f:" opt
do
	case $opt in
		h)
			banner
			help
			exit
			;;
		i)
			GIF=${OPTARG}
			;;
		o)
			OUT=${OPTARG}
			;;
		s)
			SIZE=${OPTARG}
			;;
		f)
			FSKP=${OPTARG}
			;;
	esac
done

[[ -z $OUT ]] && banner && help && exit || banner
[ ! -d $OUT ] && mkdir -p $OUT
if [[ -z $SIZE ]]
then
	WIDTH=128
	HEIGHT=64
else
	WIDTH=`echo $SIZE | cut -d'x' -f1`
	HEIGHT=`echo $SIZE | cut -d'x' -f2`
fi
[[ -z $FSKP ]] && FSKP=1

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

[ $FSKP -gt 1 ] && echo "[+]Frameskip -> ${FSKP}..." || echo '[*]No Frameskip'
python frameskip.py ${OUTPY} ${OUTPY} $FSKP

sed -i -e 's/$/,/; 1 iimg = [' -i -e '$a]' ${OUTPY}

echo '[+]Removing TEMP...'
rm $TMP
