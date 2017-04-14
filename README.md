# NCurses [![Build Status](https://travis-ci.org/azawawi/perl6-ncurses.svg?branch=master)](https://travis-ci.org/azawawi/perl6-ncurses)

NCurses provides a Perl 6 native interface to `ncurses` library.

## Example

```Perl6
# Initialize curses window
my $win = initscr;
die "Failed to initialize ncurses\n" unless $win;

# Print Hello World
printw( "Hello World" );
mvaddstr( 5, 10, "Press any key to exit..." );

# Refresh (this is needed)
nc_refresh;

# Wait for a keypress
while getch() < 0 { };

# Cleanup
LEAVE {
    delwin($win) if $win;
    endwin;
}
```

For more examples, please see the [examples](examples) folder.

## Installation

* On Debian-based linux distributions, please use the following command:
```
$ sudo apt-get install libncurses5
```

* On Mac OS X, please use the following command:
```
$ brew update
$ brew install ncurses
```

* Using zef (a module management tool bundled with Rakudo Star):
```
$ zef install NCurses
```

## Environment variables

`PERL6_NCURSES_LIB` can now be used to specify the location of the `ncurses`
library in the system.

## Testing

- To run tests:
```
$ prove -ve "perl6 -Ilib"
```

- To run all tests including author tests (Please make sure
[Test::Meta](https://github.com/jonathanstowe/Test-META) is installed):
```
$ zef install Test::META
$ AUTHOR_TESTING=1 prove -e "perl6 -Ilib"
```

## Author

Ahmad M. Zawawi, azawawi on #perl6, https://github.com/azawawi/

## License

MIT License
