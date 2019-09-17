set(TC++PL_TARGET_NAME 07-pointers-arrays-references)
set(TC++PL_TEST_TARGET_NAME test_07-pointers-arrays-references)

add_custom_command(OUTPUT "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${TC++PL_TEST_TARGET_NAME}_notwice.sh"
        COMMAND ${CMAKE_COMMAND} -E copy    "${CMAKE_CURRENT_SOURCE_DIR}/notwice.sh"
                                            "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${TC++PL_TEST_TARGET_NAME}_notwice.sh"
        DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/notwice.sh"
                ${TC++PL_TARGET_NAME}_notwice
        COMMENT "Copying ${TC++PL_TEST_TARGET_NAME}_notwice.sh")
add_custom_target(${TC++PL_TEST_TARGET_NAME}_notwice ALL
        DEPENDS "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${TC++PL_TEST_TARGET_NAME}_notwice.sh")

add_test(NAME ${TC++PL_TEST_TARGET_NAME}_notwice
        COMMAND ${BASH_PROGRAM} ${TC++PL_TEST_TARGET_NAME}_notwice.sh
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR})
