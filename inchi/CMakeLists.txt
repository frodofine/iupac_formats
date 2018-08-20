 set(inchi_base
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

set(inchi_api
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

add_library(Inchi OBJECT
      ${inchi_base}
      ${inchi_api}
)

target_include_directories(Inchi PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/INCHI_BASE/)
target_compile_definitions(Inchi PUBLIC TARGET_API_LIB)

add_executable(inchi-1
      ${inchi_base}
      INCHI_EXE/dispstru.c
      INCHI_EXE/ichimain.c
)

target_include_directories(inchi-1 PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/INCHI_BASE/)
target_compile_definitions(inchi-1 PUBLIC TARGET_EXE_STANDALONE COMPILE_ANSI_ONLY)
target_link_libraries(inchi-1 m)

if (CMAKE_CXX_COMPILER_ID MATCHES "Clang")
      set_target_properties(Inchi PROPERTIES COMPILE_FLAGS "-Wno-parentheses -Wno-logical-op-parentheses")
      set_target_properties(inchi-1 PROPERTIES COMPILE_FLAGS "-Wno-parentheses -Wno-logical-op-parentheses")
endif()

if (${INCHI_TESTING})

      execute_process(
            COMMAND ${CMAKE_COMMAND} -E tar xzf ${CMAKE_CURRENT_SOURCE_DIR}/tests.tar.gz
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      )

      add_test(
            NAME inchi_std_01
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-std-01.txt its-std-01.log NUL -AuxNone -NoLabels -Key
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_std_02
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-std-02.txt its-std-02.log NUL -AuxNone -NoLabels -NEWPSOFF
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )
      
      add_test(
            NAME inchi_std_03
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-std-03.txt its-std-03.log NUL -AuxNone -NoLabels -SNon -Key
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_std_04
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-std-04.txt its-std-04.log NUL -AuxNone -NoLabels -DoNotAddH
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_std_05
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-std-05.txt its-std-05.log NUL -AuxNone -NoLabels -SNon -DoNotAddH
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_01
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-01.txt its-non-std-01.log NUL -AuxNone -NoLabels -SUU -SLUUD
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_02
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-02.txt its-non-std-02.log NUL -AuxNone -NoLabels -SRel -Key
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_03
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-03.txt its-non-std-03.log NUL -AuxNone -NoLabels -SRac
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_04
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-04.txt its-non-std-04.log NUL -AuxNone -NoLabels -SUU -SLUUD -SUCF
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_05
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-05.txt its-non-std-05.log NUL -AuxNone -NoLabels -NEWPSOFF -SRel
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_06
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-06.txt its-non-std-06.log NUL -AuxNone -NoLabels -NEWPSOFF -SRac
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_07
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-07.txt its-non-std-07.log NUL -AuxNone -NoLabels -NEWPSOFF -SLUUD -SUCF
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_08
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-08.txt its-non-std-08.log NUL -AuxNone -NoLabels -FixedH -Key
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_09
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-09.txt its-non-std-09.log NUL -AuxNone -NoLabels -NEWPSOFF -FixedH
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )
 
      add_test(
            NAME inchi_nstd_10
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-10.txt its-non-std-10.log NUL -AuxNone -NoLabels -FixedH -SNon
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_11
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-11.txt its-non-std-11.log NUL -AuxNone -NoLabels -FixedH -SRel
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_12
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-12.txt its-non-std-12.log NUL -AuxNone -NoLabels -RecMet -Key
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_13
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-13.txt its-non-std-13.log NUL -AuxNone -NoLabels -NEWPSOFF -RecMet
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )
 
      add_test(
            NAME inchi_nstd_14
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-14.txt its-non-std-14.log NUL -AuxNone -NoLabels -RecMet -SNon
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_15
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-15.txt its-non-std-15.log NUL -AuxNone -NoLabels -RecMet -SRel
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_16
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-16.txt its-non-std-16.log NUL -AuxNone -NoLabels -FixedH -RecMet -Key
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_17
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-17.txt its-non-std-17.log NUL -AuxNone -NoLabels -NEWPSOFF -FixedH -RecMet
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )
 
      add_test(
            NAME inchi_nstd_18
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-18.txt its-non-std-18.log NUL -AuxNone -NoLabels -FixedH -RecMet -SNon
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_19
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-19.txt its-non-std-19.log NUL -AuxNone -NoLabels -FixedH -RecMet -SRel
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_20
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-20.txt its-non-std-20.log NUL -AuxNone -NoLabels -KET -Key
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_21
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-21.txt its-non-std-21.log NUL -AuxNone -NoLabels -KET -SNon
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_22
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-22.txt its-non-std-22.log NUL -AuxNone -NoLabels -KET -SRel
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_23
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-23.txt its-non-std-23.log NUL -AuxNone -NoLabels -15T -Key
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_24
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-24.txt its-non-std-24.log NUL -AuxNone -NoLabels -15T -SNon
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_25
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-25.txt its-non-std-25.log NUL -AuxNone -NoLabels -15T -SRel
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_26
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-26.txt its-non-std-26.log NUL -AuxNone -NoLabels -KET -15T
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_27
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-27.txt its-non-std-27.log NUL -AuxNone -NoLabels -NEWPSOFF -KET -15T -Key
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )

      add_test(
            NAME inchi_nstd_28
            COMMAND ${CMAKE_CURRENT_BINARY_DIR}/inchi-1 InChI_TestSet.sdf its-non-std-28.txt its-non-std-28.log NUL -AuxNone -NoLabels -NEWPSOFF -KET -15T -SUU -SLUUD
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
      )
endif()
