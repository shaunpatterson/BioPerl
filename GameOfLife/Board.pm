package Board;

sub new {
    my $class = shift;
    my $self = {};

    $self->{width} = shift;
    $self->{height} = shift;

    # Initialize all the cells to zero
    @{$self->{cells}} = ((0) x ($self->{width} * $self->{height}));

    bless ($self, $class);
    return $self;
}

sub getWidth {
    my $self = shift;
    return $self->{width};
}

sub getHeight {
    my $self = shift;
    return $self->{height};
}

sub resetCells {
    my $self = shift;
    @{$self->{cells}} = ((0) x ($self->{width} * $self->{height}));
}

sub getCells {
    my $self = shift;
    return @{$self->{cells}};
}

sub getCell {
    my ($self, $x, $y) = @_;

    return @{$self->{cells}}[$y * $self->{width} + $x];
}

sub isCellSet {
    my ($self, $x, $y) = @_;

    return ($self->getCell ($x, $y) != 0);
}

sub setCell () { 
    my ($self, $x, $y, $val) = @_;

    @{$self->{cells}}[$y * $self->{width} + $x] = $val;
}

sub getRow {
    my ($self, $row) = @_;

    $rowStart = $row * $self->{width};
    $rowEnd = $rowStart + ($self->{width} - 1);

    return @{$self->{cells}}[$rowStart..$rowEnd];
}

sub countNeighbors {
    my ($self, $x, $y) = @_;

    my $count = 0;

    # Left
    if ($x > 0 && $self->isCellSet ($x - 1, $y)) {
        $count++;
    }

    # Top Left
    if ($x > 0 && $y > 0 && $self->isCellSet ($x - 1, $y - 1)) {
        $count++;
    }

    # Top
    if ($y > 0 && $self->isCellSet ($x, $y - 1)) {
        $count++;
    }

    # Top Right
    if ($x < ($self->{width} - 1) && $y > 0 && $self->isCellSet ($x + 1, $y - 1)) {
        $count++;
    }

    # Right
    if ($x < $self->{width} - 1 && $self->isCellSet ($x + 1, $y)) {
        $count++;
    }

    # Bottom Right
    if ($x < ($self->{width} - 1) && $y < ($self->{height} - 1) && $self->isCellSet ($x + 1, $y + 1)) {
        $count++;
    }

    # Bottom
    if ($y < ($self->{height} - 1) && $self->isCellSet ($x, $y + 1)) {
        $count++;
    }

    # Bottom Left
    if ($x > 0 && $y < ($self->{height} - 1) && $self->isCellSet ($x - 1, $y + 1)) {
        $count++;
    }

    return $count;
}

1;
