use v6;
module NCurses;
use NativeCall;

constant LIB = 'libncursesw.so.5';

class WINDOW is repr('CPointer') { }
class SCREEN is repr('CPointer') { }

class MEVENT is repr('CStruct') {
  #short id;           /* ID to distinguish multiple devices */
  has int16 $.id;
  #int x, y, z;        /* event coordinates (character-cell) */
  has int32 $.x;
  has int32 $.y;
  has int32 $.z;
  #mmask_t bstate;     /* button state bits */
  has int32 $.bstate;
};


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


constant COLOR_PAIR   is export = (COLOR_PAIR_1,COLOR_PAIR_2,COLOR_PAIR_3,COLOR_PAIR_4,COLOR_PAIR_5,COLOR_PAIR_6,COLOR_PAIR_7);

# functions from curses.h below

sub addch(int32) returns int32 is native(LIB) is export {*};

sub addchnstr(CArray[int32],int32) returns int32 is native(LIB) is export {*};

sub addchstr(CArray[int32]) returns int32 is native(LIB) is export {*};

sub addnstr(Str,int32) returns int32 is native(LIB) is export {*};

sub addstr(Str) returns int32 is native(LIB) is export {*};

sub attroff(int32) returns int32 is native(LIB) is export {*};

sub attron(int32) returns int32 is native(LIB) is export {*};

sub attrset(int32) returns int32 is native(LIB) is export {*};

sub attr_get(CArray[int32],CArray[int16],int32) returns int32 is native(LIB) is export {*};

sub attr_off(int32,int32) returns int32 is native(LIB) is export {*};

sub attr_on(int32,int32) returns int32 is native(LIB) is export {*};

sub attr_set(int32,int16,int32) returns int32 is native(LIB) is export {*};

sub baudrate() returns int32 is native(LIB) is export {*};

sub beep() returns int32 is native(LIB) is export {*};

sub bkgd(int32) returns int32 is native(LIB) is export {*};

sub bkgdset(int32) is native(LIB) is export {*};

sub border(int32,int32,int32,int32,int32,int32,int32,int32) returns int32 is native(LIB) is export {*};

sub box(WINDOW,int32,int32) returns int32 is native(LIB) is export {*};

sub can_change_color() returns int32 is native(LIB) is export {*};

sub cbreak() returns int32 is native(LIB) is export {*};

sub chgat(int32,int32,int16,int32) returns int32 is native(LIB) is export {*};

sub clear() returns int32 is native(LIB) is export {*};

