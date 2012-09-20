fastrun
============================

This is a simple bash script used to create a favorite commands list for bash.

fs -- used to save a command into the list
Usage: fs [-v] | [-c command] [alias]

If no -c option, it will save "cd the current directory" into the list. Or it will save the command. 
You can also provide an alias for the command.

fv -- use vi to view and edit the list
Actually it is an alias of fs -v

fr
Usage: fr [alias|number|string]

If no parameter, show the command list for user to choose.
fr also supports with one parameter to search in the command list. 
It will search in the aliases first. If no result, and if the parameter is a number, it will check if it is a valid line number of the list. If not, do a global search in the list.
If there is only one result, it will run it directly. For more than one results, the results will be listed for user to choose. 
	
Notes:
============================
. install.sh -- install fastrun
. remove.sh -- remove the installed fastrun

Limitations:
============================
(List all the known limitations)
. Can not execute the command which "source, vi"
. Can not run other interactive script

