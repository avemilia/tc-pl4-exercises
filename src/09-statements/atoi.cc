// Write a function atoi(const char∗) that takes a C-style string containing
// digits and returns the corresponding int. For example, atoi("123") is 123.
// Modify atoi() to handle C++ octal and hexadecimal notation in addition to
// plain decimal numbers. Modify atoi() to handle the C++ character constant
// notation.

#include <limits>
#include <cstring>
#include <cctype>
#include <cmath>
#include <iostream>

using namespace std;

int char_to_dec(int ch, int base) {
    switch (base) {
    case 8:
        if (ch >= '0' && ch <= '7') return ch - '0';
        break;
    case 10:
        if (ch >= '0' && ch <= '9') return ch - '0';
        break;
    case 16:
        if (ch >= '0' && ch <= '9') return ch - '0';
        if (ch >= 'a' && ch <= 'f') return ch - 'a' + 10;
        if (ch >= 'A' && ch <= 'F') return ch - 'A' + 10;
        break;
    default:
        break;
    }

    return -1;
}

int atoi(const char* str, int& err, int base) {
    int num {};

    auto str_len = strlen(str);

    for (decltype(str_len) i {0}; i < str_len; ++i) {
        int c = str[i];
        if ((c = char_to_dec(c, base)) == -1) {
            // no character to interpret
            err = 2;
            return 0;
        }

        auto pow_result = pow(base, str_len - i - 1);
        if (pow_result == HUGE_VAL) {
            // overflow
            err = 1;
            return 0;
        }
        auto b = c * pow_result;
        if (c != 0 && b / c != pow_result) {
            // overflow
            err = 1;
            return 0;
        }
        if (((b > 0) && (num > (numeric_limits<int>::max() - b))) ||
            ((b < 0) && (num < (numeric_limits<int>::min() - b)))) {
            // overflow
            err = 1;
            return 0;
        }
        num += b;
    }

    err = 0;
    return num;
}

int atoi(char* str, int& err) {
    switch (str[0]) {
    case '\0':
        // no character to interpret
        err = 2;
        return 0;
    case '0':
        switch (str[1]) {
        case '\0':
            // decimal zero
            err = 0;
            return 0;
        case 'x':
        case 'X':
            return atoi(&str[2], err, 16);
        default:
            return atoi(&str[1], err, 8);
        }
    case '\\': // \ooo is octal, \xhhh... is hex
        switch (str[1]) {
        case 'x':
        case 'X':
            return atoi(&str[2], err, 16);
        default:
            if (strlen(&str[1]) > 3) // octal can only have 3 digits
                str[4] = '\0';
            return atoi(&str[1], err, 8);
        }
    default:
        return atoi(&str[0], err, 10);
    }
}

int main(int argc, char** argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s number\n", argv[0]);
        exit(1);
    }

    // strip left whitespace
    char* number_str = argv[1];
    while (*number_str) {
        if (!isspace(*number_str))
            break;
        number_str++;
    }
    // strip right whitespace
    auto number_str_len = static_cast<long>(strlen(number_str));
    for (auto i {number_str_len - 1}; i >= 0; --i) {
        if (!isspace(number_str[i]))
            break;
        number_str[i] = '\0';
    }

    int err {};
    auto result = atoi(number_str, err);
    switch (err) {
    case 1:
        cerr << "Overflow\n";
        exit(2);
    case 2:
        cerr << "No character to interpret\n";
        exit(3);
    }

    cout << result << '\n';

    return 0;
}
