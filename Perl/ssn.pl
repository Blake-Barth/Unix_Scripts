#!/usr/bin/perl
#Blake Barth---
#This is a perl program for sorting ssn's stored in hash,
#provided to the program by a file. It also enforces one ssn
#per name and every ssn must be followed by a name

use strict; # enforces strict compiling rules

my %hash; #hash stores SSN's and names
my $line; # used to iterate through ssn lines
my $name; # used to hold inputed names

if (@ARGV != 1) { #enforces usage constraint
	print "Usage: ssn.pl filename\n";
	exit 1;
}

while (defined($line = <>)) # goes until file provided is empty
{
	chomp($line); # gets rid of \n
	if (exists ($hash{$line})) # if ssn already in hash
	{
		print "$line already exists for $hash{$line}.\n";
		exit 1;
	}
	
	$name = <>;
	if (!defined($name)) #if name is not given after ssn exit
	{
		print "Expecting a name after ssn: $line\n";
		exit 1;
	}
	chomp($name);
	$hash{$line} = $name; #sets name as value to the ssn key
}

#iterates through list of sorted keys and prints key value pair
foreach my $key (sort keys %hash)
{
	print "$key: $hash{$key}\n";
}
exit 0;
