#!/bin/bash


# save the current directory into directory list
function ds()
{
	s2=' #*'

	# make sure the dirctory list file is existed
	if [ ! -e ~/.dm ]; then
		touch ~/.dm
	fi

	count=1
	while read LINE
	do
		if [ ${LINE%%$s2} == `pwd` ]; then
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

# view the directory list in vi, and you can edit it
function dv()
{
	if [ -e ~/.dm ] && [ -s ~/.dm ]; then
		vi ~/.dm
	else  
		echo "Dirctory list is empty"
	fi
}

#show the directory list, and change to the selected directory
function dm()
{
	if [ ! -e ~/.dm ] || [ ! -s ~/.dm ]; then
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
