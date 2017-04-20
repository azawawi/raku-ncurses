#!/usr/bin/env perl6

#
# Modified OO-based API. The original example is found here:
# http://software.gellyfish.co.uk/2015/10/learning-perl-6-from-bad-perl-5-code.html
#
use v6;

use lib 'lib';
use NCurses::Lift;

my $o = NCurses::Lift.new;

constant numstars  = 100;
my ($screen-y, $screen-x)  = $o.max-yx;

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

$o.cursor( 0 );
$o.timeout( 0 );
repeat {
    $o.clear;
    for @stars -> $star {
        $star.move;
        $o.printf( $star.y, $star.x, '.' );
    }
    $o.refresh;
    sleep( .05 );
} while $o.get-char < 0;

# Cleanup
LEAVE {
    $o.cleanup if $o;
}
