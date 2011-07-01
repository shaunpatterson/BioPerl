#!/usr/bin/perl

use warnings;
use strict;

use Board;


main ();

sub main {
    my $board = Board->new (50, 10);

    unless ($board->getWidth () == 50) {
        print "Width test failed\n";
        exit;
    }

    unless ($board->getHeight () == 10) {
        print "Height test failed\n";
        exit;
    }

    unless ($board->getCell (5, 5) == 0 &&
            $board->getCell (0, 0) == 0) {
        print "getCell test1 failed";
        exit;
    }
    
    $board->setCell (0, 0, 1);
    unless ($board->getCell (0, 0) == 1) {
        print "getCell test2 failed";
        exit;
    }
    unless ($board->isCellSet (0, 0)) {
        print "isCellSet failed";
        exit;
    }

    unless ($board->countNeighbors (0, 0) == 0 &&
            $board->countNeighbors (1, 0) == 1 && 
            $board->countNeighbors (0, 1) == 1 &&
            $board->countNeighbors (1, 1) == 1) {
        print "countNeighbors 1 failed";
        exit;
    }

    # Create a cell with 8 neighbors
    $board->setCell (4, 4, 1);
    $board->setCell (5, 4, 1);
    $board->setCell (6, 4, 1);
    $board->setCell (4, 5, 1);
    $board->setCell (5, 5, 1);
    $board->setCell (6, 5, 1);
    $board->setCell (4, 6, 1);
    $board->setCell (5, 6, 1);
    $board->setCell (6, 6, 1);

    unless ($board->countNeighbors (5, 5) == 8 &&
            $board->countNeighbors (4, 4) == 3 &&
            $board->countNeighbors (6, 6) == 3) {
        print "countNeighbors 2 failed";
        exit;
    }


}



