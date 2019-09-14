set(TC++PL_TARGET_NAME pointers-arrays-references)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

set(TC++PL_TARGET_NAME ${TC++PL_TARGET_NAME}_declarations)
add_executable(${TC++PL_TARGET_NAME} declarations.cc)

set(TC++PL_TARGET_NAME ${TC++PL_TARGET_NAME}_alias)
add_executable(${TC++PL_TARGET_NAME} alias.cc)
