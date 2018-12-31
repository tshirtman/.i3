#!/usr/bin/env bash
# sudo apt-get install keynav acpi jq i3 pcmanfm lm-sensors sysstat
ln -sf $PWD/keynavrc ~/.keynavrc
ln -sf $PWD/i3blocks.conf ~/.i3blocks.conf

mkdir -p ~/.local/share/fonts/
ln -sf $PWD/fonts/* ~/.local/share/fonts/

pip install --user netiface xkbgroup basiciw colour libpulseaudio
pip install --user https://github.com/enkore/i3pystatus/archive/master.zip

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

while true
do
	read -p "do you want to swap ctrl and capslock (using gsettings) (Y/N)" yn
case $yn in
	[Yy]*) ~/.i3/tools/swap_ctrl; break;;
	[Nn]*) break;;
	*) echo "please answer (y)es or (n)o";;
esac
done

if [ 1 -gt $(grep gnome-keyring ~/.profile|wc -l) ]; then
while true
do
	read -p "do you want to start gnome-keyring in .profile (Y/N)" yn
case $yn in
	[Yy]*) cat .profile-gnome-keyring >> ~/.profile
		break;;
	[Nn]*) break;;
	*) echo "please answer (y)es or (n)o";;
esac
done
fi

if [ 1 -gt $(grep XDG_CURRENT_DESKTOP ~/.profile|wc -l) ]; then
	cat .profile-control-center >> ~/.profile
fi

if [ ! -a ~/.Xresources ]; then
	ln -s $PWD/Xresources ~/.Xresources
fi

if [ ! -a ~/.config/dunst/dunstrc ]; then
	mkdir -p ~/.config/dunst/
	ln -s $PWD/dunstrc ~/.config/dunst/
fi

if [ 1 -gt $(dpkg -l dunst|grep ^ii) ]; then
	sudo apt-get install dunst remove notify-osd
fi

echo 'please add the following rule to in "sudo visudo" if not present already'
echo "%sudo   ALL=NOPASSWD: /usr/local/bin/brightness"
