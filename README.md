Here shall reside the exercises from "The C++ Programming Language" by Stroustrup,
ISBN 9780321958327.

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

## Building solutions

To build all targets in parallel (except tests):

```
cmake -H. -Bbuild -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build build -- -j
```

Each exercise solution has its target.  
Each chapter (consisting of solutions) has its target.  

Chapter targets naming scheme: `%chapter_number%-%chapter-name%`.  
Solution targets naming scheme: `%chapter-target-name%_%target-name%`.  

## Testing solutions

To run all tests in parallel (including building required targets in parallel):
```
cmake -H. -Bbuild -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_TESTING=1
cmake --build build -- -j run-tests
```

Tests are labeled (`ctest -L`):
* each solution target has its label
* each chapter target has its label

Testing targets naming scheme: `test_%solution-target-name%`.

Other test targets:
* `run-tests-seq` (run tests sequentially)
* `rerun-failed-tests` (rerun only failed tests)
* `rerun-failed-tests-seq` (rerun only failed tests sequentially)

Don't be afaraid to run tests in parallel: read the label summary.  

Tested on OpenSUSE Tumbleweed.
