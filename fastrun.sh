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

	while getopts ":d:v" argv; do
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
		if [ $# -eq 1 ] && [ ${1:0:1} = "@" ];  then
			address="cd `pwd` $1"
		else
			address=$*
		fi
	fi

	local LINE
	local count=1
	while read LINE; do
		if [ "${LINE% @*}" = "$address" ]; then
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
	local LINE
	local count

	while getopts ":" argv; do
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

	local t=`wc -l $FR_LIST`
	local tot=${t% *} 
	let tot++

	if [ $# -gt 0 ]; then
		result=`\grep -c " @$1" $FR_LIST`
		if [ $result -eq 1 ]; then
			LINE=`\grep " @$1" $FR_LIST`
			echo "Run \"$LINE\""
			eval ${LINE%@*}
			return
		else
			if [[ $1 =~ ^[0-9]+$ ]] \
					&& [ $1 -lt $tot ] \
					&& [ $1 -gt 0 ]; then
				echo "it is a number"
				number=$1
			else
				result=`\grep -c "$1" $FR_LIST`
				if [ $result -eq 1 ]; then
					LINE=`\grep "$as" $FR_LIST`
					echo "Run \"$LINE\""
					eval ${LINE%@*}
					return
				else
					if [ $result -eq 0 ]; then
						cat -n $FR_LIST
					else
						cat -n $FR_LIST | \grep --color=auto "$as"
					fi
					echo 
					read -p "Please choose the command:" number
				fi 
			fi
		fi
	else
		cat -n $FR_LIST
		echo 
		read -p "Please choose the command:" number
	fi


	while true; do
		if [[ ! ($number =~ ^[0-9]+$) ]]; then
			read -p "Please input a number:" number
			continue
		fi

		if [ $number -gt $tot ] || [ $number -lt 1 ]; then
			read -p "Error number, try again:" number
			continue
		else
			break
		fi
	done

	count=0
	while read LINE; do
		let count++
		if [ $count -eq "$number" ]; then
			echo "Run \"$LINE\""
			eval ${LINE%@*}
			return
		fi
	done < $FR_LIST

	echo "Do not found your command:("	
}

alias fv='fs -v'
