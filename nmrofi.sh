#!/usr/bin/env bash

connections() {
    # list connection names, by sedding everything else out of the nmcli connections output
    # use the UUID format to match what's not part of the name
    nmcli connection \
    |sed 1d\
    |sed 's/^\(.*\) *[[:xdigit:]]\{8\}-[[:xdigit:]]\{4\}-[[:xdigit:]]\{4\}-[[:xdigit:]]\{4\}-[[:xdigit:]]\{12\}.*$/\1/'\
    |sed 's/ *$//'
}

connect () {
    target=$1
    if [[ $(connections | grep -c "$target") -gt 0 ]]; then
        message=$(nmcli connection up "$target")
    else
        message=$(nmcli device wifi connect "$target")
    fi
    notify-send "$message"
}

if [[ -z $@ ]]; then
    nmcli device wifi|sed -s 1d
else
    target=$(echo "$@"| sed -s 's/^.\? *//'|sed -s 's/ *Infra.*//')
    connect $target >& /dev/null &
fi
