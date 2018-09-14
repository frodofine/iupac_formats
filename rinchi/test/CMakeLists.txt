if(${TEST_RUNNER} STREQUAL "valgrind")
    set(
        RUNNER_COMMAND
        "valgrind" "--leak-check=full" "--dsymutil=yes" "--error-exitcode=125"
        "--suppressions=${CMAKE_CURRENT_SOURCE_DIR}/valgrind.supp"
    )
elseif(${TEST_RUNNER} STREQUAL "wine")
    set(RUNNER_COMMAND "wine")
elseif(${TEST_RUNNER} STREQUAL "node")
    message(STATUS "Cannot run RInChI tests on Node")
    return()
else()
    set(RUNNER_COMMAND "")
endif()

set(Boost_USE_STATIC_LIBS ON)
find_package( Boost COMPONENTS filesystem system REQUIRED)

add_test(NAME example_test
    COMMAND ${RUNNER_COMMAND} ${CMAKE_CURRENT_BINARY_DIR}/../rxn_from_molfiles
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../apps/data
)

add_executable( rinchi_test_suite
    test_suite/rinchi_test_suite.cpp
    test_suite/tests/Cambridge_data_tests.cpp
    test_suite/tests/molfile_reader_tests.cpp
    test_suite/tests/rdfile_tests.cpp
    test_suite/tests/reaction_tests.cpp
    test_suite/tests/rinchi_reader_tests.cpp
    test_suite/tests/rxnfile_tests.cpp
    test_suite/tests/special_atoms_tests.cpp
    ../lib/unit_test.cpp
    $<TARGET_OBJECTS:InChI_objects>
    $<TARGET_OBJECTS:RInChI_objects>
)

execute_process(
    COMMAND ${CMAKE_COMMAND} -E tar xzf ${CMAKE_CURRENT_SOURCE_DIR}/test.tar.gz
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

target_compile_definitions( rinchi_test_suite
    PRIVATE IN_RINCHI_TEST_SUITE=1
)

target_include_directories( rinchi_test_suite
    PRIVATE ${rinchi_includes} test_suite/tests/
)

target_link_libraries( rinchi_test_suite
    Boost::filesystem
)

add_test(
    NAME rinchi_test_suite
    COMMAND ${RUNNER_COMMAND} ${CMAKE_CURRENT_BINARY_DIR}/rinchi_test_suite
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)
