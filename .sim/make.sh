#! /bin/bash
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --mem 0
#SBATCH --time=2-00:00:00
#SBATCH --output=make.out
#SBATCH --error=make.err

cp /scratch/ibp5092/sif/docs.sif /scratch/ibp5092/manCTMed/.sif
rm /scratch/ibp5092/manCTMed/.setup/latex/figures/png/*.png

cd /scratch/ibp5092/manCTMed
apptainer exec /scratch/ibp5092/manCTMed/.sif/docs.sif make all

# remake

cd /scratch/ibp5092/manCTMed
cp /scratch/ibp5092/manCTMed/vignettes/*.png /scratch/ibp5092/manCTMed/.setup/latex/figures/png
apptainer exec /scratch/ibp5092/manCTMed/.sif/docs.sif make all
apptainer exec /scratch/ibp5092/manCTMed/.sif/docs.sif make auto

