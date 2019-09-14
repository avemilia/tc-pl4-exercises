#include <cstdlib>
#include <signal.h>
#include <iostream>
#include <filesystem>
#include <fstream>
#include <boost/stacktrace.hpp>
#include <boost/exception/all.hpp>

void my_signal_handler(int signum) {
    ::signal(signum, SIG_DFL);
    boost::stacktrace::safe_dump_to("./backtrace.dump");
    ::raise(SIGABRT);
}

using traced = boost::error_info<struct tag_stacktrace, boost::stacktrace::stacktrace>;

template<class Exception>
void throw_with_trace(const Exception& e) {
    throw boost::enable_error_info(e) << traced{boost::stacktrace::stacktrace()};
}

namespace ns {
template<typename T, typename U>
void foo(T t, U u) {
//    std::cerr << "Backtrace:\n" << boost::stacktrace::stacktrace();
//    BOOST_ASSERT_MSG(!u, "u is false");
    if (u > 2)
        throw_with_trace(std::logic_error{"logic error"});
}
}  // namespace ns

template<typename T>
struct Klass {
    T t;

    void bar() {
        int tmp;
        std::cin >> tmp;
        ns::foo(t, tmp);
    }
};

namespace boost {
inline void
assertion_failed_msg(char const* expr, char const* msg, char const* function, char const* /*file*/, long /*line*/) {
    std::cerr << "Expression '" << expr << "' is false in function '" << function << "': " << (msg ? msg : "<...>")
              << ".\n"
              << "Backtrace:\n" << boost::stacktrace::stacktrace() << '\n';
    std::exit(EXIT_FAILURE);
}

inline void assertion_failed(char const* expr, char const* function, char const* file, long line) {
    ::boost::assertion_failed_msg(expr, 0 /*nullptr*/, function, file, line);
}
} // namespace boost

int main() {
    ::signal(SIGSEGV, &my_signal_handler);
    ::signal(SIGABRT, &my_signal_handler);

    if (std::filesystem::exists("./backtrace.dump")) {
        // there is a backtrace
        std::ifstream ifs("./backtrace.dump");

        boost::stacktrace::stacktrace st = boost::stacktrace::stacktrace::from_dump(ifs);
        std::cout << "Previous run crashed:\n" << st << std::endl;

        // cleaning up
        ifs.close();
        std::filesystem::remove("./backtrace.dump");
    }

    try {
        Klass<double> k;
        k.bar();
    } catch (const std::exception& e) {
        std::cerr << e.what() << '\n';
        const boost::stacktrace::stacktrace* st = boost::get_error_info<traced>(e);
        if (st)
            std::cerr << *st << '\n';
        else
            std::cerr << "No stack trace available.\n";
        std::exit(EXIT_FAILURE);
    }

    return 0;
}