sub clearok(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub clrtobot() returns int32 is native(LIB) is export {*};

sub clrtoeol() returns int32 is native(LIB) is export {*};

sub color_content(int16,CArray[int16],CArray[int16],CArray[int16]) returns int32 is native(LIB) is export {*};

sub color_set(int16,int32) returns int32 is native(LIB) is export {*};

sub copywin(WINDOW,WINDOW,int32,int32,int32,int32,int32,int32,int32) returns int32 is native(LIB) is export {*};

sub curs_set(int32) returns int32 is native(LIB) is export {*};

sub def_prog_mode() returns int32 is native(LIB) is export {*};

sub def_shell_mode() returns int32 is native(LIB) is export {*};

sub delay_output(int32) returns int32 is native(LIB) is export {*};

sub delch() returns int32 is native(LIB) is export {*};

sub delscreen(SCREEN) is native(LIB) is export {*};

sub delwin(WINDOW) returns int32 is native(LIB) is export {*};

sub deleteln() returns int32 is native(LIB) is export {*};

sub derwin(WINDOW,int32,int32,int32,int32) returns WINDOW is native(LIB) is export {*};

sub doupdate() returns int32 is native(LIB) is export {*};

sub dupwin(WINDOW) returns WINDOW is native(LIB) is export {*};

sub echo() returns int32 is native(LIB) is export {*};

sub echochar(int32) returns int32 is native(LIB) is export {*};

sub erase() returns int32 is native(LIB) is export {*};

sub endwin() returns int32 is native(LIB) is export {*};

sub erasechar() returns int8 is native(LIB) is export {*};

sub filter() is native(LIB) is export {*};

sub flash() returns int32 is native(LIB) is export {*};

sub flushinp() returns int32 is native(LIB) is export {*};

sub getbkgd(WINDOW) returns int32 is native(LIB) is export {*};

sub getch() returns int32 is native(LIB) is export {*};

sub getnstr(Str,int32) returns int32 is native(LIB) is export {*};

sub getstr(Str) returns int32 is native(LIB) is export {*};

# unknown type in: WINDOW * getwin(FILE *)

sub halfdelay(int32) returns int32 is native(LIB) is export {*};

sub has_colors() returns int32 is native(LIB) is export {*};

sub has_ic() returns int32 is native(LIB) is export {*};

sub has_il() returns int32 is native(LIB) is export {*};

sub hline(int32,int32) returns int32 is native(LIB) is export {*};

sub idcok(WINDOW,int32) is native(LIB) is export {*};

sub idlok(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub immedok(WINDOW,int32) is native(LIB) is export {*};

sub inch() returns int32 is native(LIB) is export {*};

sub inchnstr(CArray[int32],int32) returns int32 is native(LIB) is export {*};

sub inchstr(CArray[int32]) returns int32 is native(LIB) is export {*};

sub initscr() returns WINDOW is native(LIB) is export {*};

sub init_color(int16,int16,int16,int16) returns int32 is native(LIB) is export {*};

sub init_pair(int16,int16,int16) returns int32 is native(LIB) is export {*};

sub innstr(Str,int32) returns int32 is native(LIB) is export {*};

sub insch(int32) returns int32 is native(LIB) is export {*};

sub insdelln(int32) returns int32 is native(LIB) is export {*};

sub insertln() returns int32 is native(LIB) is export {*};

sub insnstr(Str,int32) returns int32 is native(LIB) is export {*};

sub insstr(Str) returns int32 is native(LIB) is export {*};

sub instr(Str) returns int32 is native(LIB) is export {*};

sub intrflush(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub isendwin() returns int32 is native(LIB) is export {*};

sub is_linetouched(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub is_wintouched(WINDOW) returns int32 is native(LIB) is export {*};

sub keyname(int32) returns Str is native(LIB) is export {*};

sub keypad(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub killchar() returns int8 is native(LIB) is export {*};

sub leaveok(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub longname() returns Str is native(LIB) is export {*};

sub meta(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub move(int32,int32) returns int32 is native(LIB) is export {*};

sub mvaddch(int32,int32,int32) returns int32 is native(LIB) is export {*};

sub mvaddchnstr(int32,int32,CArray[int32],int32) returns int32 is native(LIB) is export {*};

sub mvaddchstr(int32,int32,CArray[int32]) returns int32 is native(LIB) is export {*};

sub mvaddnstr(int32,int32,Str,int32) returns int32 is native(LIB) is export {*};

sub mvaddstr(int32,int32,Str) returns int32 is native(LIB) is export {*};

sub mvchgat(int32,int32,int32,int32,int16,int32) returns int32 is native(LIB) is export {*};

sub mvcur(int32,int32,int32,int32) returns int32 is native(LIB) is export {*};

sub mvdelch(int32,int32) returns int32 is native(LIB) is export {*};

sub mvderwin(WINDOW,int32,int32) returns int32 is native(LIB) is export {*};

sub mvgetch(int32,int32) returns int32 is native(LIB) is export {*};

sub mvgetnstr(int32,int32,Str,int32) returns int32 is native(LIB) is export {*};

sub mvgetstr(int32,int32,Str) returns int32 is native(LIB) is export {*};

sub mvhline(int32,int32,int32,int32) returns int32 is native(LIB) is export {*};

sub mvinch(int32,int32) returns int32 is native(LIB) is export {*};

sub mvinchnstr(int32,int32,CArray[int32],int32) returns int32 is native(LIB) is export {*};

sub mvinchstr(int32,int32,CArray[int32]) returns int32 is native(LIB) is export {*};

sub mvinnstr(int32,int32,Str,int32) returns int32 is native(LIB) is export {*};

sub mvinsch(int32,int32,int32) returns int32 is native(LIB) is export {*};

sub mvinsnstr(int32,int32,Str,int32) returns int32 is native(LIB) is export {*};

sub mvinsstr(int32,int32,Str) returns int32 is native(LIB) is export {*};

sub mvinstr(int32,int32,Str) returns int32 is native(LIB) is export {*};

sub mvvline(int32,int32,int32,int32) returns int32 is native(LIB) is export {*};

sub mvwaddch(WINDOW,int32,int32,int32) returns int32 is native(LIB) is export {*};

sub mvwaddchnstr(WINDOW,int32,int32,CArray[int32],int32) returns int32 is native(LIB) is export {*};

sub mvwaddchstr(WINDOW,int32,int32,CArray[int32]) returns int32 is native(LIB) is export {*};

sub mvwaddnstr(WINDOW,int32,int32,Str,int32) returns int32 is native(LIB) is export {*};

sub mvwaddstr(WINDOW,int32,int32,Str) returns int32 is native(LIB) is export {*};

sub mvwchgat(WINDOW,int32,int32,int32,int32,int16,int32) returns int32 is native(LIB) is export {*};

sub mvwdelch(WINDOW,int32,int32) returns int32 is native(LIB) is export {*};

sub mvwgetch(WINDOW,int32,int32) returns int32 is native(LIB) is export {*};

sub mvwgetnstr(WINDOW,int32,int32,Str,int32) returns int32 is native(LIB) is export {*};

sub mvwgetstr(WINDOW,int32,int32,Str) returns int32 is native(LIB) is export {*};

sub mvwhline(WINDOW,int32,int32,int32,int32) returns int32 is native(LIB) is export {*};

sub mvwin(WINDOW,int32,int32) returns int32 is native(LIB) is export {*};

sub mvwinch(WINDOW,int32,int32) returns int32 is native(LIB) is export {*};

sub mvwinchnstr(WINDOW,int32,int32,CArray[int32],int32) returns int32 is native(LIB) is export {*};

sub mvwinchstr(WINDOW,int32,int32,CArray[int32]) returns int32 is native(LIB) is export {*};

sub mvwinnstr(WINDOW,int32,int32,Str,int32) returns int32 is native(LIB) is export {*};

sub mvwinsch(WINDOW,int32,int32,int32) returns int32 is native(LIB) is export {*};

sub mvwinsnstr(WINDOW,int32,int32,Str,int32) returns int32 is native(LIB) is export {*};

sub mvwinsstr(WINDOW,int32,int32,Str) returns int32 is native(LIB) is export {*};

sub mvwinstr(WINDOW,int32,int32,Str) returns int32 is native(LIB) is export {*};

sub mvwvline(WINDOW,int32,int32,int32,int32) returns int32 is native(LIB) is export {*};

sub napms(int32) returns int32 is native(LIB) is export {*};

sub newpad(int32,int32) returns WINDOW is native(LIB) is export {*};

# unknown type in: SCREEN * newterm(const char *,FILE *,FILE *)

sub newwin(int32,int32,int32,int32) returns WINDOW is native(LIB) is export {*};

sub nl() returns int32 is native(LIB) is export {*};

sub nocbreak() returns int32 is native(LIB) is export {*};

sub nodelay(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub noecho() returns int32 is native(LIB) is export {*};

sub nonl() returns int32 is native(LIB) is export {*};

sub noqiflush() is native(LIB) is export {*};

sub noraw() returns int32 is native(LIB) is export {*};

sub notimeout(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub overlay(WINDOW,WINDOW) returns int32 is native(LIB) is export {*};

sub overwrite(WINDOW,WINDOW) returns int32 is native(LIB) is export {*};

sub pair_content(int16,CArray[int16],CArray[int16]) returns int32 is native(LIB) is export {*};

sub pechochar(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub pnoutrefresh(WINDOW,int32,int32,int32,int32,int32,int32) returns int32 is native(LIB) is export {*};

sub prefresh(WINDOW,int32,int32,int32,int32,int32,int32) returns int32 is native(LIB) is export {*};

# unknown type in: int putwin(WINDOW *, FILE *)

sub qiflush() is native(LIB) is export {*};

sub raw() returns int32 is native(LIB) is export {*};

sub redrawwin(WINDOW) returns int32 is native(LIB) is export {*};

sub nc_refresh() is symbol('refresh') returns int32 is native(LIB) is export {*};

sub resetty() returns int32 is native(LIB) is export {*};

sub reset_prog_mode() returns int32 is native(LIB) is export {*};

sub reset_shell_mode() returns int32 is native(LIB) is export {*};

sub savetty() returns int32 is native(LIB) is export {*};

sub scr_dump(Str) returns int32 is native(LIB) is export {*};

sub scr_init(Str) returns int32 is native(LIB) is export {*};

sub scrl(int32) returns int32 is native(LIB) is export {*};

sub scroll(WINDOW) returns int32 is native(LIB) is export {*};

sub scrollok(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub scr_restore(Str) returns int32 is native(LIB) is export {*};

sub scr_set(Str) returns int32 is native(LIB) is export {*};

sub setscrreg(int32,int32) returns int32 is native(LIB) is export {*};

sub set_term(SCREEN) returns SCREEN is native(LIB) is export {*};

sub slk_attroff(int32) returns int32 is native(LIB) is export {*};

sub slk_attr_off(int32,int32) returns int32 is native(LIB) is export {*};

sub slk_attron(int32) returns int32 is native(LIB) is export {*};

sub slk_attr_on(int32,int32) returns int32 is native(LIB) is export {*};

sub slk_attrset(int32) returns int32 is native(LIB) is export {*};

sub slk_attr() returns int32 is native(LIB) is export {*};

sub slk_attr_set(int32,int16,int32) returns int32 is native(LIB) is export {*};

sub slk_clear() returns int32 is native(LIB) is export {*};

sub slk_color(int16) returns int32 is native(LIB) is export {*};

sub slk_init(int32) returns int32 is native(LIB) is export {*};

sub slk_label(int32) returns Str is native(LIB) is export {*};

sub slk_noutrefresh() returns int32 is native(LIB) is export {*};

sub slk_refresh() returns int32 is native(LIB) is export {*};

sub slk_restore() returns int32 is native(LIB) is export {*};

sub slk_set(int32,Str,int32) returns int32 is native(LIB) is export {*};

sub slk_touch() returns int32 is native(LIB) is export {*};

sub standout() returns int32 is native(LIB) is export {*};

sub standend() returns int32 is native(LIB) is export {*};

sub start_color() returns int32 is native(LIB) is export {*};

sub subpad(WINDOW,int32,int32,int32,int32) returns WINDOW is native(LIB) is export {*};

sub subwin(WINDOW,int32,int32,int32,int32) returns WINDOW is native(LIB) is export {*};

sub syncok(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub termattrs() returns int32 is native(LIB) is export {*};

sub termname() returns Str is native(LIB) is export {*};

sub timeout(int32) is native(LIB) is export {*};

sub touchline(WINDOW,int32,int32) returns int32 is native(LIB) is export {*};

sub touchwin(WINDOW) returns int32 is native(LIB) is export {*};

sub typeahead(int32) returns int32 is native(LIB) is export {*};

sub ungetch(int32) returns int32 is native(LIB) is export {*};

sub untouchwin(WINDOW) returns int32 is native(LIB) is export {*};

sub use_env(int32) is native(LIB) is export {*};

sub vidattr(int32) returns int32 is native(LIB) is export {*};

# unknown type in: int vidputs(chtype, NCURSES_OUTC)

sub vline(int32,int32) returns int32 is native(LIB) is export {*};

# skipping varargs: int vwprintw(WINDOW *, const char *,va_list)

# skipping varargs: int vw_printw(WINDOW *, const char *,va_list)

# skipping varargs: int vwscanw(WINDOW *, const char *,va_list)

# skipping varargs: int vw_scanw(WINDOW *, const char *,va_list)

sub printw(Str) is native(LIB) is export {*};

sub waddch(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub waddchnstr(WINDOW,CArray[int32],int32) returns int32 is native(LIB) is export {*};

sub waddchstr(WINDOW,CArray[int32]) returns int32 is native(LIB) is export {*};

sub waddnstr(WINDOW,Str,int32) returns int32 is native(LIB) is export {*};

sub waddstr(WINDOW,Str) returns int32 is native(LIB) is export {*};

sub wattron(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub wattroff(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub wattrset(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub wattr_get(WINDOW,CArray[int32],CArray[int16],int32) returns int32 is native(LIB) is export {*};

sub wattr_on(WINDOW,int32,int32) returns int32 is native(LIB) is export {*};

sub wattr_off(WINDOW,int32,int32) returns int32 is native(LIB) is export {*};

sub wattr_set(WINDOW,int32,int16,int32) returns int32 is native(LIB) is export {*};

sub wbkgd(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub wbkgdset(WINDOW,int32) is native(LIB) is export {*};

sub wborder(WINDOW,int32,int32,int32,int32,int32,int32,int32,int32) returns int32 is native(LIB) is export {*};

sub wchgat(WINDOW,int32,int32,int16,int32) returns int32 is native(LIB) is export {*};

sub wclear(WINDOW) returns int32 is native(LIB) is export {*};

sub wclrtobot(WINDOW) returns int32 is native(LIB) is export {*};

sub wclrtoeol(WINDOW) returns int32 is native(LIB) is export {*};

sub wcolor_set(WINDOW,int16,int32) returns int32 is native(LIB) is export {*};

sub wcursyncup(WINDOW) is native(LIB) is export {*};

sub wdelch(WINDOW) returns int32 is native(LIB) is export {*};

sub wdeleteln(WINDOW) returns int32 is native(LIB) is export {*};

sub wechochar(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub werase(WINDOW) returns int32 is native(LIB) is export {*};

sub wgetch(WINDOW) returns int32 is native(LIB) is export {*};

sub wgetnstr(WINDOW,Str,int32) returns int32 is native(LIB) is export {*};

sub wgetstr(WINDOW,Str) returns int32 is native(LIB) is export {*};

sub whline(WINDOW,int32,int32) returns int32 is native(LIB) is export {*};

sub winch(WINDOW) returns int32 is native(LIB) is export {*};

sub winchnstr(WINDOW,CArray[int32],int32) returns int32 is native(LIB) is export {*};

sub winchstr(WINDOW,CArray[int32]) returns int32 is native(LIB) is export {*};

sub winnstr(WINDOW,Str,int32) returns int32 is native(LIB) is export {*};

sub winsch(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub winsdelln(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub winsertln(WINDOW) returns int32 is native(LIB) is export {*};

sub winsnstr(WINDOW,Str,int32) returns int32 is native(LIB) is export {*};

sub winsstr(WINDOW,Str) returns int32 is native(LIB) is export {*};

sub winstr(WINDOW,Str) returns int32 is native(LIB) is export {*};

sub wmove(WINDOW,int32,int32) returns int32 is native(LIB) is export {*};

sub wnoutrefresh(WINDOW) returns int32 is native(LIB) is export {*};

sub wredrawln(WINDOW,int32,int32) returns int32 is native(LIB) is export {*};

sub wrefresh(WINDOW) returns int32 is native(LIB) is export {*};

sub wscrl(WINDOW,int32) returns int32 is native(LIB) is export {*};

sub wsetscrreg(WINDOW,int32,int32) returns int32 is native(LIB) is export {*};

sub wstandout(WINDOW) returns int32 is native(LIB) is export {*};

sub wstandend(WINDOW) returns int32 is native(LIB) is export {*};

sub wsyncdown(WINDOW) is native(LIB) is export {*};

sub wsyncup(WINDOW) is native(LIB) is export {*};

sub wtimeout(WINDOW,int32) is native(LIB) is export {*};

sub wtouchln(WINDOW,int32,int32,int32) returns int32 is native(LIB) is export {*};

sub wvline(WINDOW,int32,int32) returns int32 is native(LIB) is export {*};

sub tigetflag(Str) returns int32 is native(LIB) is export {*};

sub tigetnum(Str) returns int32 is native(LIB) is export {*};

sub tigetstr(Str) returns Str is native(LIB) is export {*};

sub putp(Str) returns int32 is native(LIB) is export {*};

# skipping varargs: char * tparm(const char *, ...)

# skipping varargs: char * tiparm(const char *, ...)

sub getattrs(WINDOW) returns int32 is native(LIB) is export {*};

sub getcurx(WINDOW) returns int32 is native(LIB) is export {*};

sub getcury(WINDOW) returns int32 is native(LIB) is export {*};

sub getbegx(WINDOW) returns int32 is native(LIB) is export {*};

sub getbegy(WINDOW) returns int32 is native(LIB) is export {*};

sub getmaxx(WINDOW) returns int32 is native(LIB) is export {*};

sub getmaxy(WINDOW) returns int32 is native(LIB) is export {*};

sub getparx(WINDOW) returns int32 is native(LIB) is export {*};

sub getpary(WINDOW) returns int32 is native(LIB) is export {*};

sub is_term_resized(int32,int32) returns int32 is native(LIB) is export {*};

sub keybound(int32,int32) returns Str is native(LIB) is export {*};

sub curses_version() returns Str is native(LIB) is export {*};

sub assume_default_colors(int32,int32) returns int32 is native(LIB) is export {*};

sub define_key(Str,int32) returns int32 is native(LIB) is export {*};

sub get_escdelay() returns int32 is native(LIB) is export {*};

sub key_defined(Str) returns int32 is native(LIB) is export {*};

sub keyok(int32,int32) returns int32 is native(LIB) is export {*};

sub resize_term(int32,int32) returns int32 is native(LIB) is export {*};

sub resizeterm(int32,int32) returns int32 is native(LIB) is export {*};

sub set_escdelay(int32) returns int32 is native(LIB) is export {*};

sub set_tabsize(int32) returns int32 is native(LIB) is export {*};

sub use_default_colors() returns int32 is native(LIB) is export {*};

sub use_extended_names(int32) returns int32 is native(LIB) is export {*};

sub use_legacy_coding(int32) returns int32 is native(LIB) is export {*};

# unknown type in: int use_screen(SCREEN *, NCURSES_SCREEN_CB, void *)

# unknown type in: int use_window(WINDOW *, NCURSES_WINDOW_CB, void *)

sub wresize(WINDOW,int32,int32) returns int32 is native(LIB) is export {*};

sub wgetparent(WINDOW) returns WINDOW is native(LIB) is export {*};

sub is_cleared(WINDOW) returns int32 is native(LIB) is export {*};

sub is_idcok(WINDOW) returns int32 is native(LIB) is export {*};

sub is_idlok(WINDOW) returns int32 is native(LIB) is export {*};

sub is_immedok(WINDOW) returns int32 is native(LIB) is export {*};

sub is_keypad(WINDOW) returns int32 is native(LIB) is export {*};

sub is_leaveok(WINDOW) returns int32 is native(LIB) is export {*};

sub is_nodelay(WINDOW) returns int32 is native(LIB) is export {*};

sub is_notimeout(WINDOW) returns int32 is native(LIB) is export {*};

sub is_pad(WINDOW) returns int32 is native(LIB) is export {*};

sub is_scrollok(WINDOW) returns int32 is native(LIB) is export {*};

sub is_subwin(WINDOW) returns int32 is native(LIB) is export {*};

sub is_syncok(WINDOW) returns int32 is native(LIB) is export {*};

sub wgetscrreg(WINDOW,CArray[int32],CArray[int32]) returns int32 is native(LIB) is export {*};

sub getmouse(MEVENT) returns int32 is native(LIB) is export {*};

sub ungetmouse(MEVENT) returns int32 is native(LIB) is export {*};

sub mousemask(int32,CArray[int32]) returns int32 is native(LIB) is export {*};

sub wenclose(WINDOW,int32,int32) returns int32 is native(LIB) is export {*};

sub mouseinterval(int32) returns int32 is native(LIB) is export {*};

sub wmouse_trafo(WINDOW,CArray[int32],CArray[int32],int32) returns int32 is native(LIB) is export {*};

sub mouse_trafo(CArray[int32],CArray[int32],int32) returns int32 is native(LIB) is export {*};

sub mcprint(Str,int32) returns int32 is native(LIB) is export {*};

sub has_key(int32) returns int32 is native(LIB) is export {*};

sub trace(int32) is native(LIB) is export {*};

