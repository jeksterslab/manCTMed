#!/bin/bash

# Upload the SIF to /scratch/ibp5092/manCTMed/.sim/sif/

# Change the permissions for manctmed.sif
chmod 777 /scratch/ibp5092/manCTMed/.sim/sif/manctmed.sif

# Prepare the tmp folder
mkdir -p /scratch/ibp5092/manCTMed/.sim/tmp
chmod -R 777 /scratch/ibp5092/manCTMed/.sim/tmp

# Change permission for all the files under .sim and manCTMed
chmod -R 777 /scratch/ibp5092/manCTMed/.sim
chmod -R 777 /scratch/ibp5092/manCTMed/

# Delete /scratch/ibp5092/manCTMed/.library to make sure the functions use the packages in the manctmed.sif
rm -rf /scratch/ibp5092/manCTMed/.library
