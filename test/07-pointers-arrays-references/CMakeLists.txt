set(TC++PL_TARGET_NAME 07-pointers-arrays-references)
set(TC++PL_TEST_TARGET_NAME ${TC++PL_TEST_TARGET_NAME}_${TC++PL_TARGET_NAME})

tcpppl_add_shell_driven_test(notwice 5)
tcpppl_add_shell_driven_test(find_substring 3)
