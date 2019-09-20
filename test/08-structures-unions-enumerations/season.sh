#!/usr/bin/env bash

set -e

source test_common.sh # gets copied in bindir with this name

target="08-structures-unions-enumerations_season"

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
    args="\"\""
    input=""
    expect_output=""
    expect_status=1
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

# in

function test_3() {
    env_args=""
    args="io \"\""
    input=""
    expect_output=""
    expect_status=1
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_4() {
    env_args=""
    args="io garbage"
    input=""
    expect_output=""
    expect_status=1
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_5() {
    env_args=""
    args="io summer"
    input=""
    expect_output="summer"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_6() {
    env_args="LANG=\"cs_CZ.UTF-8\" LC_ALL=\"cs_CZ.UTF-8\""
    args="io summer"
    input=""
    expect_output=""
    expect_status=1
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_7() {
    env_args="LANG=\"cs_CZ.UTF-8\" LC_ALL=\"cs_CZ.UTF-8\""
    args="io léto"
    input=""
    expect_output="léto"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_8() {
    env_args=""
    args="incpre summer"
    input=""
    expect_output="autumn"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_9() {
    env_args="LANG=\"cs_CZ.UTF-8\" LC_ALL=\"cs_CZ.UTF-8\""
    args="incpre léto"
    input=""
    expect_output="podzim"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_10() {
    env_args=""
    args="incpost summer"
    input=""
    expect_output="summer autumn"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_11() {
    env_args="LANG=\"cs_CZ.UTF-8\" LC_ALL=\"cs_CZ.UTF-8\""
    args="incpost léto"
    input=""
    expect_output="léto podzim"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_12() {
    env_args=""
    args="decpre summer"
    input=""
    expect_output="spring"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_13() {
    env_args="LANG=\"cs_CZ.UTF-8\" LC_ALL=\"cs_CZ.UTF-8\""
    args="decpre léto"
    input=""
    expect_output="jaro"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_14() {
    env_args=""
    args="decpost summer"
    input=""
    expect_output="summer spring"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_15() {
    env_args="LANG=\"cs_CZ.UTF-8\" LC_ALL=\"cs_CZ.UTF-8\""
    args="decpost léto"
    input=""
    expect_output="léto jaro"
    expect_status=0
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}

if declare -f "$1" >/dev/null; then
    "$@"
else
    echo "'$1' is not a known function name" >&2
    exit 1
fi
