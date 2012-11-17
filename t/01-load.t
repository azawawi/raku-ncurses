use v6;

BEGIN { @*INC.push('lib') };

use Test;

plan 1;

use NCurses;

ok 1, "'use NCurses' worked!";
