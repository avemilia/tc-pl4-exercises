set(TC++PL_TARGET_NAME 07-pointers-arrays-references)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_executable(${TC++PL_TARGET_NAME}_declarations declarations.cc)
add_executable(${TC++PL_TARGET_NAME}_alias alias.cc)
add_executable(${TC++PL_TARGET_NAME}_notwice notwice.cc)
