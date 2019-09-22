#!/usr/bin/env bash

set -e

source test_common.sh # gets copied in bindir with this name

target="09-statements_atoi"

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
    args="\" \""
    input=""
    expect_output=""
    expect_status=3
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_3() {
    env_args=""
    args="123"
    input=""
    expect_output="123"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_4() {
    env_args=""
    args="\"  123\""
    input=""
    expect_output="123"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_5() {
    env_args=""
    args="\"123  \""
    input=""
    expect_output="123"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_6() {
    env_args=""
    args="\" 12 3 \""
    input=""
    expect_output=""
    expect_status=3
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_7() {
    env_args=""
    args="0123"
    input=""
    expect_output="83"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_8() {
    env_args=""
    args="0x123"
    input=""
    expect_output="291"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_9() {
    env_args=""
    args="\\\123"
    input=""
    expect_output="83"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_10() {
    env_args=""
    args="\\\x123"
    input=""
    expect_output="291"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_11() {
    env_args=""
    args="\\\1234"
    input=""
    expect_output="83"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_12() {
    env_args=""
    args="-123"
    input=""
    expect_output="-123"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_13() {
    env_args=""
    args="-0123"
    input=""
    expect_output="-83"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_14() {
    env_args=""
    args="-0x123"
    input=""
    expect_output="-291"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_15() {
    env_args=""
    int_min=$(getconf INT_MIN)
    args="$int_min"
    input=""
    expect_output="$int_min"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_16() {
    env_args=""
    int_max=$(getconf INT_MAX)
    args="$int_max"
    input=""
    expect_output="$int_max"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_17() {
    env_args=""
    args="0"
    input=""
    expect_output="0"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_18() {
    env_args=""
    args="-0"
    input=""
    expect_output="0"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_19() {
    env_args=""
    args="00"
    input=""
    expect_output="0"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_20() {
    env_args=""
    args="000"
    input=""
    expect_output="0"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_21() {
    env_args=""
    args="0x0"
    input=""
    expect_output="0"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_22() {
    env_args=""
    args="1111111111111111111111111111"
    input=""
    expect_output=""
    expect_status=2
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_23() {
    env_args=""
    args="-1111111111111111111111111111"
    input=""
    expect_output=""
    expect_status=2
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_24() {
    env_args=""
    args="01111111111111111111111111111"
    input=""
    expect_output=""
    expect_status=2
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_25() {
    env_args=""
    args="0x1111111111111111111111111111"
    input=""
    expect_output=""
    expect_status=2
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

if declare -f "$1" >/dev/null; then
    "$@"
else
    echo "'$1' is not a known function name" >&2
    exit 1
fi
