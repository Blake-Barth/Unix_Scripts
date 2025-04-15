#!/bin/sh
#Name - Blake Barth
# junk.sh moves files and directories to a .junk directory

# checks if exactly one arument is provided (filename)
if [ $# -ne 1 ]
then
	echo "Error! Provide exactly one argument (filename)."
	exit 1
fi

#Creates variables for script
fileName="$1"
isDir=0

# check if file exists
if [ ! -e "$fileName" ] 
then
	echo "Error! "$fileName" does not exist in current directory."
	exit 1
#checks if file is writable
elif [ ! -w "$fileName" ]
then
	echo "Error! "$fileName" is not writable."
	exit 1
#checks if file is a directory, if so prompt user to check
elif [ -d "$fileName" ]
then
	echo ""$fileName" is a directory."
	isDir=1
	loop="running"
	while [ $loop != "done" ]
	do
		echo "Would you like to junk the whole directory? (y/n):"
		read input
	
		if [ "$input" = "n" ] || [ "$input" = "N" ]
		then
			echo "Ok! Aborting junk operation."
			exit 1
		elif [ "$input" != "y" ] && [ "$input" != "Y" ]
		then
			echo "Try Again! Please enter y or n."
		else
			loop="done"
		fi
	done
fi

#create .junk directory if it doesnt exist
if [ ! -d "$HOME/.junk" ]
then
	mkdir "$HOME/.junk"
	echo 'Created .junk directory in Home Directory'
fi

#Check inside .junk directory for file already existing,
#if file already exists asks user to overwrite
#if directory already exists print error
cwd=$(pwd)
cd "$HOME/.junk"
if [ -e "$fileName" ]
then	
	if [ -f "$fileName" ]
	then
		echo ""$fileName" is a file already in the .junk directory."
		loop="running"
		while [ "$loop" != "done" ]
		do
			echo "Would you like to overwrite it? (y/n):"
			read input
	
			if [ "$input" = "n" ] || [ "$input" = "N" ]
			then
				echo "Ok! Aborting junk operation."
				cd "$cwd"
				exit 1
			elif [ "$input" != "y" ] && [ "$input" != "Y" ]
			then
				echo "Try Again! Please enter y or n."
			else
				loop="done"
			fi
		done
	else
		echo "Error! "$fileName" is a directory already in .junk directory"
		cd "$cwd"
		exit 1
	fi
	rm "$fileName"
	echo "Overwriting file already in .junk directory."
fi
cd "$cwd"

#move the file to the junk directory
mv "$fileName" "$HOME/.junk"
if [ "$isDir" -eq 1 ]
then
	echo "Directory moved to .junk directory."
else
	echo "File moved to .junk directory."
fi
exit 0
	
	
