#!/bin/bash


# set -euo pipefail

#Harry: Minimal regression script for running the LDR load instruction test
echo "Cleaning up previous test output..."
make clean

echo "cleaning up harry_test_output.txt..."
rm harry_test_output.txt

# echo "Running the LDR test..."
# make cli TEST_NAME=lc3_ldr_test UVM_VERBOSITY=UVM_HIGH >> harry_test_output.txt 

# //Harry: run the focused ADD test to mirror the golden_model flow
echo "Running the ALU ADD test..."
make cli TEST_NAME=lc3_alu_add_test UVM_CLI_ARGS="+UVM_VERBOSITY=UVM_HIGH" >> harry_test_output.txt


