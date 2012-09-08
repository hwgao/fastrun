#!/bin/bash

if [ ! -f ./fastkey.sh ]; then
	echo "Please check fastkey.sh is in the same directory with install.sh"
	return
fi

if [ -f ~/.bashrc ]; then
	if [ ! `grep -c "~/.fk/fastkey.sh" ~/.bashrc` -eq 0 ]; then
		echo "fastkey is already installed."
		return 
	fi

	mkdir ~/.fk
	cp ./fastkey.sh ~/.fk

	echo >> ~/.bashrc
	echo "# Added by fastkey, please don't edit it manually" >> ~/.bashrc
	echo "if [ -f ~/.fk/fastkey.sh ]; then" >> ~/.bashrc
	echo "    . ~/.fk/fastkey.sh" >> ~/.bashrc
	echo "fi" >> ~/.bashrc
	. ~/.bashrc
else
	echo ".bashrc file doesn't exist, install is failed"
	return
fi

