#!/bin/bash

FR_LIST=~/.fr/.fr_list

# save the current directory into fastrun list
function fs()
{
	OPTIND=1
	IFS=' '
	local address
	local aliass

	# make sure the favorite list file is existed
	if [ ! -e $FR_LIST ]; then
		touch $FR_LIST
	fi

	while getopts ":c:v" argv; do
		case $argv in
		v)
			vi $FR_LIST
			return 
			;;
		c)
			address=$OPTARG
			;;
		*) 
			echo "Usage: fs [-v] | [-c command] [alias]"
			echo "The option -v will trigger the vi to show the command list for user to edit"
			echo "The option -c let the user to add a command. If no this option, cd the current path will be saved into the list"
			echo "The user can also provide an alias for the command."	
			return 
			;;
		esac
	done

	shift $(($OPTIND - 1))

	if [ $# -gt 0 ]; then
		aliass=@$1
	fi
	
	if [ -z "$address" ]; then
		address="cd `pwd`"	
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

	echo $address $aliass >> $FR_LIST
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
			echo "Usage: fr [alias|number|string]"
			echo "If no parameter, list the commands for user to choose."
			echo "If with one parameter, it will first check if this parameter is matching with an alias. If not, check if this parameter is a number and match a line number in the list. If not, do a global search in this list. If there is only one result, run the corresponding command directly"
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
		result=`\grep -cw "@$1" $FR_LIST`
		echo "result=$result"
		if [ $result -eq 1 ]; then
			LINE=`\grep -w "@$1" $FR_LIST`
			echo "Run \"$LINE\""
			eval ${LINE%@*}
			return
		else
			if [[ ($1 =~ ^[0-9]+$) && ($1 -lt $tot) && ($1 -gt 0) ]]; then
				number=$1
			else
				result=`\grep -c "$1" $FR_LIST`
				if [ $result -eq 1 ]; then
					LINE=`\grep "$1" $FR_LIST`
					echo "Run \"$LINE\""
					eval ${LINE%@*}
					return
				else
					if [ $result -eq 0 ]; then
						cat -n $FR_LIST
					else
						cat -n $FR_LIST | \grep --color=auto "$1"
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

		if [[ ($number -gt $tot) || ($number -lt 1) ]]; then
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
