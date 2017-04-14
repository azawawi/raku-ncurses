use v6;
unit module NCurses;

use LibraryCheck;
use NativeCall;

sub library {
    # Environment variable overrides auto-detection
    return %*ENV<PERL6_NCURSES_LIB> if %*ENV<PERL6_NCURSES_LIB>;

    # On MacOS X using howbrew
    return "libncurses.dylib" if $*KERNEL.name eq 'darwin';

    # Linux/UNIX
    constant LIB = 'ncurses';
    if library-exists(LIB, v5) {
        return sprintf("lib%s.so.5", LIB);
    } elsif library-exists(LIB, v6) {
        return sprintf("lib%s.so.6", LIB);
    }

    # Fallback
    return sprintf("lib%s.so", LIB);
}

# Workaround since you need late binding of COLOR_PAIRS after initscr is called
# for the first time
my $COLOR_PAIRS;
sub COLOR_PAIRS is export {
    unless $COLOR_PAIRS {
        $COLOR_PAIRS = cglobal(&library, 'COLOR_PAIRS', int32);
    }
    return $COLOR_PAIRS;
}

class WINDOW is repr('CPointer') { }
class SCREEN is repr('CPointer') { }

our $stdscr is export = cglobal(&library, 'stdscr', WINDOW);
our $acs_map is export = cglobal(&library, 'acs_map', CArray[int64]);

class MEVENT is repr('CStruct') is export {
    #short id;           /* ID to distinguish multiple devices */
    has int16 $.id;
    #int x, y, z;        /* event coordinates (character-cell) */
    has int32 $.x;
    has int32 $.y;
    has int32 $.z;
    #mmask_t bstate;     /* button state bits */
    has int32 $.bstate;
};

constant ERR is export = -1;
constant OK  is export  = 0;

