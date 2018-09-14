project(iupac_types)
cmake_minimum_required(VERSION 3.5)

option(INCHI_BUILD_SHARED "Build InChI shared library" OFF)
option(INCHI_BUILD_EXE "Build inchi-1 program" OFF)
option(INCHI_DEMOS "Build InChI demos" OFF)
option(INCHI_TESTING "Build InChI tests" OFF)

option(RINCHI_TESTING "Build RInChI tests" OFF)

option(TEST_RUNNER "Run the tests with a debugging utility" "None")

add_subdirectory(inchi)
add_subdirectory(rinchi)
