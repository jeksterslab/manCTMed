#! /bin/bash
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --mem 0
#SBATCH --time=2-00:00:00
#SBATCH --output=make.out
#SBATCH --error=make.err

# make

#cd /scratch/ibp5092/manCTMed
#apptainer exec /scratch/ibp5092/manCTMed/.sif/manctmed.sif make all

# remake

cd /scratch/ibp5092/manCTMed
apptainer exec /scratch/ibp5092/manCTMed/.sif/manctmed.sif make all
cp /scratch/ibp5092/manCTMed/vignettes/*.png /scratch/ibp5092/manCTMed/.setup/latex/figures/png
apptainer exec /scratch/ibp5092/manCTMed/.sif/manctmed.sif make auto