constant COLOR_BLACK is export = 0;
constant COLOR_RED is export = 1;
constant COLOR_GREEN is export = 2;
constant COLOR_YELLOW is export = 3;
constant COLOR_BLUE is export = 4;
constant COLOR_MAGENTA is export = 5;
constant COLOR_CYAN is export = 6;
constant COLOR_WHITE is export = 7;
constant COLOR_PAIR_1 is export = 256;
constant COLOR_PAIR_2 is export = 512;
constant COLOR_PAIR_3 is export = 768;
constant COLOR_PAIR_4 is export = 1024;
constant COLOR_PAIR_5 is export = 1280;
constant COLOR_PAIR_6 is export = 1536;
constant COLOR_PAIR_7 is export = 1792;
constant A_NORMAL is export = 0;
constant A_ATTRIBUTES is export = -256;
constant A_CHARTEXT is export = 255;
constant A_COLOR is export = 65280;
constant A_STANDOUT is export = 65536;
constant A_UNDERLINE is export = 131072;
constant A_REVERSE is export = 262144;
constant A_BLINK is export = 524288;
constant A_DIM is export = 1048576;
constant A_BOLD is export = 2097152;
constant A_ALTCHARSET is export = 4194304;
constant A_INVIS is export = 8388608;
constant A_PROTECT is export = 16777216;
constant A_HORIZONTAL is export = 33554432;
constant A_LEFT is export = 67108864;
constant A_LOW is export = 134217728;
constant A_RIGHT is export = 268435456;
constant A_TOP is export = 536870912;
constant A_VERTICAL is export = 1073741824;
constant KEY_CODE_YES is export = 256;
constant KEY_MIN is export = 257;
constant KEY_BREAK is export = 257;
constant KEY_SRESET is export = 344;
constant KEY_RESET is export = 345;
constant KEY_DOWN is export = 258;
constant KEY_UP is export = 259;
constant KEY_LEFT is export = 260;
constant KEY_RIGHT is export = 261;
constant KEY_HOME is export = 262;
constant KEY_BACKSPACE is export = 263;
constant KEY_F0 is export = 264;
constant KEY_F1 is export = 265;
constant KEY_F2 is export = 266;
constant KEY_F3 is export = 267;
constant KEY_F4 is export = 268;
constant KEY_F5 is export = 269;
constant KEY_F6 is export = 270;
constant KEY_F7 is export = 271;
constant KEY_F8 is export = 272;
constant KEY_F9 is export = 273;
constant KEY_F10 is export = 274;
constant KEY_F11 is export = 275;
constant KEY_F12 is export = 276;
constant KEY_DL is export = 328;
constant KEY_IL is export = 329;
constant KEY_DC is export = 330;
constant KEY_IC is export = 331;
constant KEY_EIC is export = 332;
constant KEY_CLEAR is export = 333;
constant KEY_EOS is export = 334;
constant KEY_EOL is export = 335;
constant KEY_SF is export = 336;
constant KEY_SR is export = 337;
constant KEY_NPAGE is export = 338;
constant KEY_PPAGE is export = 339;
constant KEY_STAB is export = 340;
constant KEY_CTAB is export = 341;
constant KEY_CATAB is export = 342;
constant KEY_ENTER is export = 343;
constant KEY_PRINT is export = 346;
constant KEY_LL is export = 347;
constant KEY_A1 is export = 348;
constant KEY_A3 is export = 349;
constant KEY_B2 is export = 350;
constant KEY_C1 is export = 351;
constant KEY_C3 is export = 352;
constant KEY_BTAB is export = 353;
constant KEY_BEG is export = 354;
constant KEY_CANCEL is export = 355;
constant KEY_CLOSE is export = 356;
constant KEY_COMMAND is export = 357;
constant KEY_COPY is export = 358;
constant KEY_CREATE is export = 359;
constant KEY_END is export = 360;
constant KEY_EXIT is export = 361;
constant KEY_FIND is export = 362;
constant KEY_HELP is export = 363;
constant KEY_MARK is export = 364;
constant KEY_MESSAGE is export = 365;
constant KEY_MOVE is export = 366;
constant KEY_NEXT is export = 367;
constant KEY_OPEN is export = 368;
constant KEY_OPTIONS is export = 369;
constant KEY_PREVIOUS is export = 370;
constant KEY_REDO is export = 371;
constant KEY_REFERENCE is export = 372;
constant KEY_REFRESH is export = 373;
constant KEY_REPLACE is export = 374;
constant KEY_RESTART is export = 375;
constant KEY_RESUME is export = 376;
constant KEY_SAVE is export = 377;
constant KEY_SBEG is export = 378;
constant KEY_SCANCEL is export = 379;
constant KEY_SCOMMAND is export = 380;
constant KEY_SCOPY is export = 381;
constant KEY_SCREATE is export = 382;
constant KEY_SDC is export = 383;
constant KEY_SDL is export = 384;
constant KEY_SELECT is export = 385;
constant KEY_SEND is export = 386;
constant KEY_SEOL is export = 387;
constant KEY_SEXIT is export = 388;
constant KEY_SFIND is export = 389;
constant KEY_SHELP is export = 390;
constant KEY_SHOME is export = 391;
constant KEY_SIC is export = 392;
constant KEY_SLEFT is export = 393;
constant KEY_SMESSAGE is export = 394;
constant KEY_SMOVE is export = 395;
constant KEY_SNEXT is export = 396;
constant KEY_SOPTIONS is export = 397;
constant KEY_SPREVIOUS is export = 398;
constant KEY_SPRINT is export = 399;
constant KEY_SREDO is export = 400;
constant KEY_SREPLACE is export = 401;
constant KEY_SRIGHT is export = 402;
constant KEY_SRSUME is export = 403;
constant KEY_SSAVE is export = 404;
constant KEY_SSUSPEND is export = 405;
constant KEY_SUNDO is export = 406;
constant KEY_SUSPEND is export = 407;
constant KEY_UNDO is export = 408;
constant KEY_MOUSE is export = 409;
constant KEY_RESIZE is export = 410;
constant KEY_EVENT is export = 411;
constant KEY_MAX is export = 511;
constant BUTTON1_RELEASED is export = 1;
constant BUTTON1_PRESSED is export = 2;
constant BUTTON1_CLICKED is export = 4;
constant BUTTON1_DOUBLE_CLICKED is export = 8;
constant BUTTON1_TRIPLE_CLICKED is export = 16;
constant BUTTON2_RELEASED is export = 64;
constant BUTTON2_PRESSED is export = 128;
constant BUTTON2_CLICKED is export = 256;
constant BUTTON2_DOUBLE_CLICKED is export = 512;
constant BUTTON2_TRIPLE_CLICKED is export = 1024;
constant BUTTON3_RELEASED is export = 4096;
constant BUTTON3_PRESSED is export = 8192;
constant BUTTON3_CLICKED is export = 16384;
constant BUTTON3_DOUBLE_CLICKED is export = 32768;
constant BUTTON3_TRIPLE_CLICKED is export = 65536;
constant BUTTON4_RELEASED is export = 262144;
constant BUTTON4_PRESSED is export = 524288;
constant BUTTON4_CLICKED is export = 1048576;
constant BUTTON4_DOUBLE_CLICKED is export = 2097152;
constant BUTTON4_TRIPLE_CLICKED is export = 4194304;
constant BUTTON_CTRL is export = 16777216;
constant BUTTON_SHIFT is export = 33554432;
constant BUTTON_ALT is export = 67108864;
constant REPORT_MOUSE_POSITION is export = 134217728;
constant ALL_MOUSE_EVENTS is export = 134217727;

#
# Line graphics constants
# Note: ACS is Alternative Character Set
#

