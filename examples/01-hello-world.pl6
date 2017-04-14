#!/usr/bin/env perl6
use v6;

use lib 'lib';
use NCurses;

# Start curses mode
my $win = initscr;
die "Failed to initialize ncurses\n" unless $win;

# Print Hello World
printw( "Hello World" );
mvaddstr( 5, 10, "Press any key to exit..." );
nc_refresh;
while getch() < 0 { };

# Cleanup
LEAVE {
    delwin($win)  if $win;

    # End curses mode
    endwin;
}
