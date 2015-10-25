# NCurses
[![Build Status](https://travis-ci.org/azawawi/perl6-ncurses.svg?branch=master)](https://travis-ci.org/azawawi/perl6-ncurses)

NCurses provides a Perl 6 interface to libncurses.

## Example

```Perl6
# Initialize curses window
my $win = initscr;
die "Failed to initialize ncurses\n" unless $win.defined;

# Print Hello World
printw( "Hello World" );
mvaddstr( 5, 10, "Press any key to exit..." );

# Refresh (this is needed)
nc_refresh;

# Wait for a keypress
while getch() < 0 { };

# End curses mode
endwin;
```

For more examples, please see the [examples](examples) folder.

## Installation

* Since NCurses uses libncurses, libncurses.so must be found in /usr/lib.
To install libncurses on Debian for example, please use the following command:

```
$ sudo apt-get install libncurses5
```

* Using panda (a module management tool bundled with Rakudo Star):

```
$ panda update && panda install NCurses
```

## Environment variables

```PERL6_NCURSES_LIB``` can now be used to specify the location of the ncurses
library in the system.

## Testing

To run tests:

```
$ prove -e 'perl6'
```

## Author

Ahmad M. Zawawi, azawawi on #perl6, https://github.com/azawawi/

## License

Artistic License 2.0
