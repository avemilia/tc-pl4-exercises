set(TC++PL_TARGET_NAME ${TC++PL_TARGET_NAME}_numeric-limits)

add_executable(${TC++PL_TARGET_NAME} main.cc)
target_include_directories(${TC++PL_TARGET_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

