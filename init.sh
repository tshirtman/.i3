#!/usr/bin/env sh
# sudo apt-get install keynav acpi jq i3 pcmanfm lm-sensors sysstat
ln -sf $PWD/keynavrc ~/.keynavrc
ln -sf $PWD/i3blocks.conf ~/.i3blocks.conf

mkdir -p ~/.local/share/fonts/
ln -sf $PWD/fonts/* ~/.local/share/fonts/

if [ ! -e ~/i3blocks ]
then
	git clone git://github.com/tshirtman/i3blocks ~/i3blocks
	cd ~/i3blocks
	make
	cd -
fi

if [ -n -f /usr/local/bin/brightness ]; then
	sudo cp $HOME/.i3/brightness /usr/local/bin/
fi
echo 'please add the following rule to in "sudo visudo" if not present already'
echo "%sudo   ALL=NOPASSWD: /usr/local/bin/brightness"
