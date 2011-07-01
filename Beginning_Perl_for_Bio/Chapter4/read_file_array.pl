#!/usr/bin/perl -w

# Reading protein sequence data from a file 

$fileName = 'NM_021964fragment.pep';

open (PROTEINFILE, $fileName);

@protein = <PROTEINFILE>;

print @protein;

close PROTEINFILE;
