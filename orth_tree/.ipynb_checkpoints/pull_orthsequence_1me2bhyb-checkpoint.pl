#!/usr/bin/perl
##by Li Lei, 20200520;
#this is to pull the sequence from the 1 copy of the Bmex and two copy of Bhyb;
#usage: 
use strict;
use warnings;
use Data::Dumper;
my ($fasta1,$fasta2,$fasta3,$fasta4,$fasta5,$fasta6,$fasta7,$fasta8,$file)= @ARGV;
#my $fasta1= $ARGV[0];

my %id2seq1 = ();#Bsyl
my $id1 = '';
open(F1,  "$fasta1") or die "Could not open $fasta1";
    while(<F1>){
        chomp;
        if($_ =~ /^>(.+)/){
             my $seqid = $1;
             my @rtemp = split(/\s+/,$seqid);
             #print "$rtemp[0]\n";
             my @gene = split(/\./,$rtemp[0]);
             #print "$gene[1]\n";
              $id1 = $gene[0].".".$gene[1];
             #print "$id1\n";          
        }else{
            $id2seq1{$id1} .= $_;
        }
    }
#print Dumper(\%id2seq1);
close (F1);
#print Dumper(\%id2seq1);

my %id2seq2 = ();#Bmex
my $id2 = '';
open(F2,  "$fasta2") or die "Could not open $fasta2";
    while(<F2>){
        chomp;
        if($_ =~ /^>(.+)/){
             my $seqid = $1;
             my @rtemp = split(/\s+/,$seqid);
             #print "$rtemp[0]\n";
             my @gene = split(/\./,$rtemp[0]);
             #print "$gene[1]\n";
              $id2 = $gene[0].".".$gene[1];
             #print "$id1\n";          
        }else{
            $id2seq2{$id2} .= $_;
        }
    }
#print Dumper(\%id2seq1);
close (F2);

my %id2seq3 = ();#Barb
my $id3 = '';
open(F3,  "$fasta3") or die "Could not open $fasta3";
    while(<F3>){
        chomp;
        if($_ =~ /^>(.+)/){
             my $seqid = $1;
             my @rtemp = split(/\s+/,$seqid);
             #print "$rtemp[0]\n";
             my @gene = split(/\./,$rtemp[0]);
             #print "$gene[1]\n";
              $id3 = $gene[0].".".$gene[1];
             #print "$id1\n";          
        }else{
            $id2seq3{$id3} .= $_;
        }
    }
#print Dumper(\%id2seq1);
close (F3);

my %id2seq4 = ();#Os
my $id4 = '';
open(F4,  "$fasta4") or die "Could not open $fasta4";
    while(<F4>){
        chomp;
        if($_ =~ /^>(.+)/){
             my $seqid = $1;
             my @rtemp = split(/\s+/,$seqid);
             #print "$rtemp[0]\n";
             my @gene = split(/\./,$rtemp[0]);
             #print "$gene[1]\n";
              $id4 = $gene[0];
             #print "$id1\n";          
        }else{
            $id2seq4{$id4} .= $_;
        }
    }
#print Dumper(\%id2seq1);
close (F4);

my %id2seq5 = ();#Bstacei
my $id5 = '';
open(F5,  "$fasta5") or die "Could not open $fasta5";
    while(<F5>){
        chomp;
        if($_ =~ /^>(.+)/){
             my $seqid = $1;
             my @rtemp = split(/\s+/,$seqid);
             #print "$rtemp[0]\n";
             my @gene = split(/\./,$rtemp[0]);
             #print "$gene[1]\n";
              $id5 = $gene[0];
             #print "$id1\n";          
        }else{
            $id2seq5{$id5} .= $_;
        }
    }
#print Dumper(\%id2seq1);
close (F5);

my %id2seq6 = (); #Bdist
my $id6 = '';
open(F6,  "$fasta6") or die "Could not open $fasta6";
    while(<F6>){
        chomp;
        if($_ =~ /^>(.+)/){
             my $seqid = $1;
             my @rtemp = split(/\s+/,$seqid);
             #print "$rtemp[0]\n";
             my @gene = split(/\./,$rtemp[0]);
             #print "$gene[1]\n";
              $id6 = $gene[0];
             #print "$id1\n";          
        }else{
            $id2seq6{$id6} .= $_;
        }
    }
#print Dumper(\%id2seq1);
close (F6);

