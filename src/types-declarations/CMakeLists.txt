set(TC++PL_TARGET_NAME types-declarations)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

set(TC++PL_TARGET_NAME ${TC++PL_TARGET_NAME}_numeric-limits)
add_executable(${TC++PL_TARGET_NAME} numeric-limits.cc)

set(TC++PL_TARGET_NAME ${TC++PL_TARGET_NAME}_string-loop)
add_executable(${TC++PL_TARGET_NAME} string-loop.cc)
