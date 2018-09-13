execute_process(
    COMMAND ${CMAKE_COMMAND} -E tar xzf ${CMAKE_CURRENT_SOURCE_DIR}/tests.tar.gz
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

if(${TEST_RUNNER} STREQUAL "valgrind")
    set(
        RUNNER_COMMAND
        "valgrind" "--leak-check=full" "--dsymutil=yes" "--error-exitcode=125"
        "--suppressions=${CMAKE_CURRENT_SOURCE_DIR}/valgrind.supp"
    )
elseif(${TEST_RUNNER} STREQUAL "wine")
    set(RUNNER_COMMAND "wine")
elseif(${TEST_RUNNER} STREQUAL "node")
    set(RUNNER_COMMAND "node")
else()
    set(RUNNER_COMMAND "")
endif()

function(inchi_test _name_ _args_)
    add_test(NAME ${_name_}
        COMMAND ${RUNNER_COMMAND} ${CMAKE_CURRENT_BINARY_DIR}/inchi-1
            InChI_TestSet.sdf ${_name_}.txt ${_name_}.log
            NUL -AuxNone -NoLabels ${_args_}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
    )
endfunction()

inchi_test("its-std-01" "-Key")
inchi_test("its-std-02" "-NEWPSOFF")
inchi_test("its-std-03" "-SNon -Key")
inchi_test("its-std-04" "-DoNotAddH")
inchi_test("its-std-05" "-SNon -DoNotAddH")

inchi_test("its-non-std-01" "-SUU -SLUUD")
inchi_test("its-non-std-02" "-SRel -Key")
inchi_test("its-non-std-03" "-SRac")
inchi_test("its-non-std-04" "-SUU -SLUUD -SUCF")
inchi_test("its-non-std-05" "-NEWPSOFF -SRel")
inchi_test("its-non-std-06" "-NEWPSOFF -SRac")
inchi_test("its-non-std-07" "-NEWPSOFF -SLUUD -SUCF")
inchi_test("its-non-std-08" "-FixedH -Key")
inchi_test("its-non-std-09" "-NEWPSOFF -FixedH")
inchi_test("its-non-std-10" "-FixedH -SNon")
inchi_test("its-non-std-11" "-FixedH -SRel")
inchi_test("its-non-std-12" "-RecMet -Key")
inchi_test("its-non-std-13" "-NEWPSOFF -RecMet")
inchi_test("its-non-std-14" "-RecMet -SNon")
inchi_test("its-non-std-15" "-RecMet -SRel")
inchi_test("its-non-std-16" "-FixedH -RecMet -Key")
inchi_test("its-non-std-17" "-NEWPSOFF -FixedH -RecMet")
inchi_test("its-non-std-18" "-FixedH -RecMet -SNon")
inchi_test("its-non-std-19" "-FixedH -RecMet -SRel")
inchi_test("its-non-std-20" "-KET -Key")
inchi_test("its-non-std-21" "-KET -SNon")
inchi_test("its-non-std-22" "-KET -SRel")
inchi_test("its-non-std-23" "-15T -Key")
inchi_test("its-non-std-24" "-15T -SNon")
inchi_test("its-non-std-25" "-15T -SRel")
inchi_test("its-non-std-26" "-KET -15T")
inchi_test("its-non-std-27" "-NEWPSOFF -KET -15T -Key")
inchi_test("its-non-std-28" "-NEWPSOFF -KET -15T -SUU -SLUUD")