# VT100 symbols begin here
constant ACS_ULCORNER is export = 'l'; #  upper left corner
constant ACS_LLCORNER is export = 'm'; #  lower left corner
constant ACS_URCORNER is export  = 'k'; #  upper right corner
constant ACS_LRCORNER is export  = 'j'; #  lower right corner
constant ACS_LTEE is export  = 't'; #  tee pointing right
constant ACS_RTEE is export  = 'u'; #  tee pointing left
constant ACS_BTEE is export  = 'v'; #  tee pointing up
constant ACS_TTEE is export  = 'w'; #  tee pointing down
constant ACS_HLINE is export = 'q'; #  horizontal line
constant ACS_VLINE is export = 'x'; #  vertical line
constant ACS_PLUS is export = 'n'; #  large plus or crossover
constant ACS_S1 is export = 'o'; #  scan line 1
constant ACS_S9 is export = 's'; #  scan line 9
constant ACS_DIAMOND is export = '`'; #  diamond
constant ACS_CKBOARD is export = 'a'; #  checker board (stipple)
constant ACS_DEGREE is export = 'f'; #  degree symbol
constant ACS_PLMINUS is export = 'g'; #  plus/minus
constant ACS_BULLET is export = '~'; #  bullet

# Teletype 5410v1 symbols begin here
constant ACS_LARROW is export = ','; #  arrow pointing left
constant ACS_RARROW is export = '+'; #  arrow pointing right
constant ACS_DARROW is export = '.'; #  arrow pointing down
constant ACS_UARROW is export = '-'; #  arrow pointing up
constant ACS_BOARD is export = 'h'; #  board of squares
constant ACS_LANTERN is export = 'i'; #  lantern symbol
constant ACS_BLOCK is export = '0'; #  solid square block

#
# These aren't documented, but a lot of System Vs have them anyway
# (you can spot pprryyzz{{||}} in a lot of AT&T terminfo strings).
# The ACS_names may not match AT&T's, our source didn't know them.
#
constant ACS_S3 is export = 'p'; #  scan line 3
constant ACS_S7 is export = 'r'; #  scan line 7
constant ACS_LEQUAL is export = 'y'; #  less/equal
constant ACS_GEQUAL is export = 'z'; #  greater/equal
constant ACS_PI is export = '{'; #  Pi
constant ACS_NEQUAL is export = '|'; #  not equal
constant ACS_STERLING is export = '}'; #  UK pound sign

#
# Line drawing ACS names are of the form ACS_trbl, where t is the top, r
# is the right, b is the bottom, and l is the left.  t, r, b, and l might
# be B (blank), S (single), D (double), or T (thick).  The subset defined
# here only uses B and S.
#
constant ACS_BSSB is export = ACS_ULCORNER;
constant ACS_SSBB is export = ACS_LLCORNER;
constant ACS_BBSS is export = ACS_URCORNER;
constant ACS_SBBS is export = ACS_LRCORNER;
constant ACS_SBSS is export = ACS_RTEE;
constant ACS_SSSB is export = ACS_LTEE;
constant ACS_SSBS is export = ACS_BTEE;
constant ACS_BSSS is export = ACS_TTEE;
constant ACS_BSBS is export = ACS_HLINE;
constant ACS_SBSB is export = ACS_VLINE;
constant ACS_SSSS is export = ACS_PLUS;

constant COLOR_PAIR   is export = (COLOR_PAIR_1,COLOR_PAIR_2,COLOR_PAIR_3,COLOR_PAIR_4,COLOR_PAIR_5,COLOR_PAIR_6,COLOR_PAIR_7);

# functions from curses.h below

sub addch(int32) returns int32 is native(&library) is export {*};

sub addchnstr(CArray[int32],int32) returns int32 is native(&library) is export {*};

sub addchstr(CArray[int32]) returns int32 is native(&library) is export {*};

sub addnstr(Str,int32) returns int32 is native(&library) is export {*};

sub addstr(Str) returns int32 is native(&library) is export {*};

sub attroff(int32) returns int32 is native(&library) is export {*};

sub attron(int32) returns int32 is native(&library) is export {*};

sub attrset(int32) returns int32 is native(&library) is export {*};

sub attr_get(CArray[int32],CArray[int16],int32) returns int32 is native(&library) is export {*};

sub attr_off(int32,int32) returns int32 is native(&library) is export {*};

sub attr_on(int32,int32) returns int32 is native(&library) is export {*};

sub attr_set(int32,int16,int32) returns int32 is native(&library) is export {*};

sub baudrate() returns int32 is native(&library) is export {*};

sub beep() returns int32 is native(&library) is export {*};

sub bkgd(int32) returns int32 is native(&library) is export {*};

sub bkgdset(int32) is native(&library) is export {*};

sub border(int32,int32,int32,int32,int32,int32,int32,int32) returns int32 is native(&library) is export {*};

sub box(WINDOW,int32,int32) returns int32 is native(&library) is export {*};

sub can_change_color() returns int32 is native(&library) is export {*};

sub cbreak() returns int32 is native(&library) is export {*};

sub chgat(int32,int32,int16,int32) returns int32 is native(&library) is export {*};

sub clear() returns int32 is native(&library) is export {*};

sub clearok(WINDOW,int32) returns int32 is native(&library) is export {*};

sub clrtobot() returns int32 is native(&library) is export {*};

sub clrtoeol() returns int32 is native(&library) is export {*};

sub color_content(int16,CArray[int16],CArray[int16],CArray[int16]) returns int32 is native(&library) is export {*};

sub color_set(int16,int32) returns int32 is native(&library) is export {*};

sub copywin(WINDOW,WINDOW,int32,int32,int32,int32,int32,int32,int32) returns int32 is native(&library) is export {*};

