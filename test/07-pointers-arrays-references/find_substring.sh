set -e

source test_common.sh # gets copied in bindir with this name

target="07-pointers-arrays-references_find_substring"

function test_1() {
    args="s \"\" \"\""
    input=""
    expect_output=""
    expect_status=1
    test::test "$target" "$args" "$input" "$expect_output" "$expect_status"
}

# for string

function test_2() {
    args="string \"\" \"\""
    input=""
    expect_output="0"
    expect_status=0
    test::test "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_3() {
    args="string \"\" ab"
    input=""
    expect_output="0"
    expect_status=0
    test::test "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_4() {
    args="string ab ab"
    input=""
    expect_output="1"
    expect_status=0
    test::test "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_5() {
    args="string abab ab"
    input=""
    expect_output="2"
    expect_status=0
    test::test "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_6() {
    args="string xabaacbaxabb ab"
    input=""
    expect_output="2"
    expect_status=0
    test::test "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_7() {
    args="string ab \"\""
    input=""
    expect_output="0"
    expect_status=0
    test::test "$target" "$args" "$input" "$expect_output" "$expect_status"
}

# for char

function test_8() {
    args="char \"\" \"\""
    input=""
    expect_output="0"
    expect_status=0
    test::test "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_9() {
    args="char \"\" ab"
    input=""
    expect_output="0"
    expect_status=0
    test::test "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_10() {
    args="char ab ab"
    input=""
    expect_output="1"
    expect_status=0
    test::test "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_11() {
    args="char abab ab"
    input=""
    expect_output="2"
    expect_status=0
    test::test "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_12() {
    args="char xabaacbaxabb ab"
    input=""
    expect_output="2"
    expect_status=0
    test::test "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_13() {
    args="char ac ab"
    input=""
    expect_output="0"
    expect_status=0
    test::test "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_14() {
    args="char ab \"\""
    input=""
    expect_output="0"
    expect_status=0
    test::test "$target" "$args" "$input" "$expect_output" "$expect_status"
}

if declare -f "$1" >/dev/null; then
    "$@"
else
    echo "'$1' is not a known function name" >&2
    exit 1
fi
