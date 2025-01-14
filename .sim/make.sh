#! /bin/bash
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --mem 0
#SBATCH --time=2-00:00:00
#SBATCH --output=make.out
#SBATCH --error=make.err

cp /scratch/ibp5092/sif/docs.sif /scratch/ibp5092/manCTMed_temp/.sif
# rm /scratch/ibp5092/manCTMed_temp/.setup/latex/figures/png/*.png

cd /scratch/ibp5092/manCTMed_temp
apptainer exec /scratch/ibp5092/manCTMed_temp/.sif/docs.sif make all

# remake

cp /scratch/ibp5092/manCTMed_temp/vignettes/*.png /scratch/ibp5092/manCTMed_temp/.setup/latex/figures/png
apptainer exec /scratch/ibp5092/manCTMed_temp/.sif/docs.sif make all
apptainer exec /scratch/ibp5092/manCTMed_temp/.sif/docs.sif make auto