sub curs_set(int32) returns int32 is native(&library) is export {*};

sub def_prog_mode() returns int32 is native(&library) is export {*};

sub def_shell_mode() returns int32 is native(&library) is export {*};

sub delay_output(int32) returns int32 is native(&library) is export {*};

sub delch() returns int32 is native(&library) is export {*};

sub delscreen(SCREEN) is native(&library) is export {*};

sub delwin(WINDOW) returns int32 is native(&library) is export {*};

sub deleteln() returns int32 is native(&library) is export {*};

sub derwin(WINDOW,int32,int32,int32,int32) returns WINDOW is native(&library) is export {*};

sub doupdate() returns int32 is native(&library) is export {*};

sub dupwin(WINDOW) returns WINDOW is native(&library) is export {*};

sub echo() returns int32 is native(&library) is export {*};

sub echochar(int32) returns int32 is native(&library) is export {*};

sub erase() returns int32 is native(&library) is export {*};

sub endwin() returns int32 is native(&library) is export {*};

sub erasechar() returns int8 is native(&library) is export {*};

sub filter() is native(&library) is export {*};

sub flash() returns int32 is native(&library) is export {*};

sub flushinp() returns int32 is native(&library) is export {*};

sub getbkgd(WINDOW) returns int32 is native(&library) is export {*};

sub getch() returns int32 is native(&library) is export {*};

sub getnstr(Str,int32) returns int32 is native(&library) is export {*};

sub getstr(Str) returns int32 is native(&library) is export {*};

# unknown type in: WINDOW * getwin(FILE *)

sub halfdelay(int32) returns int32 is native(&library) is export {*};

sub has_colors() returns int32 is native(&library) is export {*};

sub has_ic() returns int32 is native(&library) is export {*};

sub has_il() returns int32 is native(&library) is export {*};

sub hline(int32,int32) returns int32 is native(&library) is export {*};

sub idcok(WINDOW,int32) is native(&library) is export {*};

sub idlok(WINDOW,int32) returns int32 is native(&library) is export {*};

sub immedok(WINDOW,int32) is native(&library) is export {*};

sub inch() returns int32 is native(&library) is export {*};

sub inchnstr(CArray[int32],int32) returns int32 is native(&library) is export {*};

sub inchstr(CArray[int32]) returns int32 is native(&library) is export {*};

sub initscr() returns WINDOW is native(&library) is export {*};

sub init_color(int16,int16,int16,int16) returns int32 is native(&library) is export {*};

sub init_pair(int16,int16,int16) returns int32 is native(&library) is export {*};

sub innstr(Str,int32) returns int32 is native(&library) is export {*};

sub insch(int32) returns int32 is native(&library) is export {*};

sub insdelln(int32) returns int32 is native(&library) is export {*};

sub insertln() returns int32 is native(&library) is export {*};

sub insnstr(Str,int32) returns int32 is native(&library) is export {*};

sub insstr(Str) returns int32 is native(&library) is export {*};

sub instr(Str) returns int32 is native(&library) is export {*};

sub intrflush(WINDOW,int32) returns int32 is native(&library) is export {*};

sub isendwin() returns int32 is native(&library) is export {*};

sub is_linetouched(WINDOW,int32) returns int32 is native(&library) is export {*};

sub is_wintouched(WINDOW) returns int32 is native(&library) is export {*};

sub keyname(int32) returns Str is native(&library) is export {*};

sub keypad(WINDOW,int32) returns int32 is native(&library) is export {*};

sub killchar() returns int8 is native(&library) is export {*};

sub leaveok(WINDOW,int32) returns int32 is native(&library) is export {*};

sub longname() returns Str is native(&library) is export {*};

sub meta(WINDOW,int32) returns int32 is native(&library) is export {*};

sub move(int32,int32) returns int32 is native(&library) is export {*};

sub mvaddch(int32,int32,int32) returns int32 is native(&library) is export {*};

sub mvaddchnstr(int32,int32,CArray[int32],int32) returns int32 is native(&library) is export {*};

sub mvaddchstr(int32,int32,CArray[int32]) returns int32 is native(&library) is export {*};

sub mvaddnstr(int32,int32,Str,int32) returns int32 is native(&library) is export {*};

sub mvaddstr(int32,int32,Str) returns int32 is native(&library) is export {*};

sub mvchgat(int32,int32,int32,int32,int16,int32) returns int32 is native(&library) is export {*};

sub mvcur(int32,int32,int32,int32) returns int32 is native(&library) is export {*};

sub mvdelch(int32,int32) returns int32 is native(&library) is export {*};

sub mvderwin(WINDOW,int32,int32) returns int32 is native(&library) is export {*};

sub mvgetch(int32,int32) returns int32 is native(&library) is export {*};

sub mvgetnstr(int32,int32,Str,int32) returns int32 is native(&library) is export {*};

sub mvgetstr(int32,int32,Str) returns int32 is native(&library) is export {*};

sub mvhline(int32,int32,int32,int32) returns int32 is native(&library) is export {*};

