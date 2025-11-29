#!/bin/bash


# set -euo pipefail

#Harry: Minimal regression script for running the LDR load instruction test
echo "Cleaning up previous test output..."
make clean
echo "cleaning up harry_test_output.txt..."
rm harry_test_output.txt
echo "Running the test..."
make cli TEST_NAME=lc3_ldr_test UVM_VERBOSITY=UVM_HIGH >> harry_test_output.txt 

