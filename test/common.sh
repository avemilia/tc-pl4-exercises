#!/usr/bin/env bash

# Common code for all tests.

set -e

# $1:exit_code
function test::die() {
    exit "$1"
}

# $1:expected output, $2:actual output
function test::output_mismatch() {
    echo "  OUTPUT MISMATCH:" >&2
    echo "      EXPECTED: '$1'" >&2
    echo "       BUT GOT: '$2'" >&2
    test::die 1
}

# $1:expected status, $2:actual status
function test::status_mismatch() {
    echo "  EXIT STATUS MISMATCH:" >&2
    echo "      EXPECTED: '$1'" >&2
    echo "       BUT GOT: '$2'" >&2
    test::die 2
}

# $1:target, $2:args, $3:input, $4:expect_output $5:expect_status
function test::test() {
    local cmd output status

    echo "TESTING '$1 $2 $3'"

    cmd="./$1 $2 \"$3\""
    set +e # disable set -e for eval
    eval output=\$\("$cmd"\)
    status=$?
    set -e

    if [ "$output" != "$4" ]; then
        test::output_mismatch "$4" "$output"
    fi
    if [ "$status" != "$5" ]; then
        test::status_mismatch "$5" "$status"
    fi
}
