#! /bin/sh

DIR=~/data/Pictures/Wallpaper

NBFILE=`find $DIR -iname "*.jpg" | wc -l`
N=`echo $(($RANDOM % $NBFILE + 1))`

FILE=`ls $DIR | head -n $N | tail -n 1`
LINK=~/conf/awesome/themes/wallpaper

rm $LINK
ln -s $DIR/$FILE $LINK
