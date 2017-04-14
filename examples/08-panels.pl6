#!/usr/bin/env perl6

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
my @my-panels;
for @my-wins -> $my-win {
	box($my-win, 0, 0);
    @my-panels.push( new_panel($my-win) );
}

# Update the stacking order. 2nd panel will be on top
update_panels;

# Show it on the screen
doupdate;

# Wait for a keypress
getch;

LEAVE {
    endwin;
}