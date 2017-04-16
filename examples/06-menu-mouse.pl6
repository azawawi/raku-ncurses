#!/usr/bin/env perl6

#
# Example translated and modified from C source
# http://www.tldp.org/HOWTO/html_single/NCURSES-Programming-HOWTO/
#

use v6;

use lib 'lib';
use NCurses;

constant WIDTH  = 30;
constant HEIGHT = 10;

my @choices = [
    "Choice 1",
    "Choice 2",
    "Choice 3",
    "Choice 4",
    "Exit",
];

my $startx = 0;
my $starty = 0;
my $n_choices = @choices.elems;

sub print_menu($menu_win, $highlight) {
    my $x = 2;
    my $y = 2;
    box($menu_win, 0, 0);
    for 0..$n_choices - 1 -> $i {
        if $highlight == $i + 1 {
            wattron($menu_win, A_REVERSE); 
            mvwprintw($menu_win, $y, $x, sprintf("%s", @choices[$i]));
            wattroff($menu_win, A_REVERSE);
        } else {
            mvwprintw($menu_win, $y, $x, sprintf("%s", @choices[$i]));
        }
        $y++;
    }
    wrefresh($menu_win);
}

# Report the choice according to mouse position
sub report_choice($mouse_x, $mouse_y, $p_choice is rw) {
    my $i = $startx + 2;
    my $j = $starty + 3;
    for 0..$n_choices - 1 -> $choice {
        if ($mouse_y == $j + $choice) && ($mouse_x >= $i) && ($mouse_x <= $i + @choices[$choice].chars) {
            if $choice == $n_choices - 1 {
                $p_choice = -1;
            } else {
                $p_choice = $choice + 1;
            }
            last;
        }
    }
}

# Initialize curses
my $main-win = initscr() or die "Could not initialize ncurses!";
clear;
noecho;
# Line buffering disabled. pass on everything
cbreak;

keypad($main-win, TRUE);

attron(A_REVERSE);
mvprintw(23, 1, "Click on Exit to quit (Works best in a virtual console)");
nc_refresh;
attroff(A_REVERSE);

# Try to put the window in the middle of screen
$startx = Int( (80 - WIDTH) / 2 );
$starty = Int( (24 - HEIGHT) / 2 );

# Print the menu for the first time
my $menu_win = newwin(HEIGHT, WIDTH, $starty, $startx);
print_menu($menu_win, 1);
# Get all the mouse events
mousemask(ALL_MOUSE_EVENTS, 0) or die "Failed to set mousemask!";

# Remember to create mouse event
my MEVENT $event = MEVENT.new;

my $choice = 0;
while True {
    #my $c = wgetch($menu_win);
    my $c = getch;

    if $c == KEY_MOUSE {
        if getmouse($event) == OK {
            # When the user clicks left mouse button
            if $event.bstate & BUTTON1_PRESSED {
                report_choice(Int($event.x) + 1, Int($event.y) + 1, $choice);
                if $choice == -1 {
                    # Exit chosen
                    last;
                }
                mvprintw(22, 1, sprintf("Choice made is #%d. User selected \"%s\".", $choice, @choices[$choice - 1]));
            }
        }
        print_menu($menu_win, $choice);
    }
}

LEAVE {
    endwin;
}
