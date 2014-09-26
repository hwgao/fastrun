#!/bin/bash

if [ ! -f ./fastrun.sh ]; then
	echo "Please check fastrun.sh is in the same directory with install.sh"
	return
fi

if [ -f ~/.bashrc ]; then
	if [ ! `grep -c "fastrun" ~/.bashrc` -eq 0 ]; then
		echo "fastrun is already installed."
		return 
	fi

	mkdir ~/.fr
	cp ./fastrun.sh ~/.fr

	echo "# Following 4 lines are added by fastrun, please don't edit it manually" >> ~/.bashrc
	echo "if [ -f ~/.fr/fastrun.sh ]; then" >> ~/.bashrc
	echo "    . ~/.fr/fastrun.sh" >> ~/.bashrc
	echo "fi" >> ~/.bashrc
	echo "# fastrun end" >> ~/.bashrc

	. ~/.bashrc
else
	echo ".bashrc file doesn't exist, installation is failed"
	return
fi

