#!/bin/bash

eval MTexportToHTSimport/MTexportToTABforImport.py $1

eval MTexportToHTSimport/importFromTABfile.tcl
