
use v6;

unit class NCurses::Lift;

use NCurses;

has WINDOW $!win;

submethod BUILD {
    my $win = initscr() or die "Failed to initialize ncurses\n";
    $!win = $win;
}

multi method printf(Str $format, *@args) {
    my $text = sprintf($format, @args);
    printw( $text );
}

multi method printf(Int $y, Int $x, Str $format, *@args) {
    my $text = sprintf($format, @args);
    mvaddstr( $y, $x, $text);
}

method refresh {
    nc_refresh;
}

method get-char {
    return getch;
}

method max-yx {
    my $x;
    my $y;
    getmaxyx($!win, $y, $x);
    return ($y, $x);
}

method cursor(Int $visibility) {
    curs_set($visibility);
}

method timeout(Int $duration) {
    timeout($duration);
}

method clear {
    clear;
}

method cleanup {
    # No need to cleanup if undefined
    return unless $!win;

    # Clean window handle
    delwin($!win);

    # End curses mode
    endwin;
}
