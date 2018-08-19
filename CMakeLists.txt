project(iupac_types)
cmake_minimum_required(VERSION 3.5)

option(RINCHI_TESTING "Build tests" ON)

if (${RINCHI_TESTING})
    find_package( Boost COMPONENTS filesystem system)
    enable_testing()
endif()

add_subdirectory(inchi)
add_subdirectory(rinchi)
