#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

#by Li Lei 05-03-2022 in Berkeley 
#This script is to extract the sinlge copy orthologues ID from the 
#usage:

my ($file1, $file2) = @ARGV;
my %hash;
open(TXT, "$file1") or die "Could not open $file1";
#read in the DNA string using the fasta subfunction
my $header = <TXT>;
foreach my $row (<TXT>){
        chomp $row;
        my @rtemp = split(/\t/,$row);
        my $mex_ID = $rtemp[0];
        $hash{$mex_ID} = $row;
}
close (TXT);

#print Dumper(\%hash);

open(IN, "$file2") or die "Could not open $file2";
#read in the DNA string using the fasta subfunction
foreach my $row (<IN>){
        chomp $row;
        my @temp = split(/\t/,$row);
        if (exists $hash{$temp[0]}){
            print "$hash{$temp[0]}\n";
        }
}
close (IN);