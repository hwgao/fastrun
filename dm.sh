#!/bin/bash

ure the dirctory list file is existed
touch ~/.dm

# save the current directory into directory list
function ds()
{
	while read LINE
	do
		if [[ $LINE == `pwd` ]]; then
			return
		fi
	done < ~/.dm

	echo `pwd` >> ~/.dm
}

# view the directory list in vi, and you can edit it
function dv()
{
	vi ~/.dm
}

#show the directory list, and change to the selected directory
function dm()
{
	cat -n ~/.dm

	echo -n "Please choose the dirctory:"
	read number

	count=0
	while read LINE
	do
		let count++
		if [[ $count -eq $number ]]; then
			echo "Change to $LINE"
			cd $LINE
			break
		fi
	done < ~/.dm
}
