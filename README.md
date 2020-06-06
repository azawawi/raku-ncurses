# NCurses [![Build Status](https://travis-ci.org/azawawi/perl6-ncurses.svg?branch=master)](https://travis-ci.org/azawawi/perl6-ncurses)

NCurses provides a Raku native interface to the `ncurses` library for
terminal-independent screen I/O.

## Example

```raku
use NCurses;

# Set locale from the environment; see 'Initialization' in ncurses(3) man page
setlocale(0, '');

# Initialize curses window
my $win = initscr() or die "Failed to initialize ncurses\n";

start_color;

# Initialize colors
init_pair(1, COLOR_WHITE, COLOR_RED);
init_pair(2, COLOR_WHITE, COLOR_BLUE);

# Print Hello World to the internal buffer
color_set(1, 0);
mvaddstr( 10, 10, " Hello world " );
color_set(2, 0);
mvaddstr( LINES() - 2, 2, "Press any key to exit..." );

# Refresh the screen to display our updates
nc_refresh;

# Wait for a keypress
getch;

# Restore the screen before exiting
LEAVE endwin;
```

For more examples, please see the [examples](examples) folder.

## Installation

* On Debian-based linux distributions, please use the following command:
```
$ sudo apt-get install libncurses6
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
- `RAKU_NCURSES_LIB`
- `RAKU_NCURSES_PANEL_LIB`
- `RAKU_NCURSES_MENU_LIB`
- `RAKU_NCURSES_FORM_LIB`

If you set only `RAKU_NCURSES_LIB=/path/to/libncursesw.so.6`, the others
will automatically derive from it.

## Troubleshooting

- To fix a broken or messed up terminal after a crash, please type `reset` to
reset your terminal into its original state.

## Testing

- To run tests:
```
$ prove -ve "raku -Ilib"
```

- To run all tests including author tests (Please make sure
[Test::Meta](https://github.com/jonathanstowe/Test-META) is installed):
```
$ zef install Test::META
$ AUTHOR_TESTING=1 prove -e "raku -Ilib"
```

## Author

Ahmad M. Zawawi, azawawi on #raku, https://github.com/azawawi/

## License

MIT License
