find_program(BASH_PROGRAM bash REQUIRED)

# put common.sh in bindir
set(base_name       "common")
set(src_dir_fname   "${base_name}.sh")
set(bin_dir_fname   "test_${src_dir_fname}")
set(target_name     "test_${base_name}")
add_custom_command(OUTPUT "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${bin_dir_fname}"
        COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_SOURCE_DIR}/${src_dir_fname}"
                                         "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${bin_dir_fname}"
        DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/${src_dir_fname}"
        COMMENT "Copying: ${src_dir_fname} -> ${bin_dir_fname}")
add_custom_target(${target_name} ALL
        DEPENDS "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${bin_dir_fname}")

set(TC++PL_COMMON_TEST_TARGET_NAME "${target_name}") # used in subdirectories

add_subdirectory(07-pointers-arrays-references)
