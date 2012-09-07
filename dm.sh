#!/bin/bash

# save the current directory into favorite list
function ds()
{
	local address="cd `pwd`"	
	OPTIND=1

	# make sure the favorite list file is existed
	if [ ! -e ~/.dm ]; then
		touch ~/.dm
	fi

	while getopts ":d:v" argv
	do
		case $argv in
		d) 
			address="$OPTARG"
			break
			;;
		v)
			vi ~/.dm
			return 
			;;
		*) 
			echo "Usage: ds [-d command] [-v]"
			echo "1. ds -- Save the command "cd to the current directory" into command list"
			echo "2. ds -d command -- save the command into the list"
			echo "3. ds -v -- Show the command list for user to edit"
			return 
			;;
		esac
	done

	local LINE
	local count=1
	while read LINE
	do
		if [ "$LINE" = "$address" ]; then
			echo "The favorite exists"
			return
		fi
		let count++
	done < ~/.dm

	echo $address >> ~/.dm
}

#show the favorite list, and change to the selected directory
function dm()
{
	OPTIND=1
	local number
	local ssss


	while getopts ":" argv
	do
		case $argv in
		*) 
			echo "Usage: dm [string]"
			echo "1. dm -- Show command list for user to choose one to run."
			echo "2. dm string -- Show the commands which include the string."
			return 
			;;
		esac
	done

	if [ ! -s ~/.dm ]; then
		echo "Command list is empty"
		return
	fi

	if [ $# -eq 1 ]; then
		if [ $1 -eq $1 2>/dev/null ]; then
			number=$1
		else
			cat -n ~/.dm | \grep -i "$1"
		fi
	else
		cat -n ~/.dm
	fi


	if [ -z "$number" ]; then
		echo 
		echo -n "Please choose the command:"
		read number
	fi

	local LINE
	local count=0
	while read LINE
	do
		let count++
		if [ $count -eq "$number" ]; then
			echo "Run \"${LINE}\""
			eval $LINE
			echo $LINE >> ~/.bash_history
			return
		fi
	done < ~/.dm
}

alias dv='ds -v'
