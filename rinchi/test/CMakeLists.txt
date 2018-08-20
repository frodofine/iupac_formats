add_executable( rinchi_test_suite
    test_suite/rinchi_test_suite.cpp
    test_suite/tests/Cambridge_data_tests.cpp
    test_suite/tests/molfile_reader_tests.cpp
    test_suite/tests/rdfile_tests.cpp
    test_suite/tests/reaction_tests.cpp
    test_suite/tests/rinchi_reader_tests.cpp
    test_suite/tests/rxnfile_tests.cpp
    test_suite/tests/special_atoms_tests.cpp
    $<TARGET_OBJECTS:InChi_objects>
    $<TARGET_OBJECTS:RInChi_objects>
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
    NAME rinichi_test_suite
    COMMAND ${CMAKE_CURRENT_BINARY_DIR}/rinchi_test_suite
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)
