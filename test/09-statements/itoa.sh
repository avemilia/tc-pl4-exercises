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

# zero
function test_2() {
    env_args=""
    args="0 0"
    input=""
    expect_output=""
    expect_status=2
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_3() {
    env_args=""
    args="0 1"
    input=""
    expect_output=""
    expect_status=2
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_4() {
    env_args=""
    args="0 2"
    input=""
    expect_output="0"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_5() {
    env_args=""
    args="0 20"
    input=""
    expect_output="0"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

# positive integer, normal
function test_6() {
    env_args=""
    args="123 0"
    input=""
    expect_output=""
    expect_status=2
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_7() {
    env_args=""
    args="123 3"
    input=""
    expect_output=""
    expect_status=2
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_8() {
    env_args=""
    args="123 4"
    input=""
    expect_output="123"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_9() {
    env_args=""
    args="123 20"
    input=""
    expect_output="123"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

# INT_MAX
function test_10() {
    env_args=""
    int_max=$(getconf INT_MAX)
    args="$int_max 0"
    input=""
    expect_output=""
    expect_status=2
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_11() {
    env_args=""
    int_max=$(getconf INT_MAX)
    int_max_len=$(getconf INT_MAX | wc -c)
    int_max_len=$((int_max_len-1))
    args="$int_max $int_max_len"
    input=""
    expect_output=""
    expect_status=2
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_12() {
    env_args=""
    int_max=$(getconf INT_MAX)
    int_max_len=$(getconf INT_MAX | wc -c)
    args="$int_max $int_max_len"
    input=""
    expect_output="$int_max"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_13() {
    env_args=""
    int_max=$(getconf INT_MAX)
    int_max_len=$(getconf INT_MAX | wc -c)
    int_max_len=$((int_max_len + 20))
    args="$int_max $int_max_len"
    input=""
    expect_output="$int_max"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

# negative integer, normal
function test_14() {
    env_args=""
    args="-123 0"
    input=""
    expect_output=""
    expect_status=2
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_15() {
    env_args=""
    args="-123 4"
    input=""
    expect_output=""
    expect_status=2
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_16() {
    env_args=""
    args="-123 5"
    input=""
    expect_output="-123"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_17() {
    env_args=""
    args="-123 20"
    input=""
    expect_output="-123"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

# INT_MIN
function test_18() {
    env_args=""
    int_min=$(getconf INT_MIN)
    args="$int_min 0"
    input=""
    expect_output=""
    expect_status=2
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_19() {
    env_args=""
    int_min=$(getconf INT_MIN)
    int_min_len=$(getconf INT_MIN | wc -c)
    int_min_len=$((int_min_len - 1))
    args="$int_min $int_min_len"
    input=""
    expect_output=""
    expect_status=2
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_20() {
    env_args=""
    int_min=$(getconf INT_MIN)
    int_min_len=$(getconf INT_MIN | wc -c)
    args="$int_min $int_min_len"
    input=""
    expect_output="$int_min"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_21() {
    env_args=""
    int_min=$(getconf INT_MIN)
    int_min_len=$(getconf INT_MIN | wc -c)
    int_min_len=$((int_min_len + 20))
    args="$int_min $int_min_len"
    input=""
    expect_output="$int_min"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

if declare -f "$1" >/dev/null; then
    "$@"
else
    echo "'$1' is not a known function name" >&2
    exit 1
fi
