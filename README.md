fastrun
============================

This is a simple bash script used to create a favorite commands list for bash.

fs -- used to save a command into the list
If no parameter, it will save "cd the current directory" into the list.
If having any parameter, the parameter(s) will be saved into the list.
If you want to add an alias to the command "cd the current directory", you can add one parameter -- "@alias".

fv -- use vi to view and edit the list

fr -- show the list and prompt the user to choose a command to run

fr also supports with one parameter. 
a) If the parameter is a number, it will run the command at that line directly.
b) If the parameter is a string, it will search the string in the command list, the matched commands will be listed for user to choose. If there is only one command matched, the command will also be directly run.
	
Notes:
============================
. install.sh -- install fastrun
. remove.sh -- remove the installed fastrun

The string start of @ is alias. You can add @alias at the end of the command to assign an alias.
