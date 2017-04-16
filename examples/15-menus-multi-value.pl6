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
    "Choice 1",
    "Choice 2",
    "Choice 3",
    "Choice 4",
    "Choice 5",
    "Choice 6",
    "Choice 7",
    "Exit",
];

# Initialize curses
my $win = initscr() or die "Could not initialize curses";
cbreak;
noecho;
keypad($win, TRUE);

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

my $my-menu = new_menu($my-items);

# Make the menu multi valued
menu_opts_off($my-menu, O_ONEVALUE);

mvprintw(LINES() - 3, 0, "Use <SPACE> to select or unselect an item.");
mvprintw(LINES() - 2, 0, "<ENTER> to see presently selected items(ESC to Exit)");
post_menu($my-menu);
nc_refresh;

while (my $c = wgetch($win)) != 27 {
    given $c {
        when KEY_DOWN { menu_driver($my-menu, REQ_DOWN_ITEM);   }
        when KEY_UP   { menu_driver($my-menu, REQ_UP_ITEM);     }
        when 32       {
            # Space
            menu_driver($my-menu, REQ_TOGGLE_ITEM);
        }
        when 10	{
            # Enter
            my $items = menu_items($my-menu);
            my @selected;
            for 0..item_count($my-menu) - 1 -> $i {
                 if item_value($items[$i]) == TRUE {
                     @selected.push(item_name($items[$i]));
                 }
            }
            move(20, 0);
            clrtoeol;
            mvprintw(20, 0, sprintf("Choices: %s", @selected.join(',')));
            nc_refresh;
        }
	}
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
