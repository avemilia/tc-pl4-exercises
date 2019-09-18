set(TC++PL_TARGET_NAME 07-pointers-arrays-references)
set(TC++PL_TEST_TARGET_NAME ${TC++PL_TEST_TARGET_NAME}_${TC++PL_TARGET_NAME})

# notwice
set(base_name       "notwice")

set(src_dir_fname   "${base_name}.sh")
set(bin_dir_fname   "${TC++PL_TEST_TARGET_NAME}_${src_dir_fname}")
set(target_name     "${TC++PL_TEST_TARGET_NAME}_${base_name}")

add_custom_command(OUTPUT "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${bin_dir_fname}"
        COMMAND ${CMAKE_COMMAND} -E copy    "${CMAKE_CURRENT_SOURCE_DIR}/${src_dir_fname}"
                                            "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${bin_dir_fname}"
        DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/${src_dir_fname}"
        COMMENT "Copying ${src_dir_fname} -> ${bin_dir_fname}")
add_custom_target(${target_name}
        DEPENDS "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${bin_dir_fname}")

add_dependencies(${target_name} ${TC++PL_TARGET_NAME}_${base_name})
add_dependencies(build-tests ${target_name})

foreach (subtest_num RANGE 1 5)
    add_test(NAME ${target_name}_${subtest_num}
            COMMAND ${BASH_PROGRAM} ${bin_dir_fname} test_${subtest_num}
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR})
    set_tests_properties(${target_name}_${subtest_num} PROPERTIES
            LABELS "${TC++PL_TARGET_NAME}_${base_name};${TC++PL_TARGET_NAME}")
endforeach ()
