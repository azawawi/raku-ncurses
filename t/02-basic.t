
use v6;

use Test;
use NCurses;

plan 1;

# Start curses mode
my $win = initscr() or die "Failed to initialize ncurses\n";
ok $win, "ncurses mode initialized";

endwin;
