#!/bin/bash

#SBATCH --job-name=collate
#SBATCH --mail-user=r.jeksterslab@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --mem=0
#SBATCH --time=2-00:00:00
#SBATCH --output=/scratch/ibp5092/manCTMed/.sim/collate.out
#SBATCH --error=/scratch/ibp5092/manCTMed/.sim/collate.err

# script -----------------------------------------------------------------------
cd /scratch/ibp5092/manCTMed
apptainer exec                                                \
        /scratch/ibp5092/manCTMed/.sim/sif/manctmed.sif       \
        --bind /scratch/ibp5092/manCTMed                      \
        Rscript /scratch/ibp5092/manCTMed/.sim/collate.R          \
echo "collate.sh done"
# ------------------------------------------------------------------------------
