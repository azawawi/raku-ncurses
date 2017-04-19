#!/usr/bin/env perl6

#
# Example translated and modified from C source
# http://www.tldp.org/HOWTO/html_single/NCURSES-Programming-HOWTO/
#

use v6;

use lib 'lib';
use NCurses;

initscr() or die "Could not initialize curses window";

sub print-acs($text, $acs-char) {
    printw($text);
    addch(acs_map[$acs-char.ord]);
    printw("\n");
}

print-acs("Lower left corner           ", ACS_LLCORNER);
print-acs("Upper left corner           ", ACS_ULCORNER);
print-acs("Lower right corner          ", ACS_LRCORNER);
print-acs("Tee pointing right          ", ACS_LTEE);
print-acs("Tee pointing left           ", ACS_RTEE);
print-acs("Tee pointing up             ", ACS_BTEE);
print-acs("Tee pointing down           ", ACS_TTEE);
print-acs("Horizontal line             ", ACS_HLINE);
print-acs("Vertical line               ", ACS_VLINE);
print-acs("Large Plus or cross over    ", ACS_PLUS);
print-acs("Scan Line 1                 ", ACS_S1);
print-acs("Scan Line 3                 ", ACS_S3);
print-acs("Scan Line 7                 ", ACS_S7);
print-acs("Scan Line 9                 ", ACS_S9);
print-acs("Diamond                     ", ACS_DIAMOND);
print-acs("Checker board (stipple)     ", ACS_CKBOARD);
print-acs("Degree Symbol               ", ACS_DEGREE);
print-acs("Plus/Minus Symbol           ", ACS_PLMINUS);
print-acs("Bullet                      ", ACS_BULLET);
print-acs("Arrow Pointing Left         ", ACS_LARROW);
print-acs("Arrow Pointing Right        ", ACS_RARROW);
print-acs("Arrow Pointing Down         ", ACS_DARROW);
print-acs("Arrow Pointing Up           ", ACS_UARROW);
print-acs("Board of squares            ", ACS_BOARD);
print-acs("Lantern Symbol              ", ACS_LANTERN);
print-acs("Solid Square Block          ", ACS_BLOCK);
print-acs("Less/Equal sign             ", ACS_LEQUAL);
print-acs("Greater/Equal sign          ", ACS_GEQUAL);
print-acs("Pi                          ", ACS_PI);
print-acs("Not equal                   ", ACS_NEQUAL);
print-acs("UK pound sign               ", ACS_STERLING);

LEAVE {
    nc_refresh;
    getch;
    endwin;
}
