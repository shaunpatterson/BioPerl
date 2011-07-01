#!/usr/bin/perl

use warnings;
use strict;

use Board;

main ();

sub main {
    my $board = Board->new (50, 10);
    
    seedBoard ($board);

    print $board->countNeighbors (0, 0) . "\n";

    for (my $i = 0; $i < 1000; $i++) {
        my $nextGeneration = computeNextGeneration ($board);
        displayBoard ($nextGeneration);
        print "\n\n";

        $board = $nextGeneration;
    }
}

sub seedBoard () {
    my $board = shift;

    for (my $i = 0; $i < 250; $i++) {
        my $x = rand ($board->getWidth () - 1);
        my $y = rand ($board->getHeight () - 1);
        $board->setCell ($x, $y, 1);
    }
}

sub displayBoard {
    my $board = shift;

    foreach my $row (0..$board->getHeight () - 1) {
        print "$row: " . join ("|", $board->getRow ($row)) . "\n";
    }
}

sub computeNextGeneration {
    my $board = shift;

    # Create a new board
    my $nextBoard = Board->new ($board->getWidth (), $board->getHeight ());

    foreach my $row (0..$board->getHeight () - 1) {
        foreach my $col (0..$board->getWidth () - 1) {
            my $count = $board->countNeighbors ($col, $row);

            if ($board->isCellSet ($col, $row)) {
                if ($count <= 1 or $count >= 4) {
                    # Cell dies
                    $nextBoard->setCell ($col, $row, 0);
                }

                if ($count == 2 or $count == 3) {
                    # Cell survives...
                    $nextBoard->setCell ($col, $row, 1);
                }
            } else {
                if ($count == 3) {
                    # Populated
                    $nextBoard->setCell ($col, $row, 1);
                }
            }
        }
    }

    return $nextBoard;
}
