#!/usr/bin/perl
my ($file,$chr) = @ARGV;
###20221007 by Li Lei
###aim: spliting the sequences from a annotation CDS file by chromosomes;
open (INFILE, "< $file")or die "Can't open $file";
while (<INFILE>) {
		$line = $_;
		chomp $line;
		if ($line =~ /\>/) { #if has fasta >
			close OUTFILE;
            #my $chr = "6H";
			my $seq_name = substr($line,1);
			my @array = split(/\./, $seq_name);
			my $new_file = $array[3];
            #print "$new_file\n";
			  if ($new_file =~ m/^$chr/){ #remove all the whitespace;
                    #print "$new_file\n";
                    #$new_file .= ".fasta";
                    #print "$new_file\n";
                    open (OUTFILE, ">$chr")or die "Can't open: $chr $!";
                    #print OUTFILE "$line\n";
              }
		}
		print OUTFILE "$line\n";
}
close OUTFILE;