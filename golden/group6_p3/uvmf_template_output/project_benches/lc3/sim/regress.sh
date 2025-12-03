#!/bin/bash
# Regression test script for LC3 verification environment
# Executes test suite and generates unified coverage reports

# Setup environment
ml questa

# Clean previous simulation artifacts
make clean
rm -rf transcripts
mkdir -p transcripts

# Test execution configuration
SIMULATOR="questa"
VERBOSITY="UVM_LOW"
VIS_UVM_FLAG="True"
TRLOG_FLAG="False"

# Execute test cases with unique seeds
echo "Running test_top..."
python3.9 $UVMF_HOME/scripts/uvmf_bcr.py $SIMULATOR test:test_top \
    verbosity:$VERBOSITY "use_vis_uvm:$VIS_UVM_FLAG" "enable_trlog:$TRLOG_FLAG" "seed:847293"
cp run.log transcripts/top_transcript

echo "Running alu_test..."
python3.9 $UVMF_HOME/scripts/uvmf_bcr.py $SIMULATOR test:alu_test \
    verbosity:$VERBOSITY "use_vis_uvm:$VIS_UVM_FLAG" "enable_trlog:$TRLOG_FLAG" "seed:562841"
cp run.log transcripts/alu_transcript

echo "Running control_test..."
python3.9 $UVMF_HOME/scripts/uvmf_bcr.py $SIMULATOR test:control_test \
    verbosity:$VERBOSITY "use_vis_uvm:$VIS_UVM_FLAG" "enable_trlog:$TRLOG_FLAG" "seed:391728"
cp run.log transcripts/contrl_transcript

echo "Running mem_test..."
python3.9 $UVMF_HOME/scripts/uvmf_bcr.py $SIMULATOR test:mem_test \
    verbosity:$VERBOSITY "use_vis_uvm:$VIS_UVM_FLAG" "enable_trlog:$TRLOG_FLAG" "seed:284567"
cp run.log transcripts/mem_transcript

echo "Running misc_test..."
python3.9 $UVMF_HOME/scripts/uvmf_bcr.py $SIMULATOR test:misc_test \
    verbosity:$VERBOSITY "use_vis_uvm:$VIS_UVM_FLAG" "enable_trlog:$TRLOG_FLAG" "seed:675432"
cp run.log transcripts/misc_transcript

echo "Running ldr_str_coverage..."
python3.9 $UVMF_HOME/scripts/uvmf_bcr.py $SIMULATOR test:ldr_str_coverage \
    verbosity:$VERBOSITY ucdb_filename:ldr_str_coverage_1.ucdb \
    "use_vis_uvm:$VIS_UVM_FLAG" "enable_trlog:$TRLOG_FLAG" "seed:847293"
cp run.log transcripts/ldr_str_coverage_transcript

# Process test plan and generate coverage database
echo "Converting test plan to UCDB format..."
xml2ucdb -format Excel ./testplan.xml ./testplan.ucdb

# Merge all coverage databases into single report
echo "Merging coverage databases..."
vcover merge -stats=none -strip 0 -totals sim_and_testplan_merged.ucdb ./*.ucdb

# Display coverage results
echo "Launching coverage visualizer..."
visualizer -viewcov ./sim_and_testplan_merged.ucdb
