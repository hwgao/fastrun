dm
============================

This is a simple bash script used to create a favorite directories list for bash.

ds -- used to save the current directory into the list

dv -- use vi to view and edit the list

dm -- show the list and prompt the user to choose a directory to change to

Notes:

This file should be sourced in the .bashrc, or copy the content of dm.sh into .bashrc and source .bashrc

Todo:

Alias support:

ds -- can accept one parameter as the alias to the direcory. If not, a number will be assigned to the directory as the alias.

dm -- can change to the directory directly if an alias of the directory as the only parameter is provided.

