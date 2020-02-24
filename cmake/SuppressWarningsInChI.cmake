include(CheckCXXCompilerFlag)
include(CheckCCompilerFlag)

function(add_warning_flag _flag_ _target_ _lang_)
    string(REPLACE "++" "xx" _cleaned_flag_ ${_flag_})
    CHECK_CXX_COMPILER_FLAG("${_flag_}" CXX_SUPPORTS${_cleaned_flag_})
    CHECK_C_COMPILER_FLAG("${_flag_}" CC_SUPPORTS${_cleaned_flag_})
    if(CXX_SUPPORTS${_cleaned_flag_} AND ${_lang_} STREQUAL "C")
        target_compile_options(${_target_} PRIVATE ${_flag_})
    endif()

    if(CC_SUPPORTS${_cleaned_flag_} AND ${_lang_} STREQUAL "CXX")
        target_compile_options(${_target_} PRIVATE ${_flag_})
    endif()
endfunction()

function(remove_msvc_warning _target_ _flag_)
    target_compile_options(${_target_} PRIVATE ${_flag_})
endfunction()

function(suppress_warnings _target_ _lang_)
    if(${SUPPRESS_WARNINGS})
        if(MSVC)
            # Suppress potential MSVC warnings
        else()
            add_warning_flag("-Wno-parentheses" ${_target_} ${_lang_})
            add_warning_flag("-Wno-logical-op-parentheses" ${_target_} ${_lang_})
            add_warning_flag("-Wno-comment" ${_target_} ${_lang_} )
            add_warning_flag("-Wno-pointer-bool-conversion" ${_target_} ${_lang_})
            add_warning_flag("-Wno-deprecated-declarations" ${_target_} ${_lang_})
            add_warning_flag("-Wno-unsequenced" ${_target_} ${_lang_})
            add_warning_flag("-Wno-constant-logical-operand" ${_target_} ${_lang_})
            add_warning_flag("-Wno-sizeof-pointer-memaccess" ${_target_} ${_lang_})
            add_warning_flag("-Wno-switch" ${_target_} ${_lang_})
            add_warning_flag("-Wno-main-return-type" ${_target_} ${_lang_})
        endif()
    endif()
endfunction()

if(${EMSCRIPTEN})
    if(${INCHI_BUILD_SHARED})
        # Shared libs where not tested and a lot of changes to the build system
        # for emscripten support disable things that are needed for shared libs
        # on Windows.
        message(WARNING "Shared libs are not supported with emscripten")
    endif()

    if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_SOURCE_DIR})
        set(EMCC_FLAGS "")
        set(EMCC_FLAGS "${EMCC_FLAGS} -s DISABLE_EXCEPTION_CATCHING=0")
        set(EMCC_FLAGS "${EMCC_FLAGS} -s LINKABLE=1")
        set(EMCC_FLAGS "${EMCC_FLAGS} -s ERROR_ON_UNDEFINED_SYMBOLS=1")

        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${EMCC_FLAGS}")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${EMCC_FLAGS}")
    endif()
endif()