sub mvinch(int32,int32) returns int32 is native(&library) is export {*};

sub mvinchnstr(int32,int32,CArray[int32],int32) returns int32 is native(&library) is export {*};

sub mvinchstr(int32,int32,CArray[int32]) returns int32 is native(&library) is export {*};

sub mvinnstr(int32,int32,Str,int32) returns int32 is native(&library) is export {*};

sub mvinsch(int32,int32,int32) returns int32 is native(&library) is export {*};

sub mvinsnstr(int32,int32,Str,int32) returns int32 is native(&library) is export {*};

sub mvinsstr(int32,int32,Str) returns int32 is native(&library) is export {*};

sub mvprintw(int32, int32, Str) returns int32 is native(&library) is export {*};

sub mvwprintw(WINDOW, int32, int32, Str) returns int32 is native(&library) is export {*};

sub mvinstr(int32,int32,Str) returns int32 is native(&library) is export {*};

sub mvvline(int32,int32,int32,int32) returns int32 is native(&library) is export {*};

sub mvwaddch(WINDOW,int32,int32,int32) returns int32 is native(&library) is export {*};

sub mvwaddchnstr(WINDOW,int32,int32,CArray[int32],int32) returns int32 is native(&library) is export {*};

sub mvwaddchstr(WINDOW,int32,int32,CArray[int32]) returns int32 is native(&library) is export {*};

sub mvwaddnstr(WINDOW,int32,int32,Str,int32) returns int32 is native(&library) is export {*};

sub mvwaddstr(WINDOW,int32,int32,Str) returns int32 is native(&library) is export {*};

sub mvwchgat(WINDOW,int32,int32,int32,int32,int16,int32) returns int32 is native(&library) is export {*};

sub mvwdelch(WINDOW,int32,int32) returns int32 is native(&library) is export {*};

sub mvwgetch(WINDOW,int32,int32) returns int32 is native(&library) is export {*};

sub mvwgetnstr(WINDOW,int32,int32,Str,int32) returns int32 is native(&library) is export {*};

sub mvwgetstr(WINDOW,int32,int32,Str) returns int32 is native(&library) is export {*};

sub mvwhline(WINDOW,int32,int32,int32,int32) returns int32 is native(&library) is export {*};

sub mvwin(WINDOW,int32,int32) returns int32 is native(&library) is export {*};

sub mvwinch(WINDOW,int32,int32) returns int32 is native(&library) is export {*};

sub mvwinchnstr(WINDOW,int32,int32,CArray[int32],int32) returns int32 is native(&library) is export {*};

sub mvwinchstr(WINDOW,int32,int32,CArray[int32]) returns int32 is native(&library) is export {*};

sub mvwinnstr(WINDOW,int32,int32,Str,int32) returns int32 is native(&library) is export {*};

sub mvwinsch(WINDOW,int32,int32,int32) returns int32 is native(&library) is export {*};

sub mvwinsnstr(WINDOW,int32,int32,Str,int32) returns int32 is native(&library) is export {*};

sub mvwinsstr(WINDOW,int32,int32,Str) returns int32 is native(&library) is export {*};

sub mvwinstr(WINDOW,int32,int32,Str) returns int32 is native(&library) is export {*};

sub mvwvline(WINDOW,int32,int32,int32,int32) returns int32 is native(&library) is export {*};

sub napms(int32) returns int32 is native(&library) is export {*};

sub newpad(int32,int32) returns WINDOW is native(&library) is export {*};

# unknown type in: SCREEN * newterm(const char *,FILE *,FILE *)

sub newwin(int32,int32,int32,int32) returns WINDOW is native(&library) is export {*};

sub nl() returns int32 is native(&library) is export {*};

sub nocbreak() returns int32 is native(&library) is export {*};

sub nodelay(WINDOW,int32) returns int32 is native(&library) is export {*};

sub noecho() returns int32 is native(&library) is export {*};

sub nonl() returns int32 is native(&library) is export {*};

sub noqiflush() is native(&library) is export {*};

sub noraw() returns int32 is native(&library) is export {*};

sub notimeout(WINDOW,int32) returns int32 is native(&library) is export {*};

sub overlay(WINDOW,WINDOW) returns int32 is native(&library) is export {*};

sub overwrite(WINDOW,WINDOW) returns int32 is native(&library) is export {*};

sub pair_content(int16,CArray[int16],CArray[int16]) returns int32 is native(&library) is export {*};

sub pechochar(WINDOW,int32) returns int32 is native(&library) is export {*};

sub pnoutrefresh(WINDOW,int32,int32,int32,int32,int32,int32) returns int32 is native(&library) is export {*};

sub prefresh(WINDOW,int32,int32,int32,int32,int32,int32) returns int32 is native(&library) is export {*};

# unknown type in: int putwin(WINDOW *, FILE *)

sub qiflush() is native(&library) is export {*};

sub raw() returns int32 is native(&library) is export {*};

sub redrawwin(WINDOW) returns int32 is native(&library) is export {*};

sub nc_refresh() is symbol('refresh') returns int32 is native(&library) is export {*};

