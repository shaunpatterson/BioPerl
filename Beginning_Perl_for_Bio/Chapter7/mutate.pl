#!/usr/bin/perl -w

use warnings;
use strict;

my $DNA = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";

my $i = 0;

my $mutant;

srand (time|$$);

$mutant = mutate ($DNA);

print "\n";
print "Mutant DNA:\n$mutant\n";

for ($i = 0; $i < 10; $i++) {
    $mutant = mutate ($mutant);
    print "$mutant\n";
}

sub mutate {
    my ($dna) = @_;
    my (@nucleotides) = ('A', 'C', 'G', 'T');

    # Pick a random position
    my ($position) = randomPosition ($dna);

    # Pick a random nucleotide
    my ($newBase) = randomNucleotide (@nucleotides);

    # Insert the random nucleotide into a random position
    substr ($dna, $position, 1, $newBase);

    return $dna;
}

sub randomElement {
    my (@array) = @_;
    return $array [rand @array];
}

sub randomNucleotide {
    my (@nucleotides) = ('A', 'C', 'G', 'T');

    return randomElement (@nucleotides);
}

sub randomPosition {
    my ($string) = @_;

    return int rand length $string;
}
