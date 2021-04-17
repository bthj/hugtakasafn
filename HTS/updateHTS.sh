#!/bin/bash
SCRIPTS_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$SCRIPTS_DIR" ]]; then SCRIPTS_DIR="$PWD"; fi

eval $SCRIPTS_DIR/MTexportToHTSimport/MTexportToTABforImport.py

eval $SCRIPTS_DIR/MTexportToHTSimport/importFromTABfile.tcl
