cmake_minimum_required(VERSION 3.10)

project(libopaque NONE)

option(GNU_MAKE_PATH "Path to GNU make" "make")

message("Using make=${GNU_MAKE_PATH}")

# resolves to something like build/lib/libopaque.a
set(opaque_LIBRARY ${CMAKE_INSTALL_PREFIX}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}opaque${CMAKE_STATIC_LIBRARY_SUFFIX})

include(ExternalProject)
# do not overwrite CFLAGS if not debug build
set(opaque_CFLAGS "")

if(BUILD_TESTING)
    set(opaque_CFLAGS "CFLAGS=\"-g -O0\"")
endif()

# directories for output library and headers
make_directory(${CMAKE_CURRENT_BINARY_DIR}/lib)
make_directory(${CMAKE_CURRENT_BINARY_DIR}/bin)
make_directory(${CMAKE_CURRENT_BINARY_DIR}/include)

ExternalProject_Add(libopaque
GIT_REPOSITORY https://github.com/WorldofJARcraft/libopaque.git
GIT_TAG b0b4de757ad33b1ac1911e89fe9ffa8535e4658d
GIT_SUBMODULES "" # update all submodules
SOURCE_DIR        "${CMAKE_CURRENT_BINARY_DIR}/opaque-src"
BUILD_IN_SOURCE TRUE
CONFIGURE_COMMAND ""
BUILD_COMMAND ${GNU_MAKE_PATH} -C ${CMAKE_CURRENT_BINARY_DIR}/opaque-src/src PREFIX=${CMAKE_CURRENT_BINARY_DIR} ${opaque_CFLAGS}
INSTALL_COMMAND ${GNU_MAKE_PATH} -C ${CMAKE_CURRENT_BINARY_DIR}/opaque-src/src install PREFIX=${CMAKE_CURRENT_BINARY_DIR}
BUILD_BYPRODUCTS ${opaque_LIBRARY}
)