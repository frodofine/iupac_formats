 set(InChI_base
    INCHI_BASE/ichi_bns.c
    INCHI_BASE/ichi_io.c
    INCHI_BASE/ichican2.c
    INCHI_BASE/ichicano.c
    INCHI_BASE/ichicans.c
    INCHI_BASE/ichierr.c
    INCHI_BASE/ichiisot.c
    INCHI_BASE/ichimak2.c
    INCHI_BASE/ichimake.c
    INCHI_BASE/ichimap1.c
    INCHI_BASE/ichimap2.c
    INCHI_BASE/ichimap4.c
    INCHI_BASE/ichinorm.c
    INCHI_BASE/ichiparm.c
    INCHI_BASE/ichiprt1.c
    INCHI_BASE/ichiprt2.c
    INCHI_BASE/ichiprt3.c
    INCHI_BASE/ichiqueu.c
    INCHI_BASE/ichiread.c
    INCHI_BASE/ichiring.c
    INCHI_BASE/ichirvr1.c
    INCHI_BASE/ichirvr2.c
    INCHI_BASE/ichirvr3.c
    INCHI_BASE/ichirvr4.c
    INCHI_BASE/ichirvr5.c
    INCHI_BASE/ichirvr6.c
    INCHI_BASE/ichirvr7.c
    INCHI_BASE/ichisort.c
    INCHI_BASE/ichister.c
    INCHI_BASE/ichitaut.c
    INCHI_BASE/ikey_base26.c
    INCHI_BASE/ikey_dll.c
    INCHI_BASE/mol2atom.c
    INCHI_BASE/mol_fmt1.c
    INCHI_BASE/mol_fmt2.c
    INCHI_BASE/mol_fmt3.c
    INCHI_BASE/mol_fmt4.c
    INCHI_BASE/readinch.c
    INCHI_BASE/runichi.c
    INCHI_BASE/runichi2.c
    INCHI_BASE/runichi3.c
    INCHI_BASE/runichi4.c
    INCHI_BASE/sha2.c
    INCHI_BASE/strutil.c
    INCHI_BASE/util.c
 )

set(InChI_api
    INCHI_API/libinchi/src/ichilnct.c
    INCHI_API/libinchi/src/inchi_dll.c
    INCHI_API/libinchi/src/inchi_dll_a.c
    INCHI_API/libinchi/src/inchi_dll_a2.c
    INCHI_API/libinchi/src/inchi_dll_b.c
    INCHI_API/libinchi/src/inchi_dll_main.c
    INCHI_API/libinchi/ixa/ixa_builder.c
    INCHI_API/libinchi/ixa/ixa_inchikey_builder.c
    INCHI_API/libinchi/ixa/ixa_mol.c
    INCHI_API/libinchi/ixa/ixa_read_inchi.c
    INCHI_API/libinchi/ixa/ixa_read_mol.c
    INCHI_API/libinchi/ixa/ixa_status.c
)

add_library(InChI_objects OBJECT
    ${InChI_base}
    ${InChI_api}
)

target_include_directories(InChI_objects PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/INCHI_BASE/)
target_compile_definitions(InChI_objects PUBLIC TARGET_API_LIB)

if (${INCHI_BUILD_EXE} OR ${INCHI_TESTING})

    add_executable(inchi-1
        ${InChI_base}
        INCHI_EXE/dispstru.c
        INCHI_EXE/ichimain.c
    )

    target_include_directories(inchi-1 PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/INCHI_BASE/)
    target_compile_definitions(inchi-1 PUBLIC TARGET_EXE_STANDALONE COMPILE_ANSI_ONLY)

    if (NOT MSVC)
        target_link_libraries(inchi-1 m)
    endif()
endif()

if (${INCHI_BUILD_SHARED} OR (${INCHI_DEMOS} OR ${RINCHI_TESTING}))

    if (MSVC)
        add_library(inchi SHARED
            ${InChI_base}
            ${InChI_api}
           INCHI_API/libinchi/libinchi.def
        )
    else()
        add_library(inchi SHARED
            ${InChI_base}
            ${InChI_api}
        )

        target_link_libraries(inchi m)
    endif()
    target_compile_definitions(inchi PUBLIC BUILD_LINK_AS_DLL TARGET_API_LIB)
    target_compile_definitions(inchi PRIVATE _USRDLL)
    target_include_directories(inchi PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/INCHI_BASE/)
endif()

if (${INCHI_DEMOS})
    add_executable(mol2inchi
        INCHI_API/demos/mol2inchi/mol2inchi.c
        INCHI_API/demos/mol2inchi/moreutil.c
    )

    target_link_libraries(mol2inchi inchi)
    target_compile_definitions(mol2inchi PUBLIC TARGET_EXE_USING_API)
    target_include_directories(mol2inchi PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/INCHI_BASE/)

    add_executable(test_ixa
        INCHI_API/demos/test_ixa/test_ixa.c
        INCHI_API/demos/test_ixa/moreutil.c
    )

    target_link_libraries(test_ixa inchi)
    if (NOT MSVC)
        target_link_libraries(test_ixa inchi m)
    endif()
    target_compile_definitions(test_ixa PUBLIC TARGET_EXE_USING_API)
    target_include_directories(test_ixa PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/INCHI_BASE/)
endif()

if (${INCHI_TESTING})
    enable_testing()
    include(${CMAKE_CURRENT_SOURCE_DIR}/InChITests.cmake)
endif()
