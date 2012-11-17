
use v6;

module NCurses;

use NativeCall;

constant LIB = 'libncurses.so.5';

sub initscr
	is native(LIB)
	is export { ... };

sub clear
	is native(LIB)
	is export { ... };

sub endwin
	is native(LIB)
	is export { ... };

sub printw(Str)
	is native(LIB) 
	is export { ... };

sub getch
	is native(LIB)
	is export { ... };

