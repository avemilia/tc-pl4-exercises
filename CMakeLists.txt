cmake_minimum_required(VERSION 3.12) # for -j to use all cores, as per README
project(tc++pl4-exercises LANGUAGES CXX)
include(CTest)

# build configuration
set(WITH_BOUNDS_CHECKING_STL on  CACHE BOOL "Build with bounds-checking STL")
set(BUILD_SHARED_LIBS        on  CACHE BOOL "Build shared (instead of static) libraries")
set(BUILD_TESTING            on  CACHE BOOL "Enable tests")
set(BUILD_MISC               off CACHE BOOL "Enable src/99-misc")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}")

### Compile options and definitions
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS off)
set(CMAKE_CXX_FLAGS "-Wall -Wextra -Wno-unused-parameter -Wno-unused-variable")
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

if (BUILD_TESTING)
    add_subdirectory(test)
endif ()
