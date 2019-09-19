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
    if ((str.empty() && substr_len == 0) || substr_len == 0)
        return 0;

    auto pos = str.find(substr);
    if (pos == string::npos)
        return 0;
    int cnt = 1;

    while ((pos = str.find(substr, pos + substr_len)) != string::npos)
        cnt++;

    return cnt;
}

string::size_type str_find_helper(const char* s, const char* substr, long s_len, long substr_len, long pos) {
    for (decltype(pos) i = pos; i <= s_len - substr_len; ++i) {
        auto j = i;
        decltype(substr_len) matching = 0;
        for (decltype(substr_len) m = 0; m < substr_len && j < s_len; ++m, ++j) {
            if (s[j] != substr[m])
                break;
            ++matching;
        }
        if (matching == substr_len)
            return i;
    }

    return string::npos;
}

string::size_type str_find(const char* s, const char* substr) {
    auto s_len = static_cast<long>(strlen(s));
    auto substr_len = static_cast<long>(strlen(substr));

    return str_find_helper(s, substr, s_len, substr_len, 0);
}

string::size_type str_find(const char* s, const char* substr, string::size_type pos) {
    // unsigned types are annoying and dangerous in classic for loops
    auto s_len = static_cast<long>(strlen(s));
    auto substr_len = static_cast<long>(strlen(substr));
    auto lpos = static_cast<long>(pos);

    return str_find_helper(s, substr, s_len, substr_len, lpos);
}


int count_substrings(const char* s, const char* substr) {
    auto s_len = strlen(s);
    auto substr_len = strlen(substr);
    if ((s_len == 0 && substr_len == 0) || substr_len == 0)
        return 0;

    auto pos = str_find(s, substr);
    if (pos == string::npos)
        return 0;
    int cnt = 1;

    while ((pos = str_find(s, substr, pos + substr_len)) != string::npos)
        cnt++;

    return cnt;
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
