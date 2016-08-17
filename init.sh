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

if [ ! -e /usr/local/bin/brightness ]; then
	sudo cp $HOME/.i3/brightness /usr/local/bin/
fi

if [ ! -e /etc/apt/sources.list.d/i3.list ]; then
	echo "deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe"\
	    | sudo tee /etc/apt/sources.list.d/i3.list
	sudo apt-get update
	sudo apt-get --allow-unauthenticated install sur5r-keyring
	sudo apt-get update
	sudo apt install i3
fi

echo 'please add the following rule to in "sudo visudo" if not present already'
echo "%sudo   ALL=NOPASSWD: /usr/local/bin/brightness"
