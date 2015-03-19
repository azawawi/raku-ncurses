#!/usr/bin/env perl6
use v6;

use NCurses;

my $win = initscr();			         # Start curses mode
if !$win {
	die "Failed to initialize ncurses\n";
}
printw("Hello World");	# Print Hello World
mvaddstr(5, 10, "Press any key to exit...");
nc_refresh();
while getch() < 0 { }
endwin();			# End curses mode
