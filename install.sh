#! /bin/sh

source "../functions/functions"
RM=rm

stat_busy "Awesome installation"

for dir in config; do
  if [ ! -d ~/.$dir ]; then
    mkdir ~/.$dir
    printhl "$dir created"
  fi
done

for file in awesome; do
  if [ -e ~/.config/$file ]; then
    $RM ~/.config/$file
  fi
  ln -s $PWD ~/.config/$file
  printhl "$file linked"
done

stat_done
