# SPDX-License-Identifier: MIT

# macro used for tests which have .sh test driver
# it assumes a lot of things defined, and defined correctly, please don't use it
# it exists to save some copy-pasting, so it has only one very narrow application
macro (tcpppl_add_shell_driven_test base_name test_range_max)
    set(src_dir_fname   "${base_name}.sh")
    set(bin_dir_fname   "${TC++PL_TEST_TARGET_NAME}_${src_dir_fname}")
    set(target_name     "${TC++PL_TEST_TARGET_NAME}_${base_name}")
    add_custom_command(OUTPUT "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${bin_dir_fname}"
            COMMAND ${CMAKE_COMMAND} -E copy    "${CMAKE_CURRENT_SOURCE_DIR}/${src_dir_fname}"
                                                "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${bin_dir_fname}"
            DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/${src_dir_fname}"
            COMMENT "Copying: ${src_dir_fname} -> ${bin_dir_fname}")
    add_custom_target(${target_name}
            DEPENDS "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${bin_dir_fname}")
    add_dependencies(${target_name} ${TC++PL_TARGET_NAME}_${base_name})
    add_dependencies(build-tests ${target_name})
    foreach (subtest_num RANGE 1 ${test_range_max})
        add_test(NAME ${target_name}_${subtest_num}
                COMMAND ${BASH_PROGRAM} ${bin_dir_fname} test_${subtest_num}
                WORKING_DIRECTORY ${CMAKE_BINARY_DIR})
        set_tests_properties(${target_name}_${subtest_num} PROPERTIES
                LABELS "${TC++PL_TARGET_NAME}_${base_name};${TC++PL_TARGET_NAME}")
    endforeach ()
endmacro ()

# tcpppl_init_submodule : Initialize dependency stored as submodule
# ..sub_name : submodule name
# ..sub_path : where submodule is/will be stored
#
# This macro can (should) be called in top-level CMakeLists.txt right after
# cmake_minimum_required(). It does not need the state of the build system.
macro (tcpppl_init_submodule sub_name sub_path)
    if (NOT ${sub_name}_SUBMODULE_REVISION)
        # initialize submodule, if needed
        message(STATUS "Checking ${sub_name} submodule status")
        execute_process(COMMAND git submodule status ${sub_path}
#                WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
                OUTPUT_VARIABLE git_submodule_stdout
                RESULT_VARIABLE result)
        if (NOT ${result} EQUAL 0)
            message(FATAL_ERROR "execute_process: `git submodule status ${sub_path}` failed")
        endif ()
        # if the hash is prepended with '-', submodule is not initialized
        string(FIND "${git_submodule_stdout}" "-" position)
        if (${position} EQUAL 0)
            message(STATUS "Initializing ${sub_name} submodule")
            execute_process(COMMAND git submodule update --init ${sub_path}
#                    WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
                    RESULT_VARIABLE result)
            if (NOT ${result} EQUAL 0)
                message(FATAL_ERROR "execute_process: `git submodule update --init ${sub_path}` failed")
            endif ()
        endif ()

        # get precise submodule revision
        execute_process(COMMAND git submodule status ${sub_path}
#                WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
                OUTPUT_VARIABLE git_submodule_stdout
                RESULT_VARIABLE result)
        if (NOT ${result} EQUAL 0)
            message(FATAL_ERROR "execute_process: `git submodule status ${sub_path}` failed")
        endif ()
        string(STRIP "${git_submodule_stdout}" git_submodule_stdout)
        string(REPLACE " " ";" git_submodule_stdout_list "${git_submodule_stdout}")
        list(GET git_submodule_stdout_list -1 submodule_revision)
        string(REPLACE "(" "" submodule_revision "${submodule_revision}")
        string(REPLACE ")" "" submodule_revision "${submodule_revision}")
        # set cached var to not execute this on every reconfiguration
        set(${sub_name}_SUBMODULE_REVISION "${submodule_revision}"
                CACHE INTERNAL "${sub_name} submodule revision")
        message(STATUS "${sub_name} submodule revision: ${${sub_name}_SUBMODULE_REVISION}")
    endif ()
endmacro ()

# Set a default build type if none was specified
macro (set_default_build_type)
    set(default_build_type "Release")
    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/.git")
        set(default_build_type "RelWithDebInfo")
    endif()

    if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
        message(STATUS "Setting build type to '${default_build_type}' as none was specified.")
        set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE
                STRING "Choose the type of build." FORCE)
        # Set the possible values of build type for cmake-gui
        set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
                "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
    endif()
endmacro ()
