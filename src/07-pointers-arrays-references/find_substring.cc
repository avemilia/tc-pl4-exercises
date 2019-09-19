// Write a function that counts the number of occurrences of a pair of letters
// in a string and another that does the same in a zero-terminated array of
// char (a C-style string). For example, the pair "ab" appears twice in
// "xabaacbaxabb".

#include <cstring>
#include <cstdio>
#include <cstdlib>
#include <string>
#include <iostream>

using namespace std;

int count_substrings(string& str, const char* substr) {
    auto substr_len = strlen(substr);
    if (str.empty() && substr_len == 0)
        return 0;

    auto pos = str.find(substr);
    if (pos == string::npos)
        return 0;
    int cnt = 1;

    while ((pos = str.find(substr, pos + substr_len)) != string::npos)
        cnt++;

    return cnt;
}

int count_substrings(const char* s, const char* substr) {
    return 0;
}

int main(int argc, char** argv) {
    if (!strcmp(argv[1], "string")) {
        string s {argv[2]};
        cout << count_substrings(s, argv[3]) << '\n';
    } else if (!strcmp(argv[1], "char")) {
        cout << count_substrings(argv[2], argv[3]) << '\n';
    } else {
        fprintf(stderr, "Usage: %s <string|char> str substr\n", argv[0]);
        exit(1);
    }

    return 0;
}
