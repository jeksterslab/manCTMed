#!/bin/bash

#SBATCH --job-name=sim-04-grundy
#SBATCH --mail-user=r.jeksterslab@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --mem=0
#SBATCH --time=2-00:00:00
#SBATCH --output=/scratch/ibp5092/manCTMed/.sim/sim-04-grundy.out
#SBATCH --error=/scratch/ibp5092/manCTMed/.sim/sim-04-grundy.err

# load parallel module ---------------------------------------------------------
module load parallel

# pre TMP ----------------------------------------------------------------------
mkdir -p /scratch/ibp5092/manCTMed/.sim/tmp
TODAY=$(date +"%Y-%m-%d-%H-%M-%S-%N")
PARALLEL_TMP_FOLDER=$(mktemp -d -q "/scratch/ibp5092/manCTMed/.sim/tmp/$TODAY-sim-04-grundy-XXXXXXXX")
trap 'rm -rf -- "$PARALLEL_TMP_FOLDER"' EXIT
echo "PARALLEL_TMP_FOLDER is $PARALLEL_TMP_FOLDER"
# ------------------------------------------------------------------------------

# script -----------------------------------------------------------------------
# {1} = repid
cd /scratch/ibp5092/manCTMed
parallel                                                               \
        --tmpdir "$PARALLEL_TMP_FOLDER"                                \
        'apptainer exec                                                \
        /scratch/ibp5092/manCTMed/.sif/manctmed.sif                    \
        Rscript /scratch/ibp5092/manCTMed/.sim/sim-grundy.R {1} 1;     \
        echo sim taskid $(printf "%05d" 1) repid $(printf "%05d" {1})' \
        ::: $(seq 751 1000)
# ------------------------------------------------------------------------------

# done -------------------------------------------------------------------------
echo "sim-04-grundy.sh done"
# ------------------------------------------------------------------------------

# post TMP ---------------------------------------------------------------------
rm -rf -- "$PARALLEL_TMP_FOLDER"
trap - EXIT
exit
# ------------------------------------------------------------------------------
