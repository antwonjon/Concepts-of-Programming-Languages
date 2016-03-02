use strict;
use warnings;

######################################### 	
#    CSCI 305 - Programming Lab #1		
#										
#  < Anthony Skinner >			
#  < anthonyjohnskinner@gmail.com >			
#										
#########################################

# Replace the string value of the following variable with your names.
my $name = "<Anthony Skinner>";
my $partner = "<No One right now :)>";
print "CSCI 305 Lab 1 submitted by $name and $partner.\n\n";

# Checks for the argument, fail if none given
if($#ARGV != 0) {
    print STDERR "You must specify the file name as the argument.\n";
    exit 4;
}

# Opens the file and assign it to handle INFILE
open(INFILE, $ARGV[0]) or die "Cannot open $ARGV[0]: $!.\n";


# YOUR VARIABLE DEFINITIONS HERE...
my $line = "";
# This loops through each line of the file
my $counter = 0;

my %countBigrams;
my @bigram;
my $bigram;
my $countBigrams;

while($line = <INFILE>) {

	# This prints each line. You will not want to keep this line.
	$line =~s/\%\w*<SEP>\w*\<SEP>.*<SEP>//; #Extract song title Step 1
	$line =~s/([\(\.\{\-\_\/\\\:\"\`\+\=\*].*|feat.*)//gi;  # Eliminate superfluous text Step 2
	$line =~s/([?¿!¡.;&\$*%#|*]*)//g; #Eliminate Punctuation Step 3
	$line =~s/([^A-Za-z0-9 ']*)//g; #Filter out Non-English Characters Step 4
	$line = lc $line; #Convert to lowercase Step 5
	$line =~s/\byou\b|\bmy\b|\ba\b|\ban\b|\band\b|\bby\b|\bfor\b|\bfrom\b|\bin\b|\bof\b|\bon\b|\bor\b|\bout\b|\bthe\b|\bto\b|\bwith\b//g; #step 6
	#potentially use an array of hashes where the value becomes the key and then search the array again to that key
	#start creating bigram
	
	#creates bigrams in a mini array of the line
	my @values = split(' ', $line);

	my $i;
	for($i = 0; $i< $#values; $i++){
		$bigram[$i] = $values[$i] . " " . $values[$i + 1];
	}
	#creates full bigram using the mini array
	for($i = 0; $i < $#values; $i++){
		#checks the hash to see if the item exits first
		if(exists($countBigrams{$bigram[$i]})){
			$countBigrams{$bigram[$i]}++;
		} else{
			$countBigrams{$bigram[$i]} = 1;
		}
	}
}

#sorterd by bigram(alphabetically)
my @sortedBigram;
foreach $bigram(sort keys %countBigrams){
	push(@sortedBigram, $bigram);

}


# Close the file handle
close INFILE; 

# At this point (hopefully) you will have finished processing the song 
# title file and have populated your data structure of bigram counts.
print "File parsed. Bigram model built.\n\n";

# User control loop
my $input = "";
while ($input ne "q"){
	print"\n";
	print "Enter a word [Enter 'q' to quit]: ";
	my $sentence = "";
	my $input = <STDIN>;
	my $j = 0;
	chomp($input);

	while($input ne "q" && $j < 20 ){
		#concats input to form sentence
		$sentence .= $input . " ";
		$input = mcw($input, \@sortedBigram, $countBigrams);
		chomp($input);
		$j++;
		
	}
	chomp($sentence);
	chomp($input);
	if($input eq "q"){
		print "\nEXITING PROGRAM\n";
		last;
	}
	print "$sentence\n";
}

 





#this function returns the word that most often follows the input
sub mcw{

	my $input = $_[0];
	chomp($input);
	my @bigram = @{$_[1]};
	my $countBigrams = $_[2];
	#probably the worst alocation of memory possible but at this point
	#I am not too concerned, because I just need to get it done

	
	my @matchedWords;
	my @words;
	my $highest = 0;
	#this gathers an array of matched words in the bigram
	foreach my $phrase (@bigram){
		#split sorted bigram array to compare it with the input in order to get all the bigrams that start with that input 
		@words = split(/ /, $phrase);
		#print "$words[0]\n";
		if($words[0] eq $input){
			#print "$countBigrams{$bigram[$i]} $bigram[$i] \n";
			push(@matchedWords, $phrase);
			#gets the highest frequency for later
			if($countBigrams{$phrase}>=$highest){
				$highest = $countBigrams{$phrase};
			}
		}
	}

	
	#this picks from those matched words, the ones with the highest frequency
	my @highestFreq;
	
	foreach my $match (@matchedWords){
		if($countBigrams{$match} eq $highest){
			push(@highestFreq, $match);
			
		}
	}
	
	#this randomly picks if any had the same count
	if(defined $highestFreq[0]){
		my $randomElement;
		$randomElement = $highestFreq[rand @highestFreq];
		@words = split('\s+', $randomElement);
		return $words[1];
	}
	
	return "q";
}


