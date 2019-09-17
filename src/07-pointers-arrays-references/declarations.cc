// Write declarations for the following: a pointer to a character, an array of
// 10 integers, a reference to an array of 10 integers, a pointer to an array
// of character strings, a pointer to a pointer to a character, a constant
// integer, a pointer to a constant integer, and a constant pointer to an
// integer. Initialize each one.

int main() {
    char* pc {};
    int arri[10] {};
    int (& rarri)[10] {arri};
    char* (* arrcc)[] {};
    char** ppc {};
    const int ci {};
    const int* pci {};
    int* const cpi {};

    return 0;
}
