#!/usr/bin/env perl6

#
# Example translated and modified from C source
# http://www.tldp.org/HOWTO/html_single/NCURSES-Programming-HOWTO/
#

use v6;

use lib 'lib';
use NativeCall;
use NCurses;

sub print_in_middle($win, $starty, $startx, $width, Str $string, $color) {
    my $x;
    my $y;

    getyx($win, $y, $x);
    $x     = $startx if $startx != 0;
    $y     = $starty if $starty != 0;
    $width = 80 if $width == 0;

    $x = $startx + Int( ($width - $string.chars) / 2);
    wattron($win, $color);
    mvwprintw($win, $y, $x, sprintf("%s", $string));
    wattroff($win, $color);
    nc_refresh;
}

my @choices = [
    "Choice 1",
    "Choice 2",
    "Choice 3",
    "Choice 4",
    "Choice 5",
    "Choice 6",
    "Choice 7",
    "Choice 8",
    "Choice 9",
    "Choice 10",
    "Exit",
];

#  Initialize curses 
my $win = initscr() or die "Could not initialize curses";
start_color;
cbreak;
noecho;
keypad($win, TRUE);
init_pair(1, COLOR_RED, COLOR_BLACK);
init_pair(2, COLOR_CYAN, COLOR_BLACK);

# Create items
my $n-choices = @choices.elems;
my $my-items  = CArray[ITEM].new;

# Workaround to keep them in-memory
my @str-choices;
for 0..$n-choices - 1 -> $i {
    @str-choices.push( CArray[uint8].new(@choices[$i].encode.list) );
    $my-items[$i] = new_item(@str-choices[$i], @str-choices[$i]);
}
$my-items[$n-choices] = ITEM.new;  # NULL

#  Create menu 
my $my-menu = new_menu($my-items);

#  Create the window to be associated with the menu 
my $my-menu-win = newwin(10, 40, 4, 4);
keypad($my-menu-win, TRUE);
 
#  Set main window and sub window 
set_menu_win($my-menu, $my-menu-win);
set_menu_sub($my-menu, derwin($my-menu-win, 6, 38, 3, 1));
set_menu_format($my-menu, 5, 1);
		
#  Set menu mark to the string " * " 
set_menu_mark($my-menu, " * ");

#  Print a border around the main window and print a title 
box($my-menu-win, 0, 0);
print_in_middle($my-menu-win, 1, 0, 40, "My Menu", COLOR_PAIR[0]);
mvwaddch($my-menu-win, 2, 0, $acs_map[ACS_LTEE.ord]);
mvwhline($my-menu-win, 2, 1, $acs_map[ACS_HLINE.ord], 38);
mvwaddch($my-menu-win, 2, 39, $acs_map[ACS_RTEE.ord]);
    
#  Post the menu 
post_menu($my-menu);
wrefresh($my-menu-win);

attron(COLOR_PAIR[1]);
mvprintw(LINES() - 2, 0, "Use PageUp and PageDown to scoll down or up a page of items");
mvprintw(LINES() - 1, 0, "Arrow Keys to navigate (ESC to Exit)");
attroff(COLOR_PAIR[1]);
nc_refresh;

while (my $c = wgetch($win)) != 27 {
    given $c {
        when KEY_DOWN {
            menu_driver($my-menu, REQ_DOWN_ITEM);
        }
        when KEY_UP {
            menu_driver($my-menu, REQ_UP_ITEM);
        }
        when KEY_NPAGE {
            menu_driver($my-menu, REQ_SCR_DPAGE);
        }
        when KEY_PPAGE {
            menu_driver($my-menu, REQ_SCR_UPAGE);
        }
    }
    wrefresh($my-menu-win);
}	

LEAVE {
    #  Unpost and free all the memory taken up 
    if $my-menu {
        unpost_menu($my-menu);
        free_menu($my-menu);
    }
    for 0..$n-choices - 1 -> $i {
        free_item($my-items[$i]) if $my-items && $my-items[$i];
    }
    endwin;
}
