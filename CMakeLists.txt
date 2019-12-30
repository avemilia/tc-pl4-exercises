cmake_minimum_required(VERSION 3.12) # for -j to use all cores, as per README

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(tcpppl-util)

# pre-configure submodules
set(submodules_dir "${CMAKE_CURRENT_SOURCE_DIR}/external")
foreach (submodule_name IN ITEMS "sanitizers-cmake")
    tcpppl_init_submodule(${submodule_name} "${submodules_dir}/${submodule_name}")
endforeach ()

project(tc++pl4-exercises LANGUAGES CXX)

# build configuration
set(WITH_BOUNDS_CHECKING_STL    on      CACHE BOOL      "Build with bounds-checking STL")
set(BUILD_SHARED_LIBS           on      CACHE BOOL      "Build shared (instead of static) libraries")
set(BUILD_TESTING               on      CACHE BOOL      "Enable tests")
set(BUILD_MISC                  off     CACHE BOOL      "Enable src/99-misc")
set(CTEST_ARGS                  ""      CACHE STRING    "Additional ctest arguments for targets like 'run-tests'")

set_default_build_type()
foreach (output_type IN ITEMS "RUNTIME" "ARCHIVE" "LIBRARY")
    set(CMAKE_${output_type}_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")
endforeach ()

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
    #		$< [[ if config is debug or relwithdebinfo ]]
    #			$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>
    #		 : [[ then ]]
    #			$< [[ if ]]
    #			    $<AND: [[ c++ and appleClang or clang ]]
    #					$<COMPILE_LANGUAGE:CXX>,
    #					$<OR:$<CXX_COMPILER_ID:AppleClang>,$<CXX_COMPILER_ID:Clang>>
    #			     >
    #			 : [[ then ]]
    #			    _LIBCPP_DEBUG=1
    #			 >
    #		 >
	add_compile_definitions($<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:$<$<AND:$<COMPILE_LANGUAGE:CXX>,$<OR:$<CXX_COMPILER_ID:AppleClang>,$<CXX_COMPILER_ID:Clang>>>:_LIBCPP_DEBUG=1>>)
    # same, but without second OR
    add_compile_definitions($<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:$<$<AND:$<COMPILE_LANGUAGE:CXX>,$<CXX_COMPILER_ID:GNU>>:_GLIBCXX_DEBUG>>)
endif ()

if (SANITIZE_ADDRESS OR SANITIZE_MEMORY OR SANITIZE_THREAD OR SANITIZE_UNDEFINED)
    list(APPEND CMAKE_MODULE_PATH "${submodules_dir}/sanitizers-cmake/cmake")
    find_package(Sanitizers REQUIRED)
endif ()

## add submodules as part of the build system
#foreach (submodule_name IN ITEMS "sanitizers-cmake")
#    add_subdirectory("${submodules_dir}/${submodule_name}" EXCLUDE_FROM_ALL)
#endforeach ()

add_subdirectory(src)

include(CTest)
if (BUILD_TESTING)
    add_subdirectory(test)
endif ()
