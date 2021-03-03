
target_sources(tvgcanvas
        PRIVATE
        "${CMAKE_CURRENT_LIST_DIR}/capi/tvgCapi.cpp"
        )

target_include_directories(tvgcanvas
        PRIVATE
        "${CMAKE_CURRENT_LIST_DIR}/capi"
        )
