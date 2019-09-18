set(TC++PL_TEST_TARGET_NAME "test")

if (NOT BASH_PROGRAM)
    find_program(BASH_PROGRAM bash REQUIRED)
    if (BASH_PROGRAM_FOUND)
        message("Found Bash: ${BASH_PROGRAM}")
    endif ()
endif ()

# Custom targets to run all tests
add_custom_target(run-tests
        COMMAND ${CMAKE_CTEST_COMMAND} --output-on-failure
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
        COMMENT "Running all tests")

# Dependee for all test targets
add_custom_target(build-tests)

add_dependencies(run-tests build-tests)

# common.sh is a library used by all tests

set(base_name       "common")
set(src_dir_fname   "${base_name}.sh")
set(bin_dir_fname   "${TC++PL_TEST_TARGET_NAME}_${src_dir_fname}")
set(target_name     "${TC++PL_TEST_TARGET_NAME}_${base_name}")

add_custom_command(OUTPUT "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${bin_dir_fname}"
        COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/${src_dir_fname}"
                                         "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${bin_dir_fname}"
        DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/${src_dir_fname}"
        COMMENT "Copying: ${src_dir_fname} -> ${bin_dir_fname}")
add_custom_target(${target_name}
        DEPENDS "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${bin_dir_fname}")

add_dependencies(build-tests ${target_name})

set(TC++PL_COMMON_TEST_TARGET_NAME "${target_name}") # used in subdirectories

add_subdirectory(07-pointers-arrays-references)
