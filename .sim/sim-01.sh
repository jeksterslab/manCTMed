#!/bin/bash

#SBATCH --job-name=sim-01
#SBATCH --mail-user=r.jeksterslab@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --mem=0
#SBATCH --time=2-00:00:00
#SBATCH --output=/scratch/ibp5092/manCTMed/.sim/sim-01.out
#SBATCH --error=/scratch/ibp5092/manCTMed/.sim/sim-01.err

# load parallel module ---------------------------------------------------------
module load parallel

# pre TMP ----------------------------------------------------------------------
mkdir -p /scratch/ibp5092/manCTMed/.sim/tmp
TODAY=$(date +"%Y-%m-%d-%H%M")
PARALLEL_TMP_FOLDER=$(mktemp -d -q "/scratch/ibp5092/manCTMed/.sim/tmp/$TODAY-p-XXXXXXXX")
trap 'rm -rf -- "$PARALLEL_TMP_FOLDER"' EXIT
# ------------------------------------------------------------------------------

# script -----------------------------------------------------------------------
# {1} = repid
# {2} = taskid
cd /scratch/ibp5092/manCTMed
parallel                                                      \
        --tmpdir "$PARALLEL_TMP_FOLDER"                       \
        'apptainer exec                                       \
        /scratch/ibp5092/manCTMed/.sim/manctmed.sif           \
        Rscript /scratch/ibp5092/manCTMed/.sim/sim.R {1} 1;   \
        echo simulation repid {1} taskid 1'                   \
        ::: $(seq 1 1000)
parallel                                                      \
        --tmpdir "$PARALLEL_TMP_FOLDER"                       \
        'apptainer exec                                       \
        /scratch/ibp5092/manCTMed/.sim/manctmed.sif           \
        Rscript /scratch/ibp5092/manCTMed/.sim/sim.R {1} 1;   \
        echo simulation repid {1} taskid 1'                   \
        ::: $(seq 1000 -1 1)
parallel                                                      \
        --tmpdir "$PARALLEL_TMP_FOLDER"                       \
        'apptainer exec                                       \
        /scratch/ibp5092/manCTMed/.sim/manctmed.sif           \
        Rscript /scratch/ibp5092/manCTMed/.sim/sim.R {1} 4;   \
        echo simulation repid {1} taskid 4'                   \
        ::: $(seq 1000 -1 1)
parallel                                                      \
        --tmpdir "$PARALLEL_TMP_FOLDER"                       \
        'apptainer exec                                       \
        /scratch/ibp5092/manCTMed/.sim/manctmed.sif           \
        Rscript /scratch/ibp5092/manCTMed/.sim/sim.R {1} 4;   \
        echo simulation repid {1} taskid 4'                   \
        ::: $(seq 1 1000)
echo "sim-01.sh done"
# ------------------------------------------------------------------------------

# post TMP ---------------------------------------------------------------------
rm -rf -- "$PARALLEL_TMP_FOLDER"
trap - EXIT
exit
# ------------------------------------------------------------------------------
