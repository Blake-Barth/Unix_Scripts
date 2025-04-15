#!/bin/sh
#Name- Blake Barth
#Modifies the calendar argument interface

#Gets current month and year from date command
month=$(date +%m)
year=$(date +%Y)

#if no arguments given gives current calendar
if [ $# -eq 0 ]
then
	cal $month $year
	exit 0
fi

if [ $# -gt 2 ]
then
	echo "Too many argymenrs. (0, 1, or 2)"
	exit 1
fi


modified_year=0 #Tracks if first argument is month or year

#Assigns month or year variable based on argument 1
case "$1" in
	Jan|jan)
	month=1
	;;
	Feb|feb)
	month=2
	;;
	Mar|mar)
	month=3
	;;
	Apr|apr)
	month=4
	;;
	May|may)
	month=5
	;;
	Jun|jun)
	month=6
	;;
	Jul|jul)
	month=7
	;;
	Aug|aug)
	month=8
	;;
	Sep|sep)
	month=9
	;;
	Oct|oct)
	month=10
	;;
	Nov|nov)
	month=11
	;;
	Dec|dec)
	month=12
	;;
	1|2|3|4|5|6|7|8|9|10|11|12)
	month="$1"
	;;
	*[!0-9]*|0) #Checks for non numeric arguments, or a zero value
	echo "$1 is not a valid month"
	exit 1 #fails for invalid first argument
	;;
	*)
	year="$1"
	modified_year=1
	;;
esac

#Error checking alreadt done for first argument
if [ $# -eq 1 ]
then	
	#checks if year was changed (meaning $1 is a year)
	if [ $modified_year -eq 1 ]
	then
		cal $year
	else
		cal $month $year
		exit 0
	fi
fi

if [ $# -eq 2 ]
then
	#if the year was changed then argument 1 should fail
	if [ "$modified_year" -eq 1 ]
	then
		echo "$1 is not a valid month"
		exit 0
	fi
	case $2 in
		*[!0-9]*|0) #The year should be a valid positive number
		echo "$2 is not a valid year"
		exit 1
		;;
		*)
		year=$2
		;;
	esac
	cal $month $year
	exit 0
fi

