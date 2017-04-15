#!/usr/bin/env perl6

use v6;

use lib 'lib';
use NativeCall;
use NCurses;

sub print-in-middle($win, $starty, $startx, $width, Str $string, $color) {
    my $x;
    my $y;

    getyx($win, $y, $x);
    $x     = $startx if $startx != 0;
    $y     = $starty if $starty != 0;
    $width =      80 if $width  == 0;

    $x = $startx + Int( ($width - $string.chars) / 2);
    wattron($win, $color);
    mvwprintw($win, $y, $x, sprintf("%s", $string));
    wattroff($win, $color);
    nc_refresh;
}

# Initialize curses
my $win = initscr() or die "Could not Initialize curses";
start_color;
cbreak;
noecho;
keypad($win, TRUE);

# Initialize few color pairs
init_pair(1, COLOR_RED, COLOR_BLACK);

# Initialize the fields
my $fields = CArray[FIELD].new;
$fields[0] = new_field(1, 10, 6, 1, 0, 0);
$fields[1] = new_field(1, 10, 8, 1, 0, 0);
$fields[2] = FIELD.new;  # NULL

# Set field options
set_field_back($fields[0], A_UNDERLINE);
#  Don't go to next field when this Field is filled up
field_opts_off($fields[0], O_AUTOSKIP);
set_field_back($fields[1], A_UNDERLINE);
field_opts_off($fields[1], O_AUTOSKIP);

# Create the form and post it
my $my_form = new_form($fields);

my $rows;
my $cols;

# Calculate the area required for the form
scale_form($my_form, $rows, $cols);

# Create the window to be associated with the form
my $my_form_win = newwin($rows + 4, $cols + 4, 4, 4);
keypad($my_form_win, TRUE);

# Set main window and sub window
set_form_win($my_form, $my_form_win);
set_form_sub($my_form, derwin($my_form_win, $rows, $cols, 2, 2));

# Print a border around the main window and print a title
box($my_form_win, 0, 0);
print-in-middle($my_form_win, 1, 0, $cols + 4, "My Form", COLOR_PAIRS()[0]);

post_form($my_form);
wrefresh($my_form_win);

mvprintw(LINES() - 2, 0, "Use UP, DOWN arrow keys to switch between fields");
nc_refresh;

# Loop through to get user requests
while (my $ch = wgetch($my_form_win)) != 27 {
    given $ch {	
        when KEY_DOWN {
            # Go to next field
            form_driver($my_form, REQ_NEXT_FIELD);
            # Go to the end of the present buffer
            # Leaves nicely at the last character
            form_driver($my_form, REQ_END_LINE);
        }
        when KEY_UP {
            # Go to previous field
            form_driver($my_form, REQ_PREV_FIELD);
            form_driver($my_form, REQ_END_LINE);
        }
        default {
            # If this is a normal character, it gets printed
            form_driver($my_form, $ch);
        }
	}
}

# Un post form and free the memory
unpost_form($my_form);
free_form($my_form);
free_field($fields[0]);
free_field($fields[1]);

LEAVE {
    endwin;
}
