#!/usr/bin/perl
##by Li Lei, 2022-03-22, Alameda;
#this is to pick the representative transcript from the file.

#usage: 
use strict;
use warnings;
use Data::Dumper;
my $file= $ARGV[0];

my %tehash;


open(SNPID,  "$file") or die "Could not open $file";

foreach my $row (<SNPID>){
        chomp $row;
        my @rtemp = split(/\t/,$row);
        my @tmp = split(/;/,$rtemp[8]);
        #print "$tmp[0]\n";
        my @tt =split(/\./,$tmp[1]);
        #print "$tt[1]\n";
        if ($tt[4] == 1){
           print "$row\n";
        }
}
close (SNPID);
