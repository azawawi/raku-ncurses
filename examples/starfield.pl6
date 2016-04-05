#!/usr/bin/env perl6

#
# Example from
# http://software.gellyfish.co.uk/2015/10/learning-perl-6-from-bad-perl-5-code.html
#
use v6;

use lib 'lib';
use NCurses;

constant numstars  = 100;
constant screen-x  =  80;
constant screen-y  =  24;
constant max-speed =   4;

class Star {
    has Int $.x;
    has Int $.y;
    has Int $.s;

    submethod BUILD {
        $!x = (^screen-x).pick;
        $!y = (^screen-y).pick;
        $!s = (1 .. max-speed).pick;
    }

    method move {
        $!x = ($!x >= $!s)
          ?? $!x - $!s
          !! screen-x;
    }
}

my Star @stars = gather { take Star.new for ^numstars };

my $win = initscr;
die "Failed to initialize ncurses\n" unless $win.defined;

curs_set( 0 );

repeat {
    clear;
    for @stars -> $star {
        $star.move;
        mvaddstr( $star.y, $star.x, '.' )
    }
    nc_refresh;
    sleep( .05 );
} while getch() < 0;

endwin;
