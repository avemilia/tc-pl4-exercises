// Implement an enum called Season with enumerators spring, summer, autumn, and
// winter. Define operators ++ and −− for Season. Define input (>>) and output
// (<<) operations for Season, providing string values. Provide a way to
// control the mapping between Season values and their string representations.
// For example, I might want the strings to reflect the Danish names for the
// seasons. For further study, see Chapter 39.

#include <locale>
#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <sstream>

using namespace std;

enum class Season {
    spring, summer, autumn, winter
};

unordered_map<string, unordered_map<Season, string>> season_translations = {
        {"cs_CZ.UTF-8",
                {
                        {Season::spring, {"jaro"}},
                        {Season::summer, {"léto"}},
                        {Season::autumn, {"podzim"}},
                        {Season::winter, {"zima"}}
                }
        },
        {"C",
                {
                        {Season::spring, {"spring"}},
                        {Season::summer, {"summer"}},
                        {Season::autumn, {"autumn"}},
                        {Season::winter, {"winter"}}
                }
        }
};

ostream& operator<<(ostream& os, const Season& s) {
    locale loc {""}; // user locale
    if (season_translations.find(loc.name()) == season_translations.end())
        loc = locale(); // C locale

    switch (s) {
    case Season::spring:
        return os << season_translations[loc.name()][Season::spring];
    case Season::summer:
        return os << season_translations[loc.name()][Season::summer];
    case Season::autumn:
        return os << season_translations[loc.name()][Season::autumn];
    case Season::winter:
        return os << season_translations[loc.name()][Season::winter];
    default:
        cerr << "operator<< case missing\n";
        exit(2);
    }
}

istream& operator>>(istream& is, Season& s) {
    locale loc {""}; // user locale
    if (season_translations.find(loc.name()) == season_translations.end())
        loc = locale(); // C locale

    string input;
    is >> input;

    bool found = false;
    for (auto it = season_translations[loc.name()].begin(); it != season_translations[loc.name()].end(); ++it) {
        if (it->second == input) {
            found = true;
            s = it->first;
        }
    }

    if (!found)
        is.setstate(ios::failbit);

    return is;
}

Season& operator++(Season& s) {
    switch (s) {
    case Season::spring:
        return s = Season::summer;
    case Season::summer:
        return s = Season::autumn;
    case Season::autumn:
        return s = Season::winter;
    case Season::winter:
        return s = Season::summer;
    default:
        cerr << "operator++ case missing\n";
        exit(2);
    }
}

Season operator++(Season& s, int) {
    Season old {s};
    ++s;
    return old;
}

Season& operator--(Season& s) {
    switch (s) {
    case Season::spring:
        return s = Season::winter;
    case Season::summer:
        return s = Season::spring;
    case Season::autumn:
        return s = Season::summer;
    case Season::winter:
        return s = Season::autumn;
    default:
        cerr << "operator-- case missing\n";
        exit(2);
    }
}

Season operator--(Season& s, int) {
    Season old {s};
    --s;
    return old;
}

int main(int argc, char** argv) {
    if (argc < 3) {
        fprintf(stderr, "Usage: %s <io|incpre|incpost|decpre|decpost> season\n", argv[0]);
        exit(1);
    }

    vector<string> args;
    for (int i = 0; i < argc; ++i)
        args.emplace_back(argv[i]);

    Season s {};
    stringstream ss {args[2]};
    if (!(ss >> s)) {
        cerr << "bad input\n";
        exit(1);
    }

    if (args[1] == "io") {
        // tested above with stringstream
        cout << s << '\n';
    } else if (args[1] == "incpre") {
        cout << ++s << '\n';
    } else if (args[1] == "incpost") {
        cout << s++ << ' ';
        cout << s << '\n';
    } else if (args[1] == "decpre") {
        cout << --s << '\n';
    } else if (args[1] == "decpost") {
        cout << s-- << ' ';
        cout << s << '\n';
    } else {
        fprintf(stderr, "Usage: %s <in|out|incpre|incpost|decpre|decpost>\n", argv[0]);
        exit(1);
    }

    return 0;
}
