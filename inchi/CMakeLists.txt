 add_library(Inchi OBJECT
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

target_include_directories(Inchi PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/INCHI_BASE/)
target_compile_definitions(Inchi PUBLIC TARGET_API_LIB)

if (CMAKE_CXX_COMPILER_ID MATCHES "Clang")
      set_target_properties(Inchi PROPERTIES COMPILE_FLAGS "-Wno-parentheses -Wno-logical-op-parentheses")
endif()
