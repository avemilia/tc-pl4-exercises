#!/usr/bin/env bash

set -e

source test_common.sh # gets copied in bindir with this name

target="10-expressions_calculator"

function test_1() {
    env_args=""
    args=""
    input=""
    expect_output=""
    expect_status=1
    test::test "$env_args" "$target" "$args" "$input" "$expect_output" "$expect_status"
}
