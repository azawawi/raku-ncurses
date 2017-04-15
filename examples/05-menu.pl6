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

my $n_choices = @choices.elems;

sub print_menu($menu_win, $highlight) {
    my $x = 2;
    my $y = 2;
    box($menu_win, 0, 0);
    for 0..$n_choices - 1 -> $i {
        if $highlight == $i + 1 {
            # Highlight the user-selected choice
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

my $highlight = 1;
my $choice = 0;

initscr;
clear;
noecho;
# Line buffering disabled. pass on everything
cbreak;

my $startx = Int((80 - WIDTH) / 2);
my $starty = Int((24 - HEIGHT) / 2);

my $menu_win = newwin(HEIGHT, WIDTH, $starty, $startx);
keypad($menu_win, TRUE);
mvprintw(0, 0, "Use arrow keys to go up and down, Press enter to select a choice");
nc_refresh;
print_menu($menu_win, $highlight);
while True {
    my $c = wgetch($menu_win);
    given $c {
        when KEY_UP {
            if $highlight == 1 {
                $highlight = $n_choices;
            } else {
                $highlight--;
            }
        }
        when KEY_DOWN {
            if $highlight == $n_choices {
                $highlight = 1;
            } else {
                $highlight++;
            }
        }
        when 10 {
            $choice = $highlight;
        }
        default {
            mvprintw(24, 0, sprintf("Character pressed is = %3d Hopefully it can be printed as '%c'", $c, $c));
            nc_refresh;
        }
    }
    print_menu($menu_win, $highlight);

    # User did a choice come out of the infinite loop
    last if $choice != 0;
}

mvprintw(23, 0, sprintf("You chose choice #%d with choice '%s'\n", $choice, @choices[$choice - 1]));
getch;

LEAVE {
    clrtoeol;
    nc_refresh;
    endwin;
}
