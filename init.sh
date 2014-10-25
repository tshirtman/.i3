#!/usr/bin/env sh
# sudo apt-get install keynav acpi jq i3 pcmanfm lm-sensors sysstat
ln -sf $PWD/keynavrc ~/.keynavrc
ln -sf $PWD/i3blocks.conf ~/.i3blocks.conf
ln -sf $PWD/fonts/* ~/.local/share/fonts/

if [ ! -e ~/i3blocks ]
then
	git clone git://github.com/tshirtman/i3blocks ~/i3blocks
	cd ~/i3blocks
	make
	cd -
fi
