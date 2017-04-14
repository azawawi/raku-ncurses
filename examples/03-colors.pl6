#!/usr/bin/env perl6

#
# Hello world in color
#
# Based on the C example by Paul Griffiths
# http://www.paulgriffiths.net/program/c/srcs/curhell2src.html
#

use v6;

use lib 'lib';
use NCurses;

# Initialize an NCurses window
my $main-win = initscr;
die "Failed to initialize ncurses\n" unless $main-win;

# Initialize colours
start_color;

constant START-X = 5;
constant START-Y = 20;

# Print message
mvaddstr(START-X, START-Y, " Hello, world! ");

# Check if we have colors with at least 13 colors
if has_colors() && COLOR_PAIRS() >= 13 {

    # Initialize a bunch of colour foreground/background pairs
    init_pair(1,  COLOR_RED,     COLOR_BLACK);
    init_pair(2,  COLOR_GREEN,   COLOR_BLACK);
    init_pair(3,  COLOR_YELLOW,  COLOR_BLACK);
    init_pair(4,  COLOR_BLUE,    COLOR_BLACK);
    init_pair(5,  COLOR_MAGENTA, COLOR_BLACK);
    init_pair(6,  COLOR_CYAN,    COLOR_BLACK);
    init_pair(7,  COLOR_BLUE,    COLOR_WHITE);
    init_pair(8,  COLOR_WHITE,   COLOR_RED);
    init_pair(9,  COLOR_BLACK,   COLOR_GREEN);
    init_pair(10, COLOR_BLUE,    COLOR_YELLOW);
    init_pair(11, COLOR_WHITE,   COLOR_BLUE);
    init_pair(12, COLOR_WHITE,   COLOR_MAGENTA);
    init_pair(13, COLOR_BLACK,   COLOR_CYAN);

    # Print colored "Hello, world!" strings
    for 1..13 -> $n {
        color_set($n, 0);
        mvaddstr(START-X + $n, START-Y, " Hello, world! ");
    }
}

# Refresh the screen and wait for a key press to exit
nc_refresh;
while getch() < 0 { };

# Clean up
LEAVE {
    delwin($main-win) if $main-win;
    endwin;
}
