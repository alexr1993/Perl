#!/usr/bin/perl -w

use strict;
use warnings;
use Test::More tests => 10;
use Connect4::WinConditions;
use Try::Tiny;

my $horizontal_win = [
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--@@@@--') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
];
my $vertical_win  = [
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '-----@--') ],
    [ split(q{}, '-----@--') ],
    [ split(q{}, '-----@--') ],
    [ split(q{}, '-----@--') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
];
my $left_diagonal_win = [
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--@-----') ],
    [ split(q{}, '---@----') ],
    [ split(q{}, '----@---') ],
    [ split(q{}, '-----@--') ],
];
my $right_diagonal_win = [
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '-----@--') ],
    [ split(q{}, '----@---') ],
    [ split(q{}, '---@----') ],
    [ split(q{}, '--@-----') ],
];
my $empty_board = [
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
];
my $small_board = [
    [ split(q{}, '@@@###@@') ],
    [ split(q{}, '###@##@@') ],
];
my $four_of_different_counters = [
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--@@#@--') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
];
my $three_in_a_row = [
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '---@@@--') ],
    [ split(q{}, '--------') ],
    [ split(q{}, '--------') ],
];

my $pass = 1;
try {
    # should throw exception
    Connect4::WinConditions::setPlayerTokens( @{ ['@@', '#'] } );
    $pass = 0;
};
    
ok ($pass, 'Exception thrown when tokens given are not 1 char');

$pass = 0;
try {
    Connect4::WinConditions::setPlayerTokens( @{ ['-', 'x', '-'] } );
    $pass = 1;
};

ok ($pass, 'Any single char player tokens accepted');


# Now set tokens as something sensible for the rest of the tests
Connect4::WinConditions::setPlayerTokens( @{ ['@', '#'] } );

is (Connect4::WinConditions::hasEnded($horizontal_win),
    1,
    'Horizontal win recognised correctly'
);

is (Connect4::WinConditions::hasEnded($vertical_win),
    1,
    'Vertical win recognised correctly'
);

is (Connect4::WinConditions::hasEnded($left_diagonal_win),
    1,
    'Left diagonal win recognised correctly'
);

is (Connect4::WinConditions::hasEnded($right_diagonal_win),
    1,
    'Right diagonal win recognised correctly'
);

is (Connect4::WinConditions::hasEnded($empty_board),
    0,
    'Empty board recognised as not ended'
);

is (Connect4::WinConditions::hasEnded($small_board),
    0,
    'Different board size correctly examined'
);

is (Connect4::WinConditions::hasEnded($four_of_different_counters),
    0,
    'Four in a row of different counters recognised as not ended'
);

is (Connect4::WinConditions::hasEnded($three_in_a_row),
    0,
    'Three in a row recognised as not ended'
);

