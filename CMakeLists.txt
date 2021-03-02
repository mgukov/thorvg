cmake_minimum_required(VERSION 3.8)

project(thorvg VERSION 0.1)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(Utils)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

find_package(Threads REQUIRED)


include_directories(
        src/loaders/raw
        src/loaders/svg
        src/lib/sw_engine
        src/lib/gl_engine
        src/lib
        inc
)

set_compiled_files("${PROJECT_SOURCE_DIR}/src" INCLUDED_FILES)
print_compiled_files("thorvg" "${INCLUDED_FILES}")

add_library(thorvg ${INCLUDED_FILES})

set_target_properties(thorvg PROPERTIES DEFINE_SYMBOL THORVG_BUILD )

#declare version of the target
set(player_version_major 0)
set(player_version_minor 2)
set(player_version ${player_version_major}.${player_version_minor})
set_target_properties(thorvg PROPERTIES
        VERSION    ${player_version}
        SOVERSION  ${player_version_major}
        )

add_library(thorvg::thorvg ALIAS thorvg)

target_link_libraries(
        thorvg
        Threads::Threads
)


CONFIGURE_FILE(pc/${PROJECT_NAME}.pc.in ${PROJECT_NAME}.pc)
INSTALL(FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.pc DESTINATION ${LIB_INSTALL_DIR}/pkgconfig)


#install header
install(FILES
        inc/config.h
        inc/thorvg.h
        inc/thorvg_capi.h
        DESTINATION include)

#install lib
install( TARGETS thorvg EXPORT thorvg-targets
        LIBRARY     DESTINATION    ${LIB_INSTALL_DIR}
        ARCHIVE     DESTINATION    ${LIB_INSTALL_DIR}
        INCLUDES    DESTINATION    include
        )

#install config file.

install( EXPORT thorvg-targets
        FILE          thorvgTargets.cmake
        NAMESPACE     thorvg::
        DESTINATION   ${LIB_INSTALL_DIR}/cmake/thorvg
        )


#Create a ConfigVersion.cmake file
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
        ${CMAKE_CURRENT_BINARY_DIR}/thorvgConfigVersion.cmake
        VERSION ${PROJECT_VERSION}
        COMPATIBILITY AnyNewerVersion
)

configure_package_config_file(${CMAKE_CURRENT_LIST_DIR}/cmake/thorvgConfig.cmake.in
        ${CMAKE_CURRENT_BINARY_DIR}/thorvgConfig.cmake
        INSTALL_DESTINATION ${LIB_INSTALL_DIR}/cmake/thorvg
        )

#Install the config, configversion and custom find modules
install(FILES
        ${CMAKE_CURRENT_BINARY_DIR}/thorvgConfig.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/thorvgConfigVersion.cmake
        DESTINATION ${LIB_INSTALL_DIR}/cmake/thorvg
        )


export(EXPORT thorvg-targets FILE ${CMAKE_CURRENT_BINARY_DIR}/thorvgTargets.cmake NAMESPACE thorvg::)

#Register package in user's package registry
export(PACKAGE thorvg)