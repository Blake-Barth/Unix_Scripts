#!/usr/bin/perl -w
# Blake Barth
# Reads up to ten lines from STDIN and prints them

use strict; #enforces strict compilation rules

my $line_num = 1; # initial line_num is 1
my $line; #line will be read from stdin

#While there are lines left to read and lines don't exceed 10
while (defined($line = <STDIN>) && $line_num <= 10)
{
	chomp($line); #get rid of newline character
	print "$line_num: $line\n"; #print line
	$line_num += 1; #increment
}

exit 0; #return successful
