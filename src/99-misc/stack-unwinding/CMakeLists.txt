set(TC++PL_TARGET_NAME ${TC++PL_TARGET_NAME}_stack-unwinding)

find_package(Boost REQUIRED COMPONENTS stacktrace_addr2line)

add_executable(${TC++PL_TARGET_NAME} main.cc)
target_include_directories(${TC++PL_TARGET_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_compile_definitions(${TC++PL_TARGET_NAME} PRIVATE
        BOOST_ALL_DYN_LINK
        BOOST_STACKTRACE_USE_ADDR2LINE
        BOOST_ENABLE_ASSERT_DEBUG_HANDLER) # for boost.assert stacktrace
target_link_libraries(${TC++PL_TARGET_NAME} PRIVATE
        Boost::headers
        Boost::stacktrace_addr2line
        ${CMAKE_DL_LIBS}) # for stacktrace
