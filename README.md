dm
============================

This is a simple bash script used to create a favorite commands list for bash.

ds -- used to save a command into the list

dv -- use vi to view and edit the list

dm -- show the list and prompt the user to choose a command to run


Notes:
============================

This file should be sourced in .bashrc, or copy the content of dm.sh into .bashrc and source .bashrc

How to source this file in .bashrc? 

if [ -f ~/bin/dm.sh ]; then
	. ~/bin/dm.sh
fi

