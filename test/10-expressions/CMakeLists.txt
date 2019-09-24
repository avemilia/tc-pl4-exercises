set(TC++PL_TARGET_NAME 10-expressions)
set(TC++PL_TEST_TARGET_NAME ${TC++PL_TEST_TARGET_NAME}_${TC++PL_TARGET_NAME})

tcpppl_add_shell_driven_test(calculator 1)
