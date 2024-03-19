#!/bin/bash

# pre TMP ----------------------------------------------------------------------
TODAY=$(date +"%Y-%m-%d-%H%M")
PARALLEL_TMP_FOLDER=$(mktemp -d -q "/storage/home/ibp5092/scratch/tmp/$TODAY-p-XXXXXXXX")
trap 'rm -rf -- "$PARALLEL_TMP_FOLDER"' EXIT
# ------------------------------------------------------------------------------

# script -----------------------------------------------------------------------
# {1} = n (sample size)
# {2} = i (replication number)
PROJECT_WD="/storage/home/ibp5092/scratch/manCTMed"
PROJECT_SIM_R="/storage/home/ibp5092/scratch/manCTMed/.sim/sim.R"
PROJECT_SIF="/storage/home/ibp5092/scratch/manCTMed/.sim/sif/manctmed.sif"

## -----------------------------------------------------------------------------
parallel \
        --tmpdir "$PARALLEL_TMP_FOLDER" \
        apptainer exec \
                --bind "$PROJECT_WD" \
                "$PROJECT_SIF" \
                'Rscript "$PROJECT_SIM_R" {2} {1} "$PROJECT_WD"; \
        echo sim rep {2} n {1} \
        ::: $(seq 50 50 200) \
        ::: $(seq 1000 1)

# post TMP ---------------------------------------------------------------------
rm -rf -- "$PARALLEL_TMP_FOLDER"
trap - EXIT
exit
# ------------------------------------------------------------------------------
