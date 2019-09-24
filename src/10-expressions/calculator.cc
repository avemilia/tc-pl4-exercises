// Type in the calculator example and get it to work. Do not "save time" by
// using an already entered text. You'll learn most from finding and correcting
// "little silly errors."
//
// Modify the calculator to report line numbers for errors.
//
// Allow a user to define functions in the calculator. Hint: Define a function
// as a sequence of operations just as a user would have typed them. Such a
// sequence can be stored either as a character string or as a list of tokens.
// Then read and execute those operations when the func- tion is called. If you
// want a user-defined function to take arguments, you will have to invent a
// notation for that.

#include <iostream>
#include <sstream>
#include <string>
#include <map>
#include <cctype>

using namespace std;

int no_of_errors;

double error(const string& s) {
    no_of_errors++;
    cerr << "error: " << s << '\n';
    return 1;
}

enum class Kind : char {
    name, number, end,
    plus = '+', minus = '-', mul = '*', div = '/', print = ';', assign = '=', lp = '(', rp = ')'
};

struct Token {
    Kind kind;
    string string_value;
    double number_value;
};

class Token_stream {
public:
    Token_stream(istream& s) : ip {&s}, owns {false} {}
    Token_stream(istream* p) : ip {p}, owns {true} {}

    ~Token_stream() { close(); }

    Token get();
    const Token& current() { return ct; }

    void set_input(istream& s) {
        close();
        ip = &s;
        owns = false;
    }

    void set_input(istream* sp) {
        close();
        ip = sp;
        owns = true;
    }

private:
    void close() { if (owns) delete ip; }

    istream* ip;
    bool owns;
    Token ct {Kind::end, {}, {}};
};

Token Token_stream::get() {
    char ch;

    do { // skip whitespace except newline
        if (!ip->get(ch)) return ct = {Kind::end, {}, {}};
    } while (ch != '\n' && isspace(ch));

    switch (ch) {
    case EOF:
        return ct = {Kind::end, {}, {}};
    case ';':
    case '\n':
        return ct = {Kind::print, {}, {}};
    case '0':
    case '1':
    case '2':
    case '3':
    case '4':
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
    case '.':
        ip->putback(ch);
        *ip >> ct.number_value;
        ct.kind = Kind::number;
        return ct;
    case '*':
    case '/':
    case '+':
    case '-':
    case '(':
    case ')':
    case '=':
        return ct = {static_cast<Kind>(ch), {}, {}};
    default: // name, name= or error
        if (isalpha(ch)) {
            ct.string_value = ch;
            while (ip->get(ch))
                if (isalnum(ch))
                    ct.string_value += ch;
                else {
                    ip->putback(ch);
                    break;
                }
            ct.kind = Kind::name;
            return ct;
        }

        error("bad token");
        return ct = {Kind::print, {}, {}};
    }
}

Token_stream ts {cin};

map<string, double> table;

double expr(bool);

// handle primaries
double prim(bool get) {
    if (get) ts.get();

    switch (ts.current().kind) {
    case Kind::number: {
        double v = ts.current().number_value;
        ts.get();
        return v;
    }
    case Kind::name: {
        double& v = table[ts.current().string_value];
        if (ts.get().kind == Kind::assign) v = expr(true);
        return v;
    }
    case Kind::minus:
        return -prim(true);
    case Kind::lp: {
        auto e = expr(true);
        if (ts.current().kind != Kind::rp) return error("')' expected");
        ts.get(); // eat ')'
        return e;
    }
    default:
        return error("primary expected");
    }
}

// multiply and divide
double term(bool get) {
    double left = prim(get);

    while (true) {
        switch (ts.current().kind) {
        case Kind::mul:
            left *= prim(true);
            break;
        case Kind::div:
            if (auto d = prim(true)) {
                left /= d;
                break;
            }
            return error("divide by 0");
        default:
            return left;
        }
    }
}

// add and subtract
double expr(bool get) {
    double left = term(get);

    while (true) {
        switch (ts.current().kind) {
        case Kind::plus:
            left += term(true);
            break;
        case Kind::minus:
            left -= term(true);
            break;
        default:
            return left;
        }
    }
}

void calculate() {
    while (true) {
        ts.get();
        if (ts.current().kind == Kind::end) break;
        if (ts.current().kind == Kind::print) continue;
        cout << expr(false) << '\n';
    }
}

int main(int argc, char** argv) {
    switch (argc) {
    case 1: // cin
        break;
    case 2:
        ts.set_input(new istringstream {argv[1]});
        break;
    default:
        error("too many arguments");
        return 1;
    }

    table["pi"] = 3.1415926535897932385;
    table["e"] = 2.7182818284590452354;

    calculate();

    return no_of_errors;
}
