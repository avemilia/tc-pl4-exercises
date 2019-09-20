Here shall reside the selected set of exercises from "The C++ Programming
Language" by Stroustrup, ISBN 9780321958327.

Exercise descriptions are copied in translation units, so they are greppable.

## Repo layout

```
 src/ -- solutions, separated by chapters
    06-.../    --  solutions for chapter 6
    07-.../    --  solutions for chapter 7
    [...]
    99-misc/   --  miscellaneous snippets
test/ -- tests for solutions, same layout as src/
    common.sh  --  common testing utilities
```

## Configuring build

These options are available for setting:

```
% cmake -S . -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo -LH
[...]

// Path to a program.
BASH_PROGRAM:FILEPATH=/usr/bin/bash

// Enable src/99-misc
BUILD_MISC:BOOL=off

// Build shared (instead of static) libraries
BUILD_SHARED_LIBS:BOOL=on

// Build the testing tree.
BUILD_TESTING:BOOL=on

// Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel ...
CMAKE_BUILD_TYPE:STRING=RelWithDebInfo

// Install path prefix, prepended onto install directories.
CMAKE_INSTALL_PREFIX:PATH=/usr/local

// Additional ctest arguments for targets like 'run-tests'
CTEST_ARGS:STRING=

// Build with bounds-checking STL
WITH_BOUNDS_CHECKING_STL:BOOL=on
```

## Building solutions

To build all targets in parallel (except tests):
```
cmake -S . -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build build -- -j
```

To build a particular target:
```
cmake -S . -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build build -- -j target-name
```

Each exercise solution has its target.  
Each chapter (consisting of solutions) has its target.  

Chapter targets naming scheme: `%chapter_number%-%chapter-name%`.  
Solution targets naming scheme: `%chapter-target-name%_%target_name%`.  

## Testing solutions

To run all tests in parallel (including building required targets in parallel):
```
cmake -S . -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build build -- -j run-tests
```

To run a particular set of tests (e.g. all tests matching "foo"):
```
cmake -S . -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCTEST_ARGS="-R;foo"
cmake --build build -- -j run-tests
```

See `ctest(1)` man page for arguments that can be passed.

Tests are labeled (`ctest -L`):
* each solution target has its label
* each chapter target has its label

Testing targets naming scheme: `test_%solution-target-name%`.

Other test targets:
* `run-tests-seq` (run tests sequentially)
* `rerun-failed-tests` (rerun only failed tests)
* `rerun-failed-tests-seq` (rerun only failed tests sequentially)

> ___Tip:___
> Don't be afaraid to run tests in parallel: read the label summary.  

Tested on OpenSUSE Tumbleweed.
