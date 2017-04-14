#!/usr/bin/env perl6

use v6;

use lib 'lib';
use NCurses;

constant NLINES = 10;
constant NCOLS  = 40;

# Put all the windows
sub create-wins($n) returns Array {	
    my $y = 2;
    my $x = 10;
    my @wins;
    for 0..$n - 1 -> $i {
        $wins[i] = newwin(NLINES, NCOLS, $y, $x);
        my $label = sprintf("Window Number %d", $i + 1);
        win_show($wins[i], $label, $i + 1);
        $y += 3;
        $x += 7;
    }

    return @wins;
}

#
# Show the window with a border and a label
#
sub win-show($win, Str $label, $label_color)
{	
    my $startx;
    my $starty;
    my $height;
    my $width;

    getbegyx($win, $starty, $startx);
	getmaxyx($win, $height, $width);

	box($win, 0, 0);
	mvwaddch($win, 2, 0, ACS_LTEE); 
	mvwhline($win, 2, 1, ACS_HLINE, $width - 2); 
	mvwaddch($win, 2, $width - 1, ACS_RTEE); 
	
	print_in_middle($win, 1, 0, $width, $label, COLOR_PAIR($label_color));
}

sub print_in_middle($win, $starty, $startx, $width, Str $string, $color) {
    $win = stdscr unless $win;

    my $x;
    my $y;

    getyx($win, $y, $x);
    $x     = $startx if $startx != 0;
    $y     = $starty if $starty != 0;
    $width = 80 if $width == 0;

    $length = $string.chars;
    $x = $startx + Int($width - $length)/ 2;
    wattron($win, $color);
    mvwprintw($win, $y, $x, "%s", $string);
    wattroff($win, $color);
    nc_refresh;
}

my PANEL  $top;

# Initialize curses
initscr or die "Cannot initialize curses window";
start_color;
cbreak;
noecho;
keypad(stdscr, 1);

# Initialize all the colors
init_pair(1, COLOR_RED, COLOR_BLACK);
init_pair(2, COLOR_GREEN, COLOR_BLACK);
init_pair(3, COLOR_BLUE, COLOR_BLACK);
init_pair(4, COLOR_CYAN, COLOR_BLACK);

my @my-wins = create-wins(3);

# Attach a panel to each window (Order is bottom up)
my @my_panels;
new_panel($_) for @my-wins;

# Set up the user pointers to the next panel
set_panel_userptr(@my_panels[0], @my_panels[1]);
set_panel_userptr(@my_panels[1], @my_panels[2]);
set_panel_userptr(@my_panels[2], @my_panels[0]);

# Update the stacking order. 2nd panel will be on top
update_panels;

# Show it on the screen
attron(COLOR_PAIR(4));
mvprintw(LINES - 2, 0, "Use tab to browse through the windows (F1 to Exit)");
attroff(COLOR_PAIR(4));
doupdate();

$top = my_panels[2];
while (my $ch = getch) != KEY_F(1)
{	
    if $ch == 9 {
        $top = panel_userptr($top);
        top_panel($top);
    }
    update_panels;
    doupdate;
}

LEAVE {
    endwin;
}
