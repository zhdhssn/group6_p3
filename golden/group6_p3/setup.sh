#!/bin/bash

#Change UVMF_HOME variable's value to the local UVMF_2023.4_2's absolute path
# For absolute path > go to UVMF_2023.4_2 dir on local machine > run cmd "pwd" > copy and paste the path for UVMF_HOME

export UVMF_HOME=/mnt/apps/public/COE/mg_apps/questa2025.1_1/questasim/examples/UVM_Framework/UVMF_2023.4_2/
export PYTHONPATH=$UVMF_HOME/templates/python:$PYTHONPATH
export QUESTA_HOME=/mnt/apps/public/COE/mg_apps/questa2025.1_1/questasim
