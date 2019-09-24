set(TC++PL_TARGET_NAME 10-expressions)

add_executable(${TC++PL_TARGET_NAME}_calculator calculator.cc)
target_link_libraries(${TC++PL_TARGET_NAME}_calculator PRIVATE m)
