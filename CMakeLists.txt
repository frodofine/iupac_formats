project(iupac_types)
cmake_minimum_required(VERSION 3.5)

option(INCHI_TESTING "Build InChi tests" ON)
option(RINCHI_TESTING "Build RInChi tests" ON)

if (${RINCHI_TESTING})
    find_package( Boost COMPONENTS filesystem system)
    enable_testing()
endif()

add_subdirectory(inchi)
add_subdirectory(rinchi)
