set(TC++PL_TARGET_NAME 99-misc)

add_subdirectory(stack-unwinding)

# other targets are one-file ones and are defined below

add_executable(${TC++PL_TARGET_NAME}_temporary temporary.cc)
