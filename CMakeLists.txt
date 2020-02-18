project(iupac_types)
cmake_minimum_required(VERSION  2.8.12)

option(INCHI_BUILD_SHARED "Build InChI shared library" OFF)
option(INCHI_BUILD_EXE "Build inchi-1 program" OFF)
option(INCHI_DEMOS "Build InChI demos" OFF)
option(INCHI_TESTING "Build InChI tests" OFF)

option(RINCHI_TESTING "Build RInChI tests" OFF)

option(TEST_RUNNER "Run the tests with a debugging utility" "None")

if (${INCHI_TESTING} OR ${RINCHI_TESTING})
    enable_testing()
endif()

if(${EMSCRIPTEN})
    if(${INCHI_BUILD_SHARED})
        # Shared libs where not tested and a lot of changes to the build system
        # for emscripten support disable things that are needed for shared libs
        # on Windows.
        message(WARNING "Shared libs are not supported with emscripten")
    endif()

    set(EMCC_FLAGS "")
    set(EMCC_FLAGS "${EMCC_FLAGS} -s DISABLE_EXCEPTION_CATCHING=0")
    set(EMCC_FLAGS "${EMCC_FLAGS} -s LINKABLE=1")
    set(EMCC_FLAGS "${EMCC_FLAGS} -s ERROR_ON_UNDEFINED_SYMBOLS=1")

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${EMCC_FLAGS}")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${EMCC_FLAGS}")
endif()

add_subdirectory(inchi)
add_subdirectory(rinchi)
