#!/usr/bin/env perl6

#
# Example translated and modified from C source
# http://www.tldp.org/HOWTO/html_single/NCURSES-Programming-HOWTO/
#

use v6;

use lib 'lib';
use NativeCall;
use NCurses;

my @choices = [
    "Choice 1", "Choice 2", "Choice 3", "Choice 4", "Choice 5",
    "Choice 6", "Choice 7", "Choice 8", "Choice 9", "Choice 10",
    "Choice 11", "Choice 12", "Choice 13", "Choice 14", "Choice 15",
    "Choice 16", "Choice 17", "Choice 18", "Choice 19", "Choice 20",
    "Exit",
];

#  Initialize curses 
my $win = initscr() or die "Could not initialize curses";
start_color;
cbreak;
noecho;
keypad($win, TRUE);

# Initialize colors
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

#  Crate menu 
my $my-menu = new_menu($my-items);

#  Set menu option not to show the description 
menu_opts_off($my-menu, O_SHOWDESC);

#  Create the window to be associated with the menu 
my $my-menu-win = newwin(10, 70, 4, 4);
keypad($my-menu-win, TRUE);
 
#  Set main window and sub window 
set_menu_win($my-menu, $my-menu-win);
set_menu_sub($my-menu, derwin($my-menu-win, 6, 68, 3, 1));
set_menu_format($my-menu, 5, 3);
set_menu_mark($my-menu, " * ");

#  Print a border around the main window and print a title 
box($my-menu-win, 0, 0);

attron(COLOR_PAIR[1]);
mvprintw(LINES() - 3, 0, "Use PageUp and PageDown to scroll");
mvprintw(LINES() - 2, 0, "Use Arrow Keys to navigate (ESC to Exit)");
attroff(COLOR_PAIR[1]);
nc_refresh();

#  Post the menu 
post_menu($my-menu);
wrefresh($my-menu-win);

while (my $c = wgetch($win)) != 27 {
    given $c {
        when KEY_DOWN  { menu_driver($my-menu, REQ_DOWN_ITEM);  }
        when KEY_UP    { menu_driver($my-menu, REQ_UP_ITEM);    }
        when KEY_LEFT  { menu_driver($my-menu, REQ_LEFT_ITEM);  }
        when KEY_RIGHT { menu_driver($my-menu, REQ_RIGHT_ITEM); }
        when KEY_NPAGE { menu_driver($my-menu, REQ_SCR_DPAGE);  }
        when KEY_PPAGE { menu_driver($my-menu, REQ_SCR_UPAGE);  }
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
