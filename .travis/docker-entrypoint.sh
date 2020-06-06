#! /bin/sh

set -x

# Update docker instance
apk update
apk upgrade
apk add ncurses

# Report status
raku --version
which zef
zef --installed list

# Install dependencies
zef install . --deps-only --force

# Unlisted dependency for AUTHOR_TESTING
zef install Test::META --force

set -e

zef --verbose install . --/test

# FIXME: Hard-code library name until Rakudo PR #3747 is merged
export RAKU_NCURSES_LIB=libncursesw.so.6

AUTHOR_TESTING=1 prove6 -v t
