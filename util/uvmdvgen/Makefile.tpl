${'####################################################################################################'}
${'## Copyright lowRISC contributors.                                                                ##'}
${'## Licensed under the Apache License, Version 2.0, see LICENSE for details.                       ##'}
${'## SPDX-License-Identifier: Apache-2.0                                                            ##'}
${'####################################################################################################'}
${'## Entry point test Makefile forr building and running tests.                                     ##'}
${'## These are generic set of option groups that apply to all testbenches.                          ##'}
${'## This flow requires the following options to be set:                                            ##'}
${'## DV_DIR       - current dv directory that contains the test Makefile                            ##'}
${'## DUT_TOP      - top level dut module name                                                       ##'}
${'## TB_TOP       - top level tb module name                                                        ##'}
${'## DOTF         - .f file used for compilation                                                    ##'}
${'## COMPILE_KEY  - compile option set                                                              ##'}
${'## TEST_NAME    - name of the test to run - this is supplied on the command line                  ##'}
${'####################################################################################################'}
DV_DIR          := ${'$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))'}
export DUT_TOP  := ${name}
export TB_TOP   := tb
FUSESOC_CORE    := lowrisc:dv:${name}_sim:0.1
COMPILE_KEY     ?= default

UVM_TEST        ?= ${name}_base_test
UVM_TEST_SEQ    ?= ${name}_base_vseq

${'####################################################################################################'}
${'##                     A D D    I N D I V I D U A L    T E S T S    B E L O W                     ##'}
${'####################################################################################################'}
TEST_NAME       ?= ${name}_sanity
UVM_TEST        ?= ${name}_base_test
UVM_TEST_SEQ    ?= ${name}_base_vseq

ifeq (${'$'}{TEST_NAME},${name}_sanity)
  UVM_TEST_SEQ   = ${name}_sanity_vseq
endif

ifeq (${'$'}{TEST_NAME},${name}_intr_test)
  UVM_TEST_SEQ   = ${name}_common_vseq
  RUN_OPTS      += +run_intr_test
endif

ifeq (${'$'}{TEST_NAME},${name}_csr_hw_reset)
  UVM_TEST_SEQ   = ${name}_common_vseq
  RUN_OPTS      += +csr_hw_reset
  RUN_OPTS      += +en_scb=0
endif

ifeq (${'$'}{TEST_NAME},${name}_csr_rw)
  UVM_TEST_SEQ   = ${name}_common_vseq
  RUN_OPTS      += +csr_rw
  RUN_OPTS      += +en_scb=0
endif

ifeq (${'$'}{TEST_NAME},${name}_csr_bit_bash)
  UVM_TEST_SEQ   = ${name}_common_vseq
  RUN_OPTS      += +csr_bit_bash
  RUN_OPTS      += +en_scb=0
endif

ifeq (${'$'}{TEST_NAME},${name}_csr_aliasing)
  UVM_TEST_SEQ   = ${name}_common_vseq
  RUN_OPTS      += +csr_aliasing
  RUN_OPTS      += +en_scb=0
endif

${'# TODO: remove this test if there are no memories in the DUT'}
  ifeq (${'$'}{TEST_NAME},${name}_mem_walk)
  UVM_TEST_SEQ   = ${name}_common_vseq
  RUN_OPTS      += +csr_mem_walk
  RUN_OPTS      += +en_scb=0
endif

${'####################################################################################################'}
${'## Include the tool Makefile below                                                                ##'}
${'## Dont add anything else below it!                                                               ##'}
${'####################################################################################################'}
include ${'$'}{DV_DIR}/../../../dv/tools/Makefile
