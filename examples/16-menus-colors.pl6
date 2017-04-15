#!/usr/bin/env perl6

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
start_color;
cbreak;
noecho;
keypad($win, TRUE);

# Initialize colors
init_pair(1, COLOR_RED, COLOR_BLACK);
init_pair(2, COLOR_GREEN, COLOR_BLACK);
init_pair(3, COLOR_MAGENTA, COLOR_BLACK);

# Initialize items
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

item_opts_off($my-items[3], O_SELECTABLE);
item_opts_off($my-items[6], O_SELECTABLE);

# Create menu
my $my-menu = new_menu($my-items);

#  Set fore ground and back ground of the menu
set_menu_fore($my-menu, COLOR_PAIR[0] +| A_REVERSE);
set_menu_back($my-menu, COLOR_PAIR[1]);
set_menu_grey($my-menu, COLOR_PAIR[2]);

# Post the menu
mvprintw(LINES() - 3, 0, "Press <ENTER> to see the option selected");
mvprintw(LINES() - 2, 0, "Up and Down arrow keys to naviage (ESC to Exit)");
post_menu($my-menu);
nc_refresh;

while (my $c = wgetch($win)) != 27 {
    given $c {
        when KEY_DOWN { menu_driver($my-menu, REQ_DOWN_ITEM);   }
        when KEY_UP   { menu_driver($my-menu, REQ_UP_ITEM);     }
        when 10 {
            # Enter
            move(20, 0);
            clrtoeol;
            mvprintw(20, 0, sprintf("Item selected is : %s", item_name(current_item($my-menu))));
            pos_menu_cursor($my-menu);
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
