#!/bin/sh
#Blake Barth
#Script for managing phone entries
#Inserts, Deletes, Modifys, and Prints using a pattern

#Creates dat file if does not exist
touch "phonebook.dat"

#Inserts when given a <last name> <first name> <phone #> <addr> also sorts alphabetically
insert () {
	if [ $# -lt 5 ] # checks args
	then
		echo "Usage: -i <last name> <first name> <phone #> <address>"
		exit 1
	fi
	lname="$2"
	fname="$3"
	pnum="$4"
	shift 4 #shifting allows me to put the addr variable as the remainder
	addr="$@"
	case "$pnum" in # error checking
	       [0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9])
		       ;;
		*)
			echo "Error! Allowed phone # format ###-###-####"
			exit 1
			;;
	esac
	if [ $(grep -c "$lname $fname " phonebook.dat) -gt 0 ] #checks if name exists alr
	then
		echo "Error! Entry already exists"
		exit 1
	fi
	echo "$lname $fname $pnum $addr" >> phonebook.dat
	touch "phonebook.dat.tmp"
	sort phonebook.dat > phonebook.dat.tmp #sorts alphabetically into tmp
	mv phonebook.dat.tmp phonebook.dat

}

#deletes entry in dat file
delete() {
	if [ $# -ne 3 ] #checks args
	then
		echo "Usage: -d <last name> <first name>"
	fi
	lname="$2"
	fname="$3"
	if [ $(grep -c "$lname $fname " phonebook.dat) -gt 0 ] #checks if name in entry
	then
		touch phonebook.dat.tmp #creates tmp
		#Moves everything but selected enrty into tmp
		grep -v "$lname $fname " phonebook.dat > phonebook.dat.tmp
		mv phonebook.dat.tmp phonebook.dat # moves temp into dat file
	else
		echo "No such name found!"
		exit 1
	fi
}

#mofifies selected enrty
modify () {
	if [ $# -lt 4 ] #checks args
	then
		echo "Usage: -m <last name> <first name> <address>"
		exit 1
	fi
	lname="$2"
	fname="$3"
	shift 3 #shifting allows for the proper reading into addr
	addr="$@" 
	if [ $(grep -c "$lname $fname " phonebook.dat) -gt 0 ]
	then
		touch phonebook.dat.tmp #using temp to write selected entry into
		grep "$lname $fname " phonebook.dat > phonebook.dat.tmp
		pnum="$(awk '{print $3}' phonebook.dat.tmp)" # using awk to read phonenum
		rm phonebook.dat.tmp # get rid of temp 
		delete "-d" "$lname" "$fname" #delete selected entry
		insert "-i" "$lname" "$fname" "$pnum" "$addr" #reinsert it with new addr
	else
		echo "No such name found!"
		exit 1
	fi
}

#Prints file based on grep pattern
print_pattern (){
	if [ $# -ne 2 ] #check args
	then
		echo "Usage: -p <pattern>"
		exit 1
	fi
	
	#If no entries found then print that
	if [ "$(grep -c "$2" phonebook.dat)" -eq 0 ]
	then
		echo "No entries matched the pattern $2"
		exit 1
	else # else print the entries found using pattern
		echo "$(grep "$2" phonebook.dat)"
	fi
}

#Case statement to get all init args
case "$1" in
	-i)
	insert "$@"
	;;
	-d)
	delete "$@"
	;;
	-m)
	modify "$@"
	;;
	-p)
	print_pattern "$@" # @ passes in all args
	;;
	*) # if incorrect initial arg print that
	echo "Error! Must use -i -d -m -p as first argument" 
	exit 1
	;;
esac
exit 0 # If no errors exit 0
