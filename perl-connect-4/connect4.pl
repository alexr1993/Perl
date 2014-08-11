use strict;
use warnings;
use Readonly; 

require RandomPrograms::Connect4WinConditions;

# globals
Readonly my $BOARD_WIDTH  => 8;
Readonly my $BOARD_HEIGHT => 6;
Readonly my $EMPTY_CELL   => '-';
Readonly my $PLAYERS      => {
    player_one => '@',
    player_two => '#',
};
Readonly my $BOARD        => initBoard();

sub initBoard {
    my @board = ();
    foreach my $x (0..$BOARD_HEIGHT) {
        my @row = ();
        foreach my $y (0..$BOARD_WIDTH) {
            $row[$y] = "-";
        }
        #print @row;
        $board[$x] = \@row;
    }
    return \@board;
}

sub printBoard {
    foreach my $x (0..$BOARD_HEIGHT) {
        foreach my $y (0..$BOARD_WIDTH) {
            print $BOARD->[$x]->[$y];
            print " ";
        }
        print "\n";
    }
}

sub getCounterDestination {
    my ($column_ix) = @_;
    my $row_ix = $BOARD_HEIGHT;

    CELLCHECK:
    while ($BOARD->[$row_ix][$column_ix] ne $EMPTY_CELL) {
        --$row_ix;
        # break if column is completely full
        last CELLCHECK if $row_ix == -1;           
    }
    return $row_ix;
}

sub insertCounterToCell {
    my ($x, $y, $counter) = @_;
    #print "Insert counter $counter in cell ($x, $y)\n";

    $BOARD->[$y][$x] = $counter;
}

# returns row the counter will land in, or -1 if invalid
sub tryGetCounterDestination {
    my ($column_ix) = @_;
    
    # check arg is an integer and valid column
    if ($column_ix =~ m/\d/ && $column_ix <= $BOARD_WIDTH) {
        getCounterDestination($column_ix);
    }
    else {
        return -1;
    }
}

sub getNextPlayer {
    my ($turn_counter) = @_;
    my @players = sort(keys %$PLAYERS);
    my $next_player = @players[$turn_counter % scalar(@players)];
    return $next_player;
}

sub mainLoop {
    printBoard();
    my $turn = 0;
    my $player = undef;
    my $counter = undef;
    my $finished = q{};
    
    MAIN:
    while (!$finished) {
        $player = getNextPlayer($turn);
        $counter = $PLAYERS->{$player};

        print $player . "'s ($counter) " . "turn!\n";
        print "Enter a column...";
        my $column_ix = <>;
        my $row_ix = tryGetCounterDestination($column_ix);
        
        if ($row_ix == -1) {
            print "Invalid Input, try again.\n";
            next MAIN;
        }

        insertCounterToCell($column_ix, $row_ix, $counter);
        $finished
            = RandomPrograms::Connect4WinConditions::hasEnded($BOARD);
        printBoard(); 
        ++$turn;
    }
}

sub init {
    RandomPrograms::Connect4WinConditions::setPlayerTokens(
        values %$PLAYERS);
    mainLoop();
}

init();

