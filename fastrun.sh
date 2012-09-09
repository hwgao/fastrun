#!/bin/bash

FR_LIST=~/.fr/.fr_list

# save the current directory into fastrun list
function fs()
{
	local address
	OPTIND=1
	IFS=' '

	# make sure the favorite list file is existed
	if [ ! -e $FR_LIST ]; then
		touch $FR_LIST
	fi

	while getopts ":d:v" argv
	do
		case $argv in
		v)
			vi $FR_LIST
			return 
			;;
		*) 
			echo "Usage: fs [-d command] [-v]"
			echo "1. fs -- Save the command "cd to the current directory" into command list"
			echo "2. fs command -- save the command into the list"
			echo "3. fs -v -- Show the command list for user to edit"
			return 
			;;
		esac
	done

	if [ $# -eq 0 ]; then
		address="cd `pwd`"	
	else
		if [ $# -eq 1 ] && [ ${1:0:1} = "#" ];  then
			address="cd `pwd` $1"
		else
			address=$*
		fi
	fi

	local LINE
	local count=1
	while read LINE
	do
		if [ "${LINE% #*}" = "$address" ]; then
			echo "The favorite exists"
			return
		fi
		let count++
	done < $FR_LIST

	echo $address >> $FR_LIST
}

#show the fastrun list for the user to choose
function fr()
{
	OPTIND=1
	local number

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

	if [ ! -s $FR_LIST ]; then
		echo "Command list is empty"
		return
	fi

	if [ $# -gt 0 ]; then
		if [ $1 -eq $1 2>/dev/null ]; then
			number=$1
		else
			result=`grep -ci "$1" $FR_LIST`
			case $result in
				0) 
					echo "No match found"
					cat -n $FR_LIST
					echo 
					echo -n "Please choose the command:"
					read number
					;;
				1)
					echo "Found only one match, run it directly"
					eval `\grep -i "$1" $FR_LIST`
					return
					;;
				*)
					cat -n $FR_LIST | \grep -i --color=auto "$1"
					echo 
					echo -n "Please choose the command:"
					read number
					;;
			esac
		fi
	else
		cat -n $FR_LIST
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
			echo "Run \"$LINE\""
			eval $LINE
			return
		fi
	done < $FR_LIST
}

alias fv='fs -v'
