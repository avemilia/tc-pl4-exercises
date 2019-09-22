#!/usr/bin/env bash

set -e

source test_common.sh # gets copied in bindir with this name

target="09-statements_itoa"

function test_1() {
    env_args=""
    args=""
    input=""
    expect_output=""
    expect_status=1
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_2() {
    env_args=""
    args="123 1"
    input=""
    expect_output=""
    expect_status=2
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_3() {
    env_args=""
    args="123 3"
    input=""
    expect_output="123"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_4() {
    env_args=""
    args="123 4"
    input=""
    expect_output="123"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

if declare -f "$1" >/dev/null; then
    "$@"
else
    echo "'$1' is not a known function name" >&2
    exit 1
fi
