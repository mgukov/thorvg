cmake_minimum_required(VERSION 3.8)

project(tvgcanvas VERSION 0.1)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(Utils)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

find_package(Threads REQUIRED)

option(TVG_GL_SUPPORT "Enable LOTTIE MODULE SUPPORT" OFF)

include_directories(
#        src/loaders/raw
#        src/loaders/svg
#        src/lib/sw_engine
#        src/lib/gl_engine
#        src/lib
        inc
)

add_library(tvgcanvas SHARED)
set_target_properties(tvgcanvas PROPERTIES DEFINE_SYMBOL TVGCANVAS_BUILD)

#declare version of the target
set(player_version_major 0)
set(player_version_minor 2)
set(player_version ${player_version_major}.${player_version_minor})
set_target_properties(tvgcanvas PROPERTIES
        VERSION    ${player_version}
        SOVERSION  ${player_version_major}
        )

add_library(tvgcanvas::tvgcanvas ALIAS tvgcanvas)

target_link_libraries(
        tvgcanvas
        Threads::Threads
)


add_subdirectory(src)

SET(PREFIX ${CMAKE_INSTALL_PREFIX})
SET(EXEC_DIR ${PREFIX})
SET(LIBDIR ${LIB_INSTALL_DIR})
SET(INCDIR ${PREFIX}/include)

CONFIGURE_FILE(pc/${PROJECT_NAME}.pc.in ${PROJECT_NAME}.pc)
INSTALL(FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.pc DESTINATION ${LIB_INSTALL_DIR}/pkgconfig)


#install header
install(FILES
        inc/tvgcanvas.h
        inc/tvgcanvas_capi.h
        DESTINATION include)

#install lib
install( TARGETS tvgcanvas EXPORT tvgcanvas-targets
        LIBRARY     DESTINATION    ${LIB_INSTALL_DIR}
        ARCHIVE     DESTINATION    ${LIB_INSTALL_DIR}
        INCLUDES    DESTINATION    include
        )

#install config file.

install( EXPORT tvgcanvas-targets
        FILE          tvgcanvasTargets.cmake
        NAMESPACE     tvgcanvas::
        DESTINATION   ${LIB_INSTALL_DIR}/cmake/tvgcanvas
        )


#Create a ConfigVersion.cmake file
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
        ${CMAKE_CURRENT_BINARY_DIR}/tvgcanvasConfigVersion.cmake
        VERSION ${PROJECT_VERSION}
        COMPATIBILITY AnyNewerVersion
)

configure_package_config_file(${CMAKE_CURRENT_LIST_DIR}/cmake/tvgcanvasConfig.cmake.in
        ${CMAKE_CURRENT_BINARY_DIR}/tvgcanvasConfig.cmake
        INSTALL_DESTINATION ${LIB_INSTALL_DIR}/cmake/tvgcanvas
        )

#Install the config, configversion and custom find modules
install(FILES
        ${CMAKE_CURRENT_BINARY_DIR}/tvgcanvasConfig.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/tvgcanvasConfigVersion.cmake
        DESTINATION ${LIB_INSTALL_DIR}/cmake/tvgcanvas
        )


export(EXPORT tvgcanvas-targets FILE ${CMAKE_CURRENT_BINARY_DIR}/tvgcanvasTargets.cmake NAMESPACE tvgcanvas::)

#Register package in user's package registry
export(PACKAGE tvgcanvas)