sub resetty() returns int32 is native(&library) is export {*};

sub reset_prog_mode() returns int32 is native(&library) is export {*};

sub reset_shell_mode() returns int32 is native(&library) is export {*};

sub savetty() returns int32 is native(&library) is export {*};

sub scr_dump(Str) returns int32 is native(&library) is export {*};

sub scr_init(Str) returns int32 is native(&library) is export {*};

sub scrl(int32) returns int32 is native(&library) is export {*};

sub scroll(WINDOW) returns int32 is native(&library) is export {*};

sub scrollok(WINDOW,int32) returns int32 is native(&library) is export {*};

sub scr_restore(Str) returns int32 is native(&library) is export {*};

sub scr_set(Str) returns int32 is native(&library) is export {*};

sub setscrreg(int32,int32) returns int32 is native(&library) is export {*};

sub set_term(SCREEN) returns SCREEN is native(&library) is export {*};

sub slk_attroff(int32) returns int32 is native(&library) is export {*};

sub slk_attr_off(int32,int32) returns int32 is native(&library) is export {*};

sub slk_attron(int32) returns int32 is native(&library) is export {*};

sub slk_attr_on(int32,int32) returns int32 is native(&library) is export {*};

sub slk_attrset(int32) returns int32 is native(&library) is export {*};

sub slk_attr() returns int32 is native(&library) is export {*};

sub slk_attr_set(int32,int16,int32) returns int32 is native(&library) is export {*};

sub slk_clear() returns int32 is native(&library) is export {*};

sub slk_color(int16) returns int32 is native(&library) is export {*};

sub slk_init(int32) returns int32 is native(&library) is export {*};

sub slk_label(int32) returns Str is native(&library) is export {*};

sub slk_noutrefresh() returns int32 is native(&library) is export {*};

sub slk_refresh() returns int32 is native(&library) is export {*};

sub slk_restore() returns int32 is native(&library) is export {*};

sub slk_set(int32,Str,int32) returns int32 is native(&library) is export {*};

sub slk_touch() returns int32 is native(&library) is export {*};

sub standout() returns int32 is native(&library) is export {*};

sub standend() returns int32 is native(&library) is export {*};

sub start_color() returns int32 is native(&library) is export {*};

sub subpad(WINDOW,int32,int32,int32,int32) returns WINDOW is native(&library) is export {*};

sub subwin(WINDOW,int32,int32,int32,int32) returns WINDOW is native(&library) is export {*};

sub syncok(WINDOW,int32) returns int32 is native(&library) is export {*};

sub termattrs() returns int32 is native(&library) is export {*};

sub termname() returns Str is native(&library) is export {*};

sub timeout(int32) is native(&library) is export {*};

sub touchline(WINDOW,int32,int32) returns int32 is native(&library) is export {*};

sub touchwin(WINDOW) returns int32 is native(&library) is export {*};

sub typeahead(int32) returns int32 is native(&library) is export {*};

sub ungetch(int32) returns int32 is native(&library) is export {*};

sub untouchwin(WINDOW) returns int32 is native(&library) is export {*};

sub use_env(int32) is native(&library) is export {*};

sub vidattr(int32) returns int32 is native(&library) is export {*};

# unknown type in: int vidputs(chtype, NCURSES_OUTC)

sub vline(int32,int32) returns int32 is native(&library) is export {*};

# skipping varargs: int vwprintw(WINDOW *, const char *,va_list)

# skipping varargs: int vw_printw(WINDOW *, const char *,va_list)

# skipping varargs: int vwscanw(WINDOW *, const char *,va_list)

# skipping varargs: int vw_scanw(WINDOW *, const char *,va_list)

sub printw(Str) is native(&library) is export {*};

sub waddch(WINDOW,int32) returns int32 is native(&library) is export {*};

sub waddchnstr(WINDOW,CArray[int32],int32) returns int32 is native(&library) is export {*};

sub waddchstr(WINDOW,CArray[int32]) returns int32 is native(&library) is export {*};

sub waddnstr(WINDOW,Str,int32) returns int32 is native(&library) is export {*};

sub waddstr(WINDOW,Str) returns int32 is native(&library) is export {*};

sub wattron(WINDOW,int32) returns int32 is native(&library) is export {*};

sub wattroff(WINDOW,int32) returns int32 is native(&library) is export {*};

sub wattrset(WINDOW,int32) returns int32 is native(&library) is export {*};

sub wattr_get(WINDOW,CArray[int32],CArray[int16],int32) returns int32 is native(&library) is export {*};

sub wattr_on(WINDOW,int32,int32) returns int32 is native(&library) is export {*};

sub wattr_off(WINDOW,int32,int32) returns int32 is native(&library) is export {*};

sub wattr_set(WINDOW,int32,int16,int32) returns int32 is native(&library) is export {*};

sub wbkgd(WINDOW,int32) returns int32 is native(&library) is export {*};

sub wbkgdset(WINDOW,int32) is native(&library) is export {*};

sub wborder(WINDOW,int32,int32,int32,int32,int32,int32,int32,int32) returns int32 is native(&library) is export {*};

