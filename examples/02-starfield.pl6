#!/usr/bin/env perl6

#
# Example from
# http://software.gellyfish.co.uk/2015/10/learning-perl-6-from-bad-perl-5-code.html
#
use v6;

use lib 'lib';
use NCurses;


my $win = initscr() or die "Failed to initialize ncurses\n";

constant numstars  = 100;
my $screen-x  =  getmaxx($win);
my $screen-y  =  getmaxy($win);

constant max-speed =   4;

class Star {
    has Int $.x;
    has Int $.y;
    has Int $.s;

    submethod BUILD {
        $!x = (^$screen-x).pick;
        $!y = (^$screen-y).pick;
        $!s = (1 .. max-speed).pick;
    }

    method move {
        $!x = ($!x >= $!s)
          ?? $!x - $!s
          !! $screen-x;
    }
}

my Star @stars = gather { take Star.new for ^numstars };

curs_set( 0 );
timeout( 0 );
repeat {
    clear;
    for @stars -> $star {
        $star.move;
        mvaddstr( $star.y, $star.x, '.' )
    }
    nc_refresh;
    sleep( .05 );
} while getch() < 0;

# Cleanup
LEAVE {
    delwin($win)  if $win;

    # End curses mode
    endwin;
}
