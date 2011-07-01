#!/usr/bin/perl -w

print "Input filename\n";

$dnaFilename = <STDIN>;

chomp $dnaFilename;

unless (open (DNAFILE, $dnaFilename)) {
    print "Can't open $dnaFilename\n\n";
}

@DNA = <DNAFILE>;

close DNAFILE;

$DNA = join ('', @DNA);

# Remove the whitespace
$DNA =~ s/\s//g;

@DNABases = split ('', $DNA);

print @DNABases;

foreach $base (@DNABases) {
    print $base, "\n";
}
