set(subdir_list "")
list(APPEND subdir_list "06-types-declarations")
list(APPEND subdir_list "07-pointers-arrays-references")
list(APPEND subdir_list "08-structures-unions-enumerations")
list(APPEND subdir_list "09-statements")
list(APPEND subdir_list "10-expressions")
if (BUILD_MISC)
    list(APPEND subdir_list "99-misc")
endif ()

foreach (dir ${subdir_list})
    add_subdirectory(${dir})

    if (SANITIZE_ADDRESS OR SANITIZE_MEMORY OR SANITIZE_THREAD OR SANITIZE_UNDEFINED)
        get_directory_property(targets DIRECTORY ${dir} BUILDSYSTEM_TARGETS)
        add_sanitizers(${targets})
    endif ()
endforeach ()