my %id2seq7 = (); #Bhyb
my $id7 = '';
open(F7,  "$fasta7") or die "Could not open $fasta7";
    while(<F7>){
        chomp;
        if($_ =~ /^>(.+)/){
             my $seqid = $1;
             my @rtemp = split(/\s+/,$seqid);
             #print "$rtemp[0]\n";
             my @gene = split(/\./,$rtemp[0]);
             #print "$gene[1]\n";
              $id7 = $gene[0].".".$gene[1];
             #print "$id1\n";          
        }else{
            $id2seq7{$id7} .= $_;
        }
    }
#print Dumper(\%id2seq1);
close (F7);

my %id2seq8 = (); #Hvul
my $id8 = '';
open(F8,  "$fasta8") or die "Could not open $fasta8";
    while(<F8>){
        chomp;
        if($_ =~ /^>(.+)/){
             my $seqid = $1;
             my @rtemp = split(/\s+/,$seqid);
             #print "$rtemp[0]\n";
             my @gene = split(/\./,$rtemp[0]);
             #print "$gene[1]\n";
              $id8 = $gene[0].".".$gene[1].".".$gene[2].".".$gene[3];
             #print "$id1\n";          
        }else{
            $id2seq8{$id8} .= $_;
        }
    }
#print Dumper(\%id2seq1);
close (F8);




open(GENEID,  "$file") or die "Could not open $file";
#my $header = <SNPID>;
#print "$header";
foreach my $row (<GENEID>){
        chomp $row;
        my @rtemp = split(/\t/,$row);
        my $orthoID = $rtemp[0];
        my $BarbuID = $rtemp[1];
        my $BradiID = $rtemp[2];
        my $BrahyID = $rtemp[3];
        #my @Bhy = split(/,/,$BrahyID);
        #my $BrahyID1 = $Bhy[0];
        #print "$Bhy[1]\n";
        #my $BrahyID2 = $Bhy[1];
           #$BrahyID2=~ s/^\s+|\s+$//g;
        my $BrameID = $rtemp[4];
        #print "$Bhy[1]\n";
        #my @Bram = split(/,/,$BrameID);
        #my $BrameID1 = $Bram[0];
        #my $BrameID2 = $Bram[1];
        #   $BrameID2=~ s/^\s+|\s+$//g;
        my $BrastID = $rtemp[5];
        my $BrasylID = $rtemp[6];
        my $HvulID = $rtemp[7];
        my $OsID = $rtemp[8];
        my $new_file = $orthoID . ".fasta";
        open (OUTFILE, ">$new_file")or die "Can't open: $new_file $!";
        
        if (exists $id2seq1{$BrasylID}){
            print OUTFILE ">$BrasylID\n";
            print OUTFILE "$id2seq1{$BrasylID}\n";
        }
        if (exists $id2seq2{$BrameID}){
            print OUTFILE ">$BrameID\n";
            print OUTFILE "$id2seq2{$BrameID}\n";
        }
        #if (exists $id2seq2{$BrameID2}){
        #    print OUTFILE ">$BrameID2\n";
        #    print OUTFILE "$id2seq2{$BrameID2}\n";
        #}
        if (exists $id2seq3{$BarbuID}){
            print OUTFILE ">$BarbuID\n";
            print OUTFILE "$id2seq3{$BarbuID}\n";
        }
        if (exists $id2seq4{$OsID}){
            print OUTFILE ">$OsID\n";
            print OUTFILE "$id2seq4{$OsID}\n";
        }
        if (exists $id2seq5{$BrastID}){
            print OUTFILE ">$BrastID\n";
            print OUTFILE "$id2seq5{$BrastID}\n";
        }
        if (exists $id2seq6{$BradiID}){
            print OUTFILE ">$BradiID\n";
            print OUTFILE "$id2seq6{$BradiID}\n";
        }
        if (exists $id2seq7{$BrahyID}){
            print OUTFILE ">$BrahyID\n";
            print OUTFILE "$id2seq7{$BrahyID}\n";
        }
        #if (exists $id2seq7{$BrahyID2}){
         #   print OUTFILE ">$BrahyID2\n";
         #   print OUTFILE "$id2seq7{$BrahyID2}\n";
        #}
        if (exists $id2seq8{$HvulID}){
            print OUTFILE ">$HvulID\n";
            print OUTFILE "$id2seq8{$HvulID}\n";
        }
}
close (OUTFILE);
close (GENEID);