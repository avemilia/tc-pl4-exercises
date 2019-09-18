//  Read a sequence of words from input. Use Quit as a word that terminates the
//  input. Print the words in the order they were entered. Don’t print a word
//  twice. Modify the program to sort the words before printing them.

// NOTE(portability): getopt's '+' is glibc-specific

#include <unistd.h>
#include <cstdio>
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

// from getopt():
// extern int optind, opterr, optopt;
// extern char* optarg;

[[noreturn]] static void usage_error(const char* prog_name, const char* msg = "", const int opt = 0) {
    if (msg && opt) {
        fprintf(stderr, "%s (-%c)\n", msg, opt);
    } else if (msg) {
        fprintf(stderr, "%s\n", msg);
    }
    fprintf(stderr, "Usage: %s [-s]\n", prog_name);
    exit(1);
}

struct Cli_options {
    bool sort;
};

int main(int argc, char** argv) {
    Cli_options opts {};
    int opt;
    while ((opt = getopt(argc, argv, "+:s")) != -1) {
        switch (opt) {
        case 's':
            opts.sort = true;
            break;
        case ':':
            usage_error(argv[0], "Missing argument", optopt);
        case '?':
            usage_error(argv[0], "Unrecognized option", optopt);
        default:
            cerr << "Unexpected case in switch(opt)\n";
            exit(2);
        }
    }

    if (optind < argc) {
        cerr << "Trailing nonoption argument(s): \"";
        while (optind < argc - 1)
            cerr << argv[optind++] << ' ';
        cerr << argv[optind] << "\"\n";
        usage_error(argv[0]);
    }

    vector<string> words;
    for (string word; cin >> word;) {
        if (word == "Quit") break;
        if (find(words.begin(), words.end(), word) == words.end())
            words.emplace_back(word);
    }

    if (opts.sort) {
        sort(words.begin(), words.end());
    }

    cout << "Words:";
    for (const auto& w : words)
        cout << ' ' << '\'' << w << '\'';
    cout << '\n';

    return 0;
}
