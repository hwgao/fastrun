fastrun
============================

This is a simple bash script used to create a favorite commands list for bash.

fs -- used to save a command into the list

fv -- use vi to view and edit the list

fr -- show the list and prompt the user to choose a command to run

fr also supports with one parameter. 
a) If the parameter is a number, it will run the command at that line directly.
b) If the parameter is a string, it will search the string in the command list, the matched commands will be listed for user to choose. If there is only one command matched, the command will also be directly run.
	
As the string started with # is the comment in bash, you can add an alias started with # at the end of the command. And you can use "fr #alias" to run the command directly.

Notes:
============================
. install.sh -- install fastrun
. remove.sh -- remove the installed fastrun
