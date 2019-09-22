set(TC++PL_TARGET_NAME 09-statements)

add_executable(${TC++PL_TARGET_NAME}_atoi atoi.cc)
target_link_libraries(${TC++PL_TARGET_NAME}_atoi PRIVATE m)
add_executable(${TC++PL_TARGET_NAME}_itoa itoa.cc)
target_link_libraries(${TC++PL_TARGET_NAME}_itoa PRIVATE m)
