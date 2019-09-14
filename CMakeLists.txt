cmake_minimum_required(VERSION 3.14) # whatever
project(tc++pl4-exercises LANGUAGES CXX)

option(WITH_BOUNDS_CHECKING_STL on)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}")

### Compile options and definitions
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS off)
set(CMAKE_CXX_FLAGS "-Wall -Wextra -Wno-unused-parameter")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O2 -g")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG")
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g")
# expose SUSv4 (POSIX.1-2008 + XSI) declarations
add_compile_definitions($<$<PLATFORM_ID:Linux>:_XOPEN_SOURCE=700>)
if (WITH_BOUNDS_CHECKING_STL)
    add_compile_definitions($<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:$<$<COMPILE_LANG_AND_ID:CXX,GNU>:_GLIBCXX_DEBUG>>)
    add_compile_definitions($<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:$<$<COMPILE_LANG_AND_ID:CXX,AppleClang,Clang>:_LIBCPP_DEBUG=1>>)
endif ()

add_subdirectory(src)
