project(iupac_types C CXX)
cmake_minimum_required(VERSION  2.8.12)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${PROJECT_SOURCE_DIR}/cmake")

option(INCHI_BUILD_SHARED "Build InChI shared library" OFF)
option(INCHI_BUILD_EXE "Build inchi-1 program" OFF)
option(INCHI_DEMOS "Build InChI demos" OFF)
option(INCHI_TESTING "Build InChI tests" OFF)

option(RINCHI_TESTING "Build RInChI tests" OFF)

option(TEST_RUNNER "Run the tests with a debugging utility" "None")
option(SUPPRESS_WARNINGS "Suppress warnings from modern compilers" ON)

if (${INCHI_TESTING} OR ${RINCHI_TESTING})
    enable_testing()
endif()

if (POLICY CMP0063)
    # Use of `<LANG>_VISIBILITY_PRESET` in OBJECT libraries
    cmake_policy(SET CMP0063 NEW)
endif()

include(SuppressWarningsInChI)

add_subdirectory(inchi)
add_subdirectory(rinchi)
