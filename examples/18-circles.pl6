#!/usr/bin/env perl6

use v6;

use lib 'lib';
use NCurses;

# Start curses mode
my $stdscr = initscr() or die "Failed to initialize ncurses\n";

# Hide cursor
curs_set(0);

sub to-radians($deg) {
    return $deg * (180.0 / pi);
}

sub draw-circle(Int $sx, Int $sy, Int $width, Int $height) {
    for 0..360 -> $deg {
        my $radians = to-radians($deg);
        my $x       = $sx + Int($width  + Int($width  * cos( $radians )));
        my $y       = $sy + Int($height + Int($height * sin( $radians )));
        mvaddch($y, $x, '.'.ord);
    }
}

my $max-x = getmaxx($stdscr);
my $max-y = getmaxy($stdscr);

class RandomCircle {
    has Int $.x;
    has Int $.y;
    has Int $.radius;
    has Int $.max-radius;

    submethod BUILD {
        self.reroll();
    }
    
    method reroll {
        $!x          = (1..Int($max-x)).pick();
        $!y          = (1..Int($max-y)).pick();
        $!max-radius = (1..Int($max-y / 2)).pick;
        $!radius     = 0;
    }

    method draw {
        draw-circle($.x, $.y, $.radius, $.radius);
    }

    method grow {
        $!radius++;
        if $.radius > $.max-radius {
            self.reroll();
        }
    }
}

my $max-circles = 10;

my @circles;
for 1..$max-circles {
    my $circle = RandomCircle.new;
    @circles.push($circle);
}

timeout(0);
keypad($stdscr,TRUE);

while (my $ch = getch()) != 27 {
    given $ch {
        when KEY_RESIZE {
            $max-x = getmaxx($stdscr);
            $max-y = getmaxy($stdscr);
            for @circles -> $circle {
                $circle.reroll;
            }
        }
    }

    clear;
    for @circles -> $circle {
        $circle.draw;
        $circle.grow;
    }
    mvprintw(LINES() - 2, 0, "Enjoy the show. Press ESC to exit");
    nc_refresh;
    sleep 0.05;
};

# Cleanup
LEAVE {
    delwin($stdscr)  if $stdscr;

    # End curses mode
    endwin;
}
