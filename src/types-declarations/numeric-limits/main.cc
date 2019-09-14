// What, on your system, are the largest and the smallest values of the
// following types: bool, char, short, int, long, long long, float, double,
// long double, unsigned and unsigned long?
//
// What are the sizes (in number of chars) of the types?
//
// What are the alignments (in number of chars) of the types?

#include <limits>
#include <iostream>

using namespace std;

int main() {
    cout << "Type\tmin()\tmax()\tsizeof\talignof\n"
         << "bool\t" << numeric_limits<bool>::min() << '\t' << numeric_limits<bool>::max() << '\t' << sizeof(bool) << '\t' << alignof(bool) << '\n'
         << "char\t" << +numeric_limits<char>::min() << '\t' << +numeric_limits<char>::max() << '\t' << sizeof(char) << '\t' << alignof(char) << '\n'
         << "short\t" << numeric_limits<short>::min() << '\t' << numeric_limits<short>::max() << '\t' << sizeof(short) << '\t' << alignof(short) << '\n'
         << "int\t" << numeric_limits<int>::min() << '\t' << numeric_limits<int>::max() << '\t' << sizeof(int) << '\t' << alignof(int) << '\n'
         << "long\t" << numeric_limits<long>::min() << '\t' << numeric_limits<long>::max() << '\t' << sizeof(long) << '\t' << alignof(long) << '\n'
         << "long long\t" << numeric_limits<long long>::min() << '\t' << numeric_limits<long long>::max() << '\t' << sizeof(long long) << '\t' << alignof(long long) << '\n'
         << "float\t" << numeric_limits<float>::min() << '\t' << numeric_limits<float>::max() << '\t' << sizeof(float) << '\t' << alignof(float) << '\n'
         << "double\t" << numeric_limits<double>::min() << '\t' << numeric_limits<double>::max() << '\t' << sizeof(double) << '\t' << alignof(double) << '\n'
         << "long double\t" << numeric_limits<long double>::min() << '\t' << numeric_limits<long double>::max() << '\t' << sizeof(long double) << '\t' << alignof(long double) << '\n'
         << "unsigned\t" << numeric_limits<unsigned>::min() << '\t' << numeric_limits<unsigned>::max() << '\t' << sizeof(unsigned) << '\t' << alignof(unsigned) << '\n'
         << "unsigned long\t" << numeric_limits<unsigned long>::min() << '\t' << numeric_limits<unsigned long>::max() << '\t' << sizeof(unsigned long) << '\t' << alignof(unsigned long)
         << '\n';

    return 0;
}
