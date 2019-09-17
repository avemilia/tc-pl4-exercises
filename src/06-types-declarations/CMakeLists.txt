set(TC++PL_TARGET_NAME 06-types-declarations)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_executable(${TC++PL_TARGET_NAME}_numeric-limits numeric-limits.cc)
add_executable(${TC++PL_TARGET_NAME}_string-loop string-loop.cc)