sub wchgat(WINDOW,int32,int32,int16,int32) returns int32 is native(&library) is export {*};

sub wclear(WINDOW) returns int32 is native(&library) is export {*};

sub wclrtobot(WINDOW) returns int32 is native(&library) is export {*};

sub wclrtoeol(WINDOW) returns int32 is native(&library) is export {*};

sub wcolor_set(WINDOW,int16,int32) returns int32 is native(&library) is export {*};

sub wcursyncup(WINDOW) is native(&library) is export {*};

sub wdelch(WINDOW) returns int32 is native(&library) is export {*};

sub wdeleteln(WINDOW) returns int32 is native(&library) is export {*};

sub wechochar(WINDOW,int32) returns int32 is native(&library) is export {*};

sub werase(WINDOW) returns int32 is native(&library) is export {*};

sub wgetch(WINDOW) returns int32 is native(&library) is export {*};

sub wgetnstr(WINDOW,Str,int32) returns int32 is native(&library) is export {*};

sub wgetstr(WINDOW,Str) returns int32 is native(&library) is export {*};

sub whline(WINDOW,int32,int32) returns int32 is native(&library) is export {*};

sub winch(WINDOW) returns int32 is native(&library) is export {*};

sub winchnstr(WINDOW,CArray[int32],int32) returns int32 is native(&library) is export {*};

sub winchstr(WINDOW,CArray[int32]) returns int32 is native(&library) is export {*};

sub winnstr(WINDOW,Str,int32) returns int32 is native(&library) is export {*};

sub winsch(WINDOW,int32) returns int32 is native(&library) is export {*};

sub winsdelln(WINDOW,int32) returns int32 is native(&library) is export {*};

sub winsertln(WINDOW) returns int32 is native(&library) is export {*};

sub winsnstr(WINDOW,Str,int32) returns int32 is native(&library) is export {*};

sub winsstr(WINDOW,Str) returns int32 is native(&library) is export {*};

sub winstr(WINDOW,Str) returns int32 is native(&library) is export {*};

sub wmove(WINDOW,int32,int32) returns int32 is native(&library) is export {*};

sub wnoutrefresh(WINDOW) returns int32 is native(&library) is export {*};

sub wredrawln(WINDOW,int32,int32) returns int32 is native(&library) is export {*};

sub wrefresh(WINDOW) returns int32 is native(&library) is export {*};

sub wscrl(WINDOW,int32) returns int32 is native(&library) is export {*};

sub wsetscrreg(WINDOW,int32,int32) returns int32 is native(&library) is export {*};

sub wstandout(WINDOW) returns int32 is native(&library) is export {*};

sub wstandend(WINDOW) returns int32 is native(&library) is export {*};

sub wsyncdown(WINDOW) is native(&library) is export {*};

sub wsyncup(WINDOW) is native(&library) is export {*};

sub wtimeout(WINDOW,int32) is native(&library) is export {*};

sub wtouchln(WINDOW,int32,int32,int32) returns int32 is native(&library) is export {*};

sub wvline(WINDOW,int32,int32) returns int32 is native(&library) is export {*};

sub tigetflag(Str) returns int32 is native(&library) is export {*};

sub tigetnum(Str) returns int32 is native(&library) is export {*};

sub tigetstr(Str) returns Str is native(&library) is export {*};

sub putp(Str) returns int32 is native(&library) is export {*};

# skipping varargs: char * tparm(const char *, ...)

# skipping varargs: char * tiparm(const char *, ...)

sub getattrs(WINDOW) returns int32 is native(&library) is export {*};

sub getcurx(WINDOW) returns int32 is native(&library) is export {*};

sub getcury(WINDOW) returns int32 is native(&library) is export {*};

sub getbegx(WINDOW) returns int32 is native(&library) is export {*};

sub getbegy(WINDOW) returns int32 is native(&library) is export {*};

sub getmaxx(WINDOW) returns int32 is native(&library) is export {*};

sub getmaxy(WINDOW) returns int32 is native(&library) is export {*};

sub getbegyx($win, $y is rw, $x is rw) is export {
    $y = getbegy($win);
    $x = getbegx($win);
}

sub getmaxyx($win, $y is rw, $x is rw) is export {
    $y = getmaxy($win);
    $x = getmaxx($win);
}

sub getyx($win, $y is rw, $x is rw) is export {
    $y = getcury($win);
    $x = getcurx($win);
}

sub getparx(WINDOW) returns int32 is native(&library) is export {*};

sub getpary(WINDOW) returns int32 is native(&library) is export {*};

sub is_term_resized(int32,int32) returns int32 is native(&library) is export {*};

sub keybound(int32,int32) returns Str is native(&library) is export {*};

sub curses_version() returns Str is native(&library) is export {*};

sub assume_default_colors(int32,int32) returns int32 is native(&library) is export {*};

sub define_key(Str,int32) returns int32 is native(&library) is export {*};

sub get_escdelay() returns int32 is native(&library) is export {*};

sub key_defined(Str) returns int32 is native(&library) is export {*};

sub keyok(int32,int32) returns int32 is native(&library) is export {*};

