use NCurses;

# Note: You must also be using libncursesw.so.* (with wide-character
# support) for this to display properly.

# Set LC_CTYPE from the environment; see 'Initialization' in the ncurses(3x)
# man page. See also locale(7) and setlocale(3) for details. Most
# applications must set this before initscr() to behave properly.
constant \LC_TYPE = 0;
setlocale(LC_TYPE, '');

initscr() or die "Failed to initialize ncurses\n";

mvaddstr( 2, 5, "1) 你好");
mvaddstr( 4, 5, "2) 彩虹");
mvaddstr( 6, 5, "3) 哈哈");
mvaddstr( LINES() - 2, 2, "Press any key to exit..." );

nc_refresh;

getch;

endwin;
