#!/usr/bin/env bash

set -e

source test_common.sh # gets copied in bindir with this name

target="07-pointers-arrays-references_find_substring"

function test_1() {
    env_args=""
    args="s \"\" \"\""
    input=""
    expect_output=""
    expect_status=1
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

# for string

function test_2() {
    env_args=""
    args="string \"\" \"\""
    input=""
    expect_output="0"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_3() {
    env_args=""
    args="string \"\" ab"
    input=""
    expect_output="0"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_4() {
    env_args=""
    args="string ab ab"
    input=""
    expect_output="1"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_5() {
    env_args=""
    args="string abab ab"
    input=""
    expect_output="2"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_6() {
    env_args=""
    args="string xabaacbaxabb ab"
    input=""
    expect_output="2"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_7() {
    env_args=""
    args="string ab \"\""
    input=""
    expect_output="0"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

# for char

function test_8() {
    env_args=""
    args="char \"\" \"\""
    input=""
    expect_output="0"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_9() {
    env_args=""
    args="char \"\" ab"
    input=""
    expect_output="0"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_10() {
    env_args=""
    args="char ab ab"
    input=""
    expect_output="1"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_11() {
    env_args=""
    args="char abab ab"
    input=""
    expect_output="2"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_12() {
    env_args=""
    args="char xabaacbaxabb ab"
    input=""
    expect_output="2"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_13() {
    env_args=""
    args="char ac ab"
    input=""
    expect_output="0"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_14() {
    env_args=""
    args="char ab \"\""
    input=""
    expect_output="0"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

if declare -f "$1" >/dev/null; then
    "$@"
else
    echo "'$1' is not a known function name" >&2
    exit 1
fi
