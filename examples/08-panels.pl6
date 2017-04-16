#!/usr/bin/env perl6

#
# Example translated and modified from C source
# http://www.tldp.org/HOWTO/html_single/NCURSES-Programming-HOWTO/
#

use v6;

use lib 'lib';
use NCurses;

my $lines = 10;
my $cols = 40;
my $y = 2;
my $x = 4;

initscr() or die "Could not initialize curses window";
cbreak;
noecho;

# Create windows for the panels */
my @my-wins = [
    newwin($lines, $cols, $y, $x),
    newwin($lines, $cols, $y + 1, $x + 5),
    newwin($lines, $cols, $y + 2, $x + 10),
];

#
# Create borders around the windows so that you can see the effect panels
# and attach a panel to each window (Order is bottom up)
#
for @my-wins -> $my-win {
	box($my-win, 0, 0);
    new_panel($my-win);
    wrefresh($my-win);
}

# Update the stacking order. 2nd panel will be on top
update_panels;

# Wait for a keypress
getch;

LEAVE {
    endwin;
}
