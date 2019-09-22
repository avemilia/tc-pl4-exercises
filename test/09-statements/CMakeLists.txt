set(TC++PL_TARGET_NAME 09-statements)
set(TC++PL_TEST_TARGET_NAME ${TC++PL_TEST_TARGET_NAME}_${TC++PL_TARGET_NAME})

tcpppl_add_shell_driven_test(atoi 25)
tcpppl_add_shell_driven_test(itoa 21)
