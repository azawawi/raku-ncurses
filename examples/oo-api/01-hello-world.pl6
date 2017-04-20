#!/usr/bin/env perl6

use v6;
use lib 'lib';
use NCurses::Lift;

# Start curses mode
my $o = NCurses::Lift.new;

# Print Hello World
$o.printf("Hello world");
$o.printf( 5, 10, "Press any key to exit...");
$o.refresh;

# Wait for any key to exit
while $o.get-char < 0 { };

# Cleanup on exit
LEAVE {
    $o.cleanup if $o;
}