sub resize_term(int32,int32) returns int32 is native(&library) is export {*};

sub resizeterm(int32,int32) returns int32 is native(&library) is export {*};

sub set_escdelay(int32) returns int32 is native(&library) is export {*};

sub set_tabsize(int32) returns int32 is native(&library) is export {*};

sub use_default_colors() returns int32 is native(&library) is export {*};

sub use_extended_names(int32) returns int32 is native(&library) is export {*};

sub use_legacy_coding(int32) returns int32 is native(&library) is export {*};

# unknown type in: int use_screen(SCREEN *, NCURSES_SCREEN_CB, void *)

# unknown type in: int use_window(WINDOW *, NCURSES_WINDOW_CB, void *)

sub wresize(WINDOW,int32,int32) returns int32 is native(&library) is export {*};

sub wgetparent(WINDOW) returns WINDOW is native(&library) is export {*};

sub is_cleared(WINDOW) returns int32 is native(&library) is export {*};

sub is_idcok(WINDOW) returns int32 is native(&library) is export {*};

sub is_idlok(WINDOW) returns int32 is native(&library) is export {*};

sub is_immedok(WINDOW) returns int32 is native(&library) is export {*};

sub is_keypad(WINDOW) returns int32 is native(&library) is export {*};

sub is_leaveok(WINDOW) returns int32 is native(&library) is export {*};

sub is_nodelay(WINDOW) returns int32 is native(&library) is export {*};

sub is_notimeout(WINDOW) returns int32 is native(&library) is export {*};

sub is_pad(WINDOW) returns int32 is native(&library) is export {*};

sub is_scrollok(WINDOW) returns int32 is native(&library) is export {*};

sub is_subwin(WINDOW) returns int32 is native(&library) is export {*};

sub is_syncok(WINDOW) returns int32 is native(&library) is export {*};

sub wgetscrreg(WINDOW,CArray[int32],CArray[int32]) returns int32 is native(&library) is export {*};

sub getmouse(MEVENT) returns int32 is native(&library) is export {*};

sub ungetmouse(MEVENT) returns int32 is native(&library) is export {*};

sub mousemask(int32,int32) returns int32 is native(&library) is export {*};

sub wenclose(WINDOW,int32,int32) returns int32 is native(&library) is export {*};

sub mouseinterval(int32) returns int32 is native(&library) is export {*};

sub wmouse_trafo(WINDOW,CArray[int32],CArray[int32],int32) returns int32 is native(&library) is export {*};

sub mouse_trafo(CArray[int32],CArray[int32],int32) returns int32 is native(&library) is export {*};

sub mcprint(Str,int32) returns int32 is native(&library) is export {*};

sub has_key(int32) returns int32 is native(&library) is export {*};

sub trace(int32) is native(&library) is export {*};


#
# Panel library API
#
sub panel-library {
    # Environment variable overrides auto-detection
    return %*ENV<PERL6_NCURSES_PANEL_LIB> if %*ENV<PERL6_NCURSES_PANEL_LIB>;

    # On MacOS X using howbrew
    return "libpanel.dylib" if $*KERNEL.name eq 'darwin';

    # Linux/UNIX
    constant LIB = 'panel';
    if library-exists(LIB, v5) {
        return sprintf("lib%s.so.5", LIB);
    } elsif library-exists(LIB, v6) {
        return sprintf("lib%s.so.6", LIB);
    }

    # Fallback
    return sprintf("lib%s.so", LIB);
}

class PANEL is repr('CPointer') { }

sub new_panel(WINDOW) returns PANEL is native(&panel-library) is export {*};

sub update_panels() is native(&panel-library) is export {*};

sub show_panel(PANEL) is native(&panel-library) is export {*};

sub hide_panel(PANEL) is native(&panel-library) is export {*};

sub top_panel(PANEL) is native(&panel-library) is export {*};

sub set_panel_userptr(PANEL, Pointer) is native(&panel-library) is export {*};

sub panel_userptr(PANEL) returns Pointer is native(&panel-library) is export {*};

#
# Form library API
#
sub form-library {
    # Environment variable overrides auto-detection
    return %*ENV<PERL6_NCURSES_FORM_LIB> if %*ENV<PERL6_NCURSES_FORM_LIB>;

    # On MacOS X using howbrew
    return "libform.dylib" if $*KERNEL.name eq 'darwin';

    # Linux/UNIX
    constant LIB = 'form';
    if library-exists(LIB, v5) {
        return sprintf("lib%s.so.5", LIB);
    } elsif library-exists(LIB, v6) {
        return sprintf("lib%s.so.6", LIB);
    }

    # Fallback
    return sprintf("lib%s.so", LIB);
}

class FORM is repr('CPointer') { }

sub scale_form(FORM, int32 is rw, int32 is rw) returns int32 is native(&form-library) is export {*}

sub post_form(FORM) returns int32 is native(&form-library) is export {*}

sub unpost_form(FORM) returns int32 is native(&form-library) is export {*}

sub form_driver(FORM, int32) returns int32 is native(&form-library) is export {*}
