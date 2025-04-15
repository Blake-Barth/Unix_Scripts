#!/usr/bin/perl
#Blake Barth
#Justify.pl takes an inputfile an outputfile and max_width given in stdin
#Outputs the text from inp file to out file but justified at max_width columns
use strict; # strict comp rules

# Read input/output file names and max width from standard input
chomp(my $input_file = <STDIN>);
chomp(my $output_file = <STDIN>);
chomp(my $max_width = <STDIN>);

# Open input and output files, die if it can't
open IN, "<$input_file" or die "Cannot open $input_file";
open OUT, ">$output_file" or die "Cannot open $output_file";

# Initialize variables
my @word_list = ();    # Stores words for the current line
my @paragraph = ();    # Stores words for the current paragraph
my $len = 0; #length of all words in word_list

# Read the input file line by line
while (my $line = <IN>) {
    chomp($line);
    # If we hit an empty line, process the paragraph
    if ($line =~ /^\s*$/ || eof IN){ #if end of paragraph or file
	if ($line !~ /^\s*$/) #if it is not end of paragraph I need to include last line
	{
		push @paragraph, split(/\s+/, $line);
	}
	foreach my $word (@paragraph) { # iterate through words 
		push @word_list, $word;
		$len += length($word); #when words excess max_width
		if (scalar @word_list + $len - 1 > $max_width)
		{
			pop @word_list; #remove most recent word, will be added to next line
			$len -= length($word); 
			my $last = pop @word_list; # remove last word so as to not add spaces to it 
			@word_list = reverse @word_list; # reverse to add more spaces to end
			my $spaces = $max_width - $len; #calc spaces neeeded
			while ($spaces > 0 && scalar @word_list > 0)
			{
				foreach my $word_to_justify (@word_list) #add spaces until line is full
				{
					if ($spaces > 0)
					{
						$word_to_justify .= " ";
						$spaces -=1;
					}
				}
			}
			@word_list = reverse @word_list; #RESET EVERYTHING
			push @word_list, $last;
			print OUT join("",@word_list), "\n";
			$len = length($word);
			@word_list = ($word); #add the initial word to new line
		}
	}
	if ($len > 0) #if there are trailing words print them and RESET
	{
		print OUT join(" ",@word_list), "\n";
		$len = 0;
		@word_list = ();
	}
	print OUT "\n";
	@paragraph = ();
    }

    else # if not end of paragraph, push line to paragraph
    {
        # Split the line into words and store in paragrap
        push @paragraph, split(/\s+/, $line);
    }
}

# Close files
close IN;
close OUT;
exit 0;
