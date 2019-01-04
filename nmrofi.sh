#!/usr/bin/env bash

target=$(nmcli device wifi|sed -s 1d|rofi -dmenu -p 📶| sed -s 's/^.\? *//'|sed -s 's/ *Infra.*//')

connections() {
	# list connection names, by sedding everything else out of the nmcli connections output
	# use the UUID format to match what's not part of the name
	nmcli connection \
	|sed 1d\
	|sed 's/^\(.*\) *[[:xdigit:]]\{8\}-[[:xdigit:]]\{4\}-[[:xdigit:]]\{4\}-[[:xdigit:]]\{4\}-[[:xdigit:]]\{12\}.*$/\1/'\
	|sed 's/ *$//'
}

if [[ $(connections | grep -c "$target") -gt 0 ]]; then
	nmcli connection up "$target"
else
	nmcli device wifi connect "$target"
fi

