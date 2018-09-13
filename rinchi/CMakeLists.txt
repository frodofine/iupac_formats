set( rinchi_includes
    ${PROJECT_SOURCE_DIR}/inchi/INCHI_BASE/
    ${CMAKE_CURRENT_SOURCE_DIR}/lib
    ${CMAKE_CURRENT_SOURCE_DIR}/rinchi
    ${CMAKE_CURRENT_SOURCE_DIR}/parsers
    ${CMAKE_CURRENT_SOURCE_DIR}/writers
)

add_library( RInChI_objects OBJECT
    lib/rinchi_utils.cpp
    lib/rinchi_hashing.cpp
    lib/rinchi_logger.cpp
    lib/inchi_api_intf.cpp
    lib/inchi_generator.cpp
    parsers/mdl_molfile.cpp
    parsers/mdl_molfile_reader.cpp
    parsers/mdl_rxnfile_reader.cpp
    parsers/mdl_rdfile_reader.cpp
    parsers/rinchi_reader.cpp
    writers/mdl_rxnfile_writer.cpp
    writers/mdl_rdfile_writer.cpp
    rinchi/rinchi_reaction.cpp
    rinchi/rinchi_consts.cpp
    rinchi_lib/rinchi_lib.cpp
)

target_include_directories( RInChI_objects PRIVATE ${rinchi_includes})

if (${RINCHI_TESTING})
    target_compile_definitions(RInChI_objects PRIVATE IN_RINCHI_TEST_SUITE=1)
endif()

add_executable( rinchi_cmdline
    apps/rinchi_cmdline.cpp
    $<TARGET_OBJECTS:InChI_objects>
    $<TARGET_OBJECTS:RInChI_objects>
)

target_include_directories( rinchi_cmdline
    PRIVATE
    ${rinchi_includes}
)

add_executable( rxn_from_molfiles
    apps/rxn_from_molfiles.cpp
    $<TARGET_OBJECTS:InChI_objects>
    $<TARGET_OBJECTS:RInChI_objects>
)

target_include_directories( rxn_from_molfiles
    PRIVATE
    ${rinchi_includes}
)

if (${RINCHI_TESTING})
    enable_testing()
    add_subdirectory(test)
endif()
