#!/bin/bash

export UVMF_HOME="/mnt/ncsudrive/a/ajoshi32/ECE_748/group6_p3/UVMF_2023.4_2"
export QUESTA_ROOT="/mnt/apps/public/COE/mg_apps/questa2025.1_1"

MERGE_SOURCE_DIR="/mnt/ncsudrive/a/ajoshi32/ECE_748/group6_p3/p3"

UVMF_SCRIPT="$UVMF_HOME/scripts/yaml2uvmf.py"

# Check if script exists
if [ ! -f "$UVMF_SCRIPT" ]; then
    echo "Error: UVMF script not found at $UVMF_SCRIPT"
    echo "Please check the UVMF_HOME path."
    exit 1
fi

echo "Generating UVMF code..."

/usr/bin/python3.11 "$UVMF_SCRIPT" \
  fetch_yaml_files/fetch_in.yaml \
  fetch_yaml_files/fetch_out.yaml \
  fetch_yaml_files/fetch_env.yaml \
  --merge_source "$MERGE_SOURCE_DIR"

echo "Done."
