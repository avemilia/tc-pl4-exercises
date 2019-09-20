#!/usr/bin/env bash

set -e

source test_common.sh # gets copied in bindir with this name

target="07-pointers-arrays-references_notwice"

function test_1() {
    env_args=""
    args="-a <<<"
    input="abc 123 abc"
    expect_output=""
    expect_status=1
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_2() {
    env_args=""
    args="-s abc <<<"
    input="abc 123 abc"
    expect_output=""
    expect_status=1
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_3() {
    env_args=""
    args="<<<"
    input="abc 123 abc"
    expect_output="Words: 'abc' '123'"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_4() {
    env_args=""
    args="<<<"
    input="abc 123 abc Quit bcd"
    expect_output="Words: 'abc' '123'"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_5() {
    env_args=""
    args="-s <<<"
    input="abc 123 abc Quit bcd"
    expect_output="Words: '123' 'abc'"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

if declare -f "$1" >/dev/null; then
    "$@"
else
    echo "'$1' is not a known function name" >&2
    exit 1
fi
