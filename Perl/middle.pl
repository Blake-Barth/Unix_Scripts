#!/usr/bin/perl -w
#Blake Barth
#middle.pl reads middle n lines of <STDIN> given by -n (def 10)

use strict; #enforces strict compilation rules

#default 10 lines
my $num_lines = 10;

#checks if arguments given
if (@ARGV)
{
	#if arguments provided check formating
	if ($ARGV[0] =~ /^-(\d+)/)
	{	
		#get rid of - for -n
		$num_lines = substr($ARGV[0], 1); 
		#substr function found at www.geeksforgeeks.org/perl-substr-function/
	}
	else
	{	#print error giving arg formatting
		print "USAGE middle.pl -n <number of lines>";
		exit 1;
	}
}

#reads STDIN into array lines
my @lines = <STDIN>;
my $first_index = ($#lines + 1 - $num_lines) / 2; #calculates first index rounding down on odds
my $last_index = ($first_index + $num_lines - 1); #calculates last index


if ($first_index < 0) #just checks if file calculations are off due to small file size
{
	$first_index = 0; #if so just print whole file
	$last_index = $#lines;
}

for (my $i=$first_index; $i <=$last_index; $i++) #Print lines calculated
{
	chomp($lines[$i]);
	print "$lines[$i] \n";
}

exit 0; #return success
