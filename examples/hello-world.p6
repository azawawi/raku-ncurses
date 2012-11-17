#!/usr/bin/env perl6
use v6;

BEGIN { @*INC.push('lib') };

use NCurses;

initscr;			# Start curses mode
printw("Hello World !!!\n");	# Print Hello World
getch;			# Wait for user input
endwin;			# End curses mode
