#!/usr/bin/perl -w
#Blake Barth
#Program to track frquency of word in stdn
use strict; #enforce stricct compilation rules

my %frequencies; #hash stores frequencies
my %freq_table; #hash stores words by freq

# Read each line for stdin and get frequency of each word
while (<>) {
    chomp;
    foreach my $word (/[a-zA-Z]{2,}/g) { #words with more than 2 letters g finds all instances 
	$word = lc $word; #lowercase
	if (exists $frequencies{$word}) {
		$frequencies{$word}++;
	}
	else {
		$frequencies{$word} = 1;
	}
    }
}

#adds each word in frequencies to freq_table
foreach my $word (keys %frequencies) {
    push @{$freq_table{$frequencies{$word}}}, $word;
}

# Sorts in descnding order with subroutine
my @sorted_table = sort { $b <=> $a } keys %freq_table;

#header of output
print "frequency index\n";
print "---------------\n";

# Print words by frequency
foreach my $entry (@sorted_table) {
    # Sort alphabetically
    my @word_list = sort @{$freq_table{$entry}};
    
    # Prepare output with indentation after the first line if needed
    my $line = " $entry: ";

    if ($entry > 9)
    {
	$line = "$entry: ";
    }
    my $track = 0; #used to check if word is frist
    
    foreach my $word (@word_list) {
        if (length($line) + length($word) > 77) {
            print "$line\n";
            $line =  "    $word";
        } else {
	    if ($track == 0)
	    {
		    $line .= "$word";
		    $track = 1;
	    }
	    else {
		$line .= ", $word";
            }
        }
    }
    print "$line\n";
}

exit 0;
