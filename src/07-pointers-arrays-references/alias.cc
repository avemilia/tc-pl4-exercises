//  Use an alias (using) to define the types unsigned char, const unsigned
//  char, pointer to integer, pointer to pointer to char, pointer to array of
//  char, array of 7 pointers to int, pointer to an array of 7 pointers to int,
//  and array of 8 arrays of 7 pointers to int.

using uc = unsigned char;
using cuc = const uc;
using pi = int*;
using ppc = char**;
using parrc = char (*)[];
using arri7 = int* [7];
using parri7 = int* (*)[7];
using arrarr8arri7 = int* [8][7];

int main() {
    return 0;
}
