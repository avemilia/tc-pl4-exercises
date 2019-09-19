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

function test_2() {
    args="string \"\" \"\""
    input=""
    expect_output="0"
    expect_status=0
    test::test "$target" "$args" "$input" "$expect_output" "$expect_status"
}

function test_3() {
    args="string \"\" \"ab\""
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
