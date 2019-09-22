## Corrections of mistakes/typos in exercises

### X.10.4

> Write a function atoi(const char∗) that takes a C-style string containing
> digits and returns the corresponding int. For example, atoi("123") is 123.
> Modify atoi() to handle C++ octal and hexadecimal notation in addition to
> plain decimal numbers. Modify atoi() to handle the C++ character constant
> notation.

There is no such term as "character constant notation". What is probably meant
is described in 6.2.3.2 as characted literal: \ooo for octal numbers (up to 3
digits) and \xhhh... for hexadecimal (inifite amount of digits).

### X.10.6

> Modify iota() from the previous exercise to take an extra "string length"
> argument to make overflow less likely.

s/iota/itoa
