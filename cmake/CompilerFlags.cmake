include(CheckCXXCompilerFlag)
include(CheckCCompilerFlag)

set(CMAKE_REQUIRED_QUIET YES)

macro(add_warning_flag _flag_)
    string(REPLACE "++" "xx" _cleaned_flag_ ${_flag_})
    CHECK_CXX_COMPILER_FLAG("${_flag_}" CXX_SUPPORTS${_cleaned_flag_})
    CHECK_C_COMPILER_FLAG("${_flag_}" CC_SUPPORTS${_cleaned_flag_})
    if(CXX_SUPPORTS${_cleaned_flag_})
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${_flag_}")
    endif()

    if(CC_SUPPORTS${_cleaned_flag_})
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${_flag_}")
    endif()
endmacro()

macro(remove_msvc_warning _warn_)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd${_warn_}")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /wd${_warn_}")
endmacro()

if(${SUPPRESS_WARNINGS})
    if(MSVC)
        # Suppress potential MSVC warnings
    else()
        add_warning_flag("-Wno-parentheses")
        add_warning_flag("-Wno-logical-op-parentheses")
        add_warning_flag("-Wno-comment")
        add_warning_flag("-Wno-pointer-bool-conversion")
        add_warning_flag("-Wno-deprecated-declarations")
    endif()
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
