#!/bin/bash

#SBATCH --job-name=i-sum
#SBATCH --mail-user=r.jeksterslab@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --mem=0
#SBATCH --time=2-00:00:00
#SBATCH --output=i-sum.out
#SBATCH --error=i-sum.err

# Define project variables
PROJECT=manCTMed
SIF=manctmed_2025-03-08-18472632.sif

# script -----------------------------------------------------------------------
cd /scratch/$USER/${PROJECT} || exit
apptainer exec \
     --bind /scratch/\$USER/${PROJECT}:/scratch/\$USER/${PROJECT} \
     /scratch/\$USER/${PROJECT}/.sif/${SIF} \
     Rscript /scratch/\$USER/${PROJECT}/.sim/illustration-sum.R 1
# ------------------------------------------------------------------------------

# done -------------------------------------------------------------------------
echo "illustration-sum.sh done"
# ------------------------------------------------------------------------------

# post TMP ---------------------------------------------------------------------
rm -rf -- "$PARALLEL_TMP_FOLDER"
trap - EXIT
exit
# ------------------------------------------------------------------------------
