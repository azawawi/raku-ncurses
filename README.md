# NCurses [![Build Status](https://travis-ci.org/azawawi/perl6-ncurses.svg?branch=master)](https://travis-ci.org/azawawi/perl6-ncurses)

NCurses provides a Perl 6 native interface to `ncurses` library.

## Example

```Perl6
use v6;
use NCurses;

# Initialize curses window
my $win = initscr() or die "Failed to initialize ncurses\n";
start_color;

# Initialize colors
init_pair(1, COLOR_WHITE, COLOR_RED);
init_pair(2, COLOR_WHITE, COLOR_BLUE);

# Print Hello World
color_set(1, 0);
mvaddstr( 10, 10, " Hello world " );
color_set(2, 0);
mvaddstr( LINES() - 2, 2, "Press any key to exit..." );

# Refresh (this is needed)
nc_refresh;

# Wait for a keypress
getch;

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

The following environment variables can be used to specify the location of the
different `ncurses` libraries:
- `PERL6_NCURSES_LIB`
- `PERL6_NCURSES_PANEL_LIB`
- `PERL6_NCURSES_MENU_LIB`
- `PERL6_NCURSES_FORM_LIB`

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
