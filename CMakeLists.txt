project(iupac_types)
cmake_minimum_required(VERSION 3.5)

option(INCHI_BUILD_SHARED "Build InChi shared library" ON)
option(INCHI_DEMOS "Build InChi demos" ON)
option(INCHI_TESTING "Build InChi tests" ON)

option(RINCHI_TESTING "Build RInChi tests" ON)

if (${RINCHI_TESTING})
    find_package( Boost COMPONENTS filesystem system)
    enable_testing()
endif()

add_subdirectory(inchi)
add_subdirectory(rinchi)
