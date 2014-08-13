package RandomPrograms::Connect4WinConditions;
use strict;
use warnings;
use Readonly;
use Data::Dumper qw(Dumper);

my @PLAYER_TOKENS    = undef;

sub setPlayerTokens {
    @PLAYER_TOKENS = @_;
    print "Players in this game are: " . join(", ", @PLAYER_TOKENS) . "\n";
}

# checks list of strings for 4 player tokens in a row
sub _containsFourInARow {
    my ($string) = @_;
    
    foreach my $token (@PLAYER_TOKENS) {
        if (index($string, $token x 4) > -1) {
            print "4 in a row!\n";
            return 1;
        }
    }
    return 0;     
}

sub _hasHorizontalWin {
    #print "Checking horizontal win...\n";
    my ($board) = @_;
    
    foreach my $row (0.. @$board - 1) {
        #print "$row ";
        #print join(", ", @{ $board->[$row] }) . "\n";
        
        # q{} is the empty string
        if ( _containsFourInARow( 
                 join(q{}, @{ $board->[$row] }))) {
        
            return 1;
        }
    }
    return 0;
}

sub _hasVerticalWin {
    #print "Checking vertical win...\n";
    my ($board) = @_;
    my $transposed = _transposeOf($board);
    return _hasHorizontalWin($transposed);
}

sub _transposeOf {
    my ($board) = @_;
    my $transposed_ref = [];

    foreach my $column(0.. @{ $board->[0] } - 1) {
        my @column_arr = ();
        foreach my $row (0.. @{ $board } - 1) {
            push(@column_arr, $board->[$row]->[$column]);
        }
        $transposed_ref->[$column] = \@column_arr;
    }
    return $transposed_ref;
}

# rotate square matrix
sub _rotateMatrix {
    my ($matrix_ref, $direction) = @_;
    my $rotated_matrix_ref = [];
    my $height = @{ $matrix_ref } - 1;
    my $width  = @{ $matrix_ref->[0] } - 1;

    foreach my $row (0.. $height) {
        foreach my $column (0.. $width) {
            if ($row == 0) {
                $rotated_matrix_ref->[$column] = [];
            }
            $rotated_matrix_ref->[$column][$height - $row]
                = $matrix_ref->[$row][$column];
        }
     }
    return $rotated_matrix_ref;
}

sub _convertToDiamondMatrix {
    my ($board, $tilt_direction) = @_;
    my @diagonal_rows = ();
    my $diag_ix = undef;
    my $board_height = @{ $board } - 1;
    
    foreach my $row (0.. $board_height) { 
        $diag_ix = $row;
        
        foreach my $column (0.. @{$board->[0] } - 1) { 
            if ( !$diagonal_rows[$diag_ix] ) {
                $diagonal_rows[$diag_ix] = [];
            }
            push( @{ $diagonal_rows[$diag_ix] }, $board->[$row]->[$column] );
            ++$diag_ix;
        }
    }
    return \@diagonal_rows;
}

sub _hasDiagonalWin {
    #print "Checking diagonal... \n";
    my ($board) = @_;
    my $right_tilt_diagonals_ref = _convertToDiamondMatrix(
        $board, 'right');
    my $left_tilt_diagonals_ref  = _convertToDiamondMatrix(
        _rotateMatrix($board), 'left');
    
    return _hasHorizontalWin($right_tilt_diagonals_ref)
        || _hasHorizontalWin($left_tilt_diagonals_ref);

}

sub hasEnded {
    my ($board) = @_;
    return  _hasHorizontalWin($board) 
         || _hasVerticalWin($board)
         || _hasDiagonalWin($board);
}

return 1;
