#!/bin/bash


# save the current directory into favorite list
function ds()
{
	if [ $# -eq 1 ] && [ $1 = -h ]; then
		echo "Usage: ds [alias]"
		echo "Save the current directory into favorite list"
		echo "You can choose to provide an alias or not"
		return
	fi

	s2=' #*'

	# make sure the favorite list file is existed
	if [ ! -e ~/.dm ]; then
		touch ~/.dm
	fi

	count=1
	while read LINE
	do
		if [ ${LINE%%$s2} == `pwd` ]; then
			echo "The directory exists"
			return
		fi
		let count++
	done < ~/.dm

	echo -n `pwd` >> ~/.dm
	if [ $# -eq 1 ]; then
		echo " #$1" >> ~/.dm
	else
		echo " #$count" >> ~/.dm
	fi
}

# view the favorite list in vi, and you can edit it
function dv()
{
	if [ $# -eq 1 ] && [ $1 = -h ]; then
		echo "Usage: dv"
		echo "View and edit favorite list in vi"
		return
	fi

	if [ -s ~/.dm ]; then
		vi ~/.dm
	else  
		echo "Dirctory list is empty"
	fi
}

#show the favorite list, and change to the selected directory
function dm()
{
	if [ $# -eq 1 ] && [ $1 = -h ]; then
		echo "Usage: dm [alias]"
		echo "If no alias as the only parameter, show the favorite list for the user to choose the directory to change to"
		echo "If the alias is provided as the only parameter, change to the directory that the alias is represented"
		return
	fi

	if [ ! -s ~/.dm ]; then
		echo "Dirctory list is empty"
		return
	fi

	s1='/* #'
	s2=' #*'

	if [ $# -eq 1 ]; then
		while read LINE
		do
			if [ ${LINE#$s1} -eq $1 ]; then
				echo "Change to ${LINE%%$s2}"
				cd $LINE
				return
			fi
		done < ~/.dm
	fi

	cat -n ~/.dm

	echo -n "Please choose the dirctory:"
	read number

	count=0
	while read LINE
	do
		let count++
		if [ $count -eq $number ]; then
			echo "Change to ${LINE%%$s2}"
			cd $LINE
			break
		fi
	done < ~/.dm
}
