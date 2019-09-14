// Write a loop that prints out the values 4, 5, 9, 17, 12 without using an
// array or a vector.

#include <iostream>
#include <cstring>

using namespace std;

int main() {
    const char str[] {48 + 4, 48 + 5, 48 + 9, 48 + 17, 48 + 12, '\0'}; // 48 is '0'
    for (size_t i = 0; i < strlen(str); ++i)
        cout << str[i] - 48 << ' ';
    cout << '\n';

    return 0;
}
