project(iupac_types)
cmake_minimum_required(VERSION 3.5)

option(INCHI_BUILD_SHARED "Build InChi shared library" OFF)
option(INCHI_DEMOS "Build InChi demos" OFF)
option(INCHI_TESTING "Build InChi tests" OFF)

option(RINCHI_TESTING "Build RInChi tests" OFF)

if (${RINCHI_TESTING})
    find_package( Boost COMPONENTS filesystem system REQUIRED)
    enable_testing()
endif()

add_subdirectory(inchi)
add_subdirectory(rinchi)
