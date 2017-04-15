#!/usr/bin/env perl6

#
# Move windows with ncurses
#
# Based on the C example by Paul Griffiths
# http://www.paulgriffiths.net/program/c/srcs/curwin1src.html
#

use v6;

use lib 'lib';
use NCurses;

# Initialize an NCurses main window
my $main-win = initscr() or die "Failed to initialize ncurses\n";

# Switch of echoing and enable keypad (for arrow keys)

noecho;
keypad($main-win, TRUE);

#  Set the dimensions and initial position for our child window
my $width  = 23;
my $height = 7;
my $rows   = getmaxy($main-win);
my $cols   = getmaxx($main-win);
my $x      = Int( ($cols - $width)  / 2 );
my $y      = Int( ($rows - $height) / 2 );

# Make our child window, and add a border and some text to it.
my $child-win = subwin($main-win, $height, $width, $y, $x);
box($child-win, 0, 0);
mvwaddstr($child-win, 1, 4, "Move the window");
mvwaddstr($child-win, 2, 2, "with the arrow keys");
mvwaddstr($child-win, 3, 6, "or HOME/END");
mvwaddstr($child-win, 5, 3, "Press 'q' to quit");

nc_refresh;

# Loop until user hits 'q' to quit
while (my $ch = getch()) != 'q'.ord {
    mvaddstr(1, 1, "($x, $y)");
    given $ch {
        when KEY_UP {
            $y-- if $y > 0;
        }

        when KEY_DOWN {
            $y++ if $y < ($rows - $height);
        }

        when KEY_LEFT {
            $x-- if $x > 0;
        }

        when KEY_RIGHT {
            $x++ if $x < ($cols - $width);
        }

        when KEY_HOME {
            $x = $y = 0;
        }

        when KEY_END {
            $x = ($cols - $width);
            $y = ($rows - $height);
        }
    }

    mvwin($child-win, $y, $x);
    wrefresh($child-win);
}

#  Clean up
LEAVE {
    delwin($child-win) if $child-win;
    delwin($main-win)  if $main-win;
    endwin;
    nc_refresh;
}
