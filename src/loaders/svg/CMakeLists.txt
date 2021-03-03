
set_compiled_files("${CMAKE_CURRENT_LIST_DIR}" INCLUDED_FILES)
print_compiled_files(${CMAKE_CURRENT_LIST_DIR} "${INCLUDED_FILES}")

target_sources(tvgcanvas
        PRIVATE
        ${INCLUDED_FILES}
        )

target_include_directories(tvgcanvas
        PRIVATE
        "${CMAKE_CURRENT_LIST_DIR}"
        )
