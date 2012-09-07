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

	while getopts "d:v" argv
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
			return 
			;;
		esac
	done

	echo address is "$address"

	local count=1
	while read LINE
	do
		if [ "{$LINE}" = "$address" ]; then
			echo "The favorite exists"
			return
		fi
		let count++
	done < ~/.dm

	echo -n $address >> ~/.dm
}

#show the favorite list, and change to the selected directory
function dm()
{
	local ss
	OPTIND=1

	while getopts "s:" argv
	do
		case $argv in
		s)
			echo search "$OPTARG"
			ss=$OPTARG
			;;
		*) 
			echo "Usage: dm [search]"
			echo "1. dm -- Save the command "cd to the current directory" into command list"
			return 
			;;
		esac
	done

	if [ ! -s ~/.dm ]; then
		echo "Command list is empty"
		return
	fi

	echo search string: $ss

	grep -n "$ss" ~/.dm

	echo -n "Please choose the command:"
	read number

	count=0
	while read LINE
	do
		let count++
		if [ $count -eq $number ]; then
			echo "Run \"${LINE}\""
			$LINE
			break
		fi
	done < ~/.dm
}

alias dv='ds -v'
