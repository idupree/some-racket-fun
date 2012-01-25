#!/bin/sh
# Usage: echo 'The quick brown fox jumps over the lazy dog' | ./string-to-scheme-list.sh
{ printf \''(%s)\n' "$(sed -E 's/(.)/"\1" /g')"; }
