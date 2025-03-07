#!/bin/bash

#SBATCH --job-name=sum-raw
#SBATCH --mail-user=r.jeksterslab@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --mem=0
#SBATCH --time=2-00:00:00
#SBATCH --output=/scratch/ibp5092/manCTMed/.sim/sum-raw.out
#SBATCH --error=/scratch/ibp5092/manCTMed/.sim/sum-raw.err

# script -----------------------------------------------------------------------
cd /scratch/ibp5092/manCTMed
apptainer exec                                            \
        /scratch/ibp5092/manCTMed/.sif/manctmed.sif       \
        Rscript /scratch/ibp5092/manCTMed/.sim/sum-raw.R  \
echo "sum-raw.sh done"
# ------------------------------------------------------------------------------
