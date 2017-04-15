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
    "Exit",
];

my $win = initscr() or die "Could not Initialize curses";
cbreak;
noecho;
keypad($win, TRUE);

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
post_menu($my-menu);
mvprintw(LINES() - 2, 0, "Use UP, DOWN arrow keys to switch between menu items. Press ESC to Exit");
nc_refresh;

while (my $c = wgetch($win)) != 27 {
    given $c {
        when KEY_DOWN {
            menu_driver($my-menu, REQ_DOWN_ITEM);
        }
        when KEY_UP {
            menu_driver($my-menu, REQ_UP_ITEM);
        }
    }
    nc_refresh;
}

LEAVE {
    # Cleanup
    for 0..$n-choices - 1 -> $i {
        free_item($my-items[$i]) if $my-items[$i];
    }
    free_menu($my-menu) if $my-menu;
    endwin;
}
