#!/usr/bin/env bash

set -e

function die() {
    echo "Expected: '$1'"
    echo "But got : '$2'"
    exit 1
}

# $1:tgt, $2:args, $3:in, $4:expect
function check() {
    local cmd got

    echo "Testing '$1 $2 $3'"

    # this 2-line crap took me an hour to write correctly... PepeHands
    cmd="./$1 $2 \"$3\""
    eval got=\$\("$cmd"\)

    if [ "$got" != "$4" ]; then
        die "$4" "$got"
    fi
}

tgt="07-pointers-arrays-references_notwice"

args="<<<"
in="abc 123 abc Quit bcd"
expect="Words: 'abc' '123'"
check "$tgt" "$args" "$in" "$expect"

args="-s <<<"
in="abc 123 abc Quit bcd"
expect="Words: 123' 'abc'"
check "$tgt" "$args" "$in" "$expect"
