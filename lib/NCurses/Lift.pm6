
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

method cleanup {
    # No need to cleanup if undefined
    return unless $!win;

    # Clean window handle
    delwin($!win);

    # End curses mode
    endwin;
}
