#! /bin/bash
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --mem 0
#SBATCH --time=2-00:00:00
#SBATCH --output=make.out
#SBATCH --error=make.err

# Define project variables
PROJECT=manCTMed
SIF=manctmed.sif

# make

cd /scratch/$USER/overleaf/manCTMed-mar || exit
apptainer exec /scratch/$USER/${PROJECT}/.sif/${SIF} make all

# remake

cd /scratch/$USER/overleaf/manCTMed-mar || exit
cp /scratch/$USER/overleaf/manCTMed-mar/vignettes/*.png /scratch/$USER/overleaf/manCTMed-mar/.setup/latex/figures/png
apptainer exec /scratch/$USER/${PROJECT}/.sif/${SIF} make all
apptainer exec /scratch/$USER/${PROJECT}/.sif/${SIF} make auto
