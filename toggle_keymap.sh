#!/usr/bin/env sh

bepo=$(setxkbmap -query|grep bepo|wc -l)

if [ $bepo -eq 1 ]; then
	setxkbmap fr
else
	setxkbmap fr bepo
fi

notify-send "$(setxkbmap -query | xargs)"
