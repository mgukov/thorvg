
target_sources(tvgcanvas
        PRIVATE
        "${CMAKE_CURRENT_LIST_DIR}/tvgRawLoader.cpp"
        )

target_include_directories(tvgcanvas
        PRIVATE
        "${CMAKE_CURRENT_LIST_DIR}"
        )
