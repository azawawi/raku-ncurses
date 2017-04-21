#!/usr/bin/env perl6

use v6;

use lib 'lib';
use NCurses;

# Start curses mode
my $stdscr = initscr() or die "Failed to initialize ncurses\n";

start_color;

# Hide cursor
curs_set(0);

init_pair(1,  COLOR_RED,     COLOR_BLACK);
init_pair(2,  COLOR_GREEN,   COLOR_BLACK);
init_pair(3,  COLOR_YELLOW,  COLOR_BLACK);
init_pair(4,  COLOR_BLUE,    COLOR_BLACK);
init_pair(5,  COLOR_MAGENTA, COLOR_BLACK);
init_pair(6,  COLOR_CYAN,    COLOR_BLACK);
init_pair(7,  COLOR_WHITE,   COLOR_BLACK);

sub to-radians($deg) {
    return $deg * (180.0 / pi);
}

sub draw-circle(Int $sx, Int $sy, Int $width, Int $height) {
    for 0..360 -> $deg {
        my $radians = to-radians($deg);
        my $x       = Int($sx + $width  + $width  * cos( $radians ));
        my $y       = Int($sy + $height + $height * sin( $radians ));
        mvaddch($y, $x, acs_map[ACS_CKBOARD.ord]);
    }
}

my $max-x = getmaxx($stdscr);
my $max-y = getmaxy($stdscr);

class RandomCircle {
    has Int $.x;
    has Int $.y;
    has Int $.radius;
    has Int $.max-radius;
    has Int $.color;

    submethod BUILD {
        self.reroll();
    }
    
    method reroll {
        $!x          = (1..Int($max-x)).pick();
        $!y          = (1..Int($max-y)).pick();
        $!max-radius = (1..Int($max-y / 2)).pick;
        $!color      = (1..7).pick;
        $!radius     = 0;
    }

    method draw {
        color_set($.color, 0);
        draw-circle($.x, $.y, $.radius, $.radius);
    }

    method grow {
        $!radius++;
        if $.radius > $.max-radius {
            self.reroll();
        }
    }
}

my $max-circles = 25;

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
    color_set(7, 0);
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
