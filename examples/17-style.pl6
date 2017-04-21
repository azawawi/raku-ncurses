#!/usr/bin/env perl6

use v6;
use lib 'lib';
use NCurses;

my %attrs = %(
    "NORMAL"     => A_NORMAL,
    "STANDOUT"   => A_STANDOUT,
    "UNDERLINE"  => A_UNDERLINE,
    "REVERSE"    => A_REVERSE,
    "BLINK"      => A_BLINK,
    "DIM"        => A_DIM,
    "BOLD"       => A_BOLD,
    "PROTECT"    => A_PROTECT,
    "INVIS"      => A_INVIS,
    "ALTCHARSET" => A_ALTCHARSET,
    "ITALIC"     => A_ITALIC,
);

my $stdscr = initscr() or die "Could not initialize curses";

start_color;

init_pair(1, COLOR_WHITE, COLOR_BLUE);
init_pair(2, COLOR_WHITE, COLOR_RED);
init_pair(3, COLOR_WHITE, COLOR_YELLOW);
init_pair(4, COLOR_WHITE, COLOR_BLACK);
init_pair(5, COLOR_WHITE, COLOR_GREEN);
init_pair(6, COLOR_WHITE, COLOR_CYAN);
init_pair(7, COLOR_WHITE, COLOR_MAGENTA);

constant BOX_WIDTH = 18;
my $max-cols       = getmaxx($stdscr);
my $col            = 0;
my $start-row      = 0;
for 1..7 -> $color {
    color_set($color, 0);
    my $row = $start-row;
    for %attrs.keys.sort -> $attr-name {
        move($row, $col);
        my $attribute = %attrs{$attr-name};
        printw(sprintf("%10s: ", $attr-name));
        attron($attribute);
        printw("M" x 5);
        attroff($attribute);
        $row++;
    }
    $col += BOX_WIDTH;
    if $col + BOX_WIDTH > $max-cols {
        $col = 0;
        $start-row += %attrs.keys.elems;
    }
}

getch;

LEAVE {
    delwin($stdscr) if $stdscr;
    endwin;
}
