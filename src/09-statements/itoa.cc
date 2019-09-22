// Write a function itoa(int i, char b[]) that creates a string representation
// of i in b and returns b. Modify itoa() from the previous exercise to take an
// extra "string length" argument to make overflow less likely.

#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <memory>
#include <iostream>

using namespace std;

char* itoa(int i, char* b, long b_len) {
    int num_of_digits = static_cast<int>(log10(i)) + 1;
    if (b_len < num_of_digits + 1) // for '\0'
        return nullptr;

    int n {num_of_digits};
    do {
        auto q_r = div(i, 10);
        i = q_r.quot;
        b[n-- - 1] = q_r.rem + '0';
    } while (i);

    b[num_of_digits] = '\0';

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
    unique_ptr<char[]> b {new char[b_len] {}};
    if (!itoa(i, b.get(), b_len))
        exit(2);
    cout << b.get() << '\n';

    return 0;
}
