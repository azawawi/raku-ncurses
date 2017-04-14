#!/usr/bin/env perl6

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
my $choice = 0;
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
    for 0..$n_choices - 1 -> $i {
        if $mouse_y == $j + $choice && $mouse_x >= $i && $mouse_x <= $i + @choices[$choice].chars {
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
initscr;
clear;
noecho;
# Line buffering disabled. pass on everything
cbreak;

# Try to put the window in the middle of screen
$startx = Int( (80 - WIDTH) / 2 );
$starty = Int( (24 - HEIGHT) / 2 );
my MEVENT $event;

attron(A_REVERSE);
mvprintw(23, 1, "Click on Exit to quit (Works best in a virtual console)");
nc_refresh();
attroff(A_REVERSE);

# Print the menu for the first time
my $menu_win = newwin(HEIGHT, WIDTH, $starty, $startx);
print_menu($menu_win, 1);
# Get all the mouse events
mousemask(ALL_MOUSE_EVENTS, 0);

while True {
    my $c = wgetch($menu_win);
    given $c {
        when KEY_MOUSE {
            if getmouse($event) == 1 { # TODO OK {
                # When the user clicks left mouse button
                if $event.bstate & BUTTON1_PRESSED {
                    report_choice($event.x + 1, $event.y + 1, $choice);
                    if $choice == -1 {
                        # Exit chosen
                        exit;
                    }
                    mvprintw(22, 1, sprintf("Choice made is : %d String Chosen is \"%10s\"", $choice, @choices[$choice - 1]));
                    nc_refresh;
                }
            }
            print_menu($menu_win, $choice);
            last;
        }
    }
}

LEAVE {
    endwin;
}
