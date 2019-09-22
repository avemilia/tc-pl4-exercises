// Write a function itoa(int i, char b[]) that creates a string representation
// of i in b and returns b. Modify itoa() from the previous exercise to take an
// extra "string length" argument to make overflow less likely.

#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <memory>
#include <iostream>
#include <limits>

using namespace std;

void itoa_helper(int i, char* b, int num_of_digits) {
    int n {num_of_digits};
    do {
        auto q_r = div(i, 10);
        i = q_r.quot;
        b[n-- - 1] = q_r.rem + '0';
    } while (i);
    b[num_of_digits] = '\0';
}

char* itoa(int i, char* b, long b_len) {
    // log10 cannot be called with i <= 0, so deal with that manually

    if (i == 0) {
        if (b_len >= 2) {
            b[0] = '0';
            b[1] = '\0';
            return b;
        }
        return nullptr;
    }

    if (i < 0) {
        // calling abs() on INT_MIN is undefined
        if (i == numeric_limits<int>::min()) {
            i = numeric_limits<int>::max();
            // this will suffice to count num_of_digits, but remember
            // to add 1 to b[num_of_digits] later
            int num_of_digits = static_cast<int>(log10(i)) + 1;
            if (b_len < num_of_digits + 2) // for '-' and '\0'
                return nullptr;
            b[0] = '-';
            itoa_helper(i, b + 1, num_of_digits);
            b[num_of_digits]++;
            return b;
        }

        i = abs(i);
        int num_of_digits = static_cast<int>(log10(i)) + 1;
        if (b_len < num_of_digits + 2) // for '-' and '\0'
            return nullptr;
        b[0] = '-';
        itoa_helper(i, b + 1, num_of_digits);
        return b;
    }

    int num_of_digits = static_cast<int>(log10(i)) + 1;
    if (b_len < num_of_digits + 1) // for '\0'
        return nullptr;
    itoa_helper(i, b, num_of_digits);
    return b;
}

int main(int argc, char** argv) {
    if (argc < 3) {
        fprintf(stderr, "Usage: %s integer buffer_length\n", argv[0]);
        exit(1);
    }

    // no error checking because this is to test itoa() only
    int i = atoi(argv[1]);
    long b_len = atol(argv[2]);
    unique_ptr<char[]> b {new char[b_len]};
    if (!itoa(i, b.get(), b_len))
        exit(2);
    cout << b.get() << '\n';

    return 0;
}
