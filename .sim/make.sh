#! /bin/bash
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --mem 0
#SBATCH --time=2-00:00:00
#SBATCH --output=make.out
#SBATCH --error=make.err

# Define project variables
PROJECT=/scratch/$USER/github/manCTMed
SIF=/scratch/$USER/sif/docs.sif

# Directory

cd ${PROJECT} || exit

# Clean

rm -rf ${PROJECT}/.setup/data-raw/fit-example-*.Rds
rm -rf ${PROJECT}/.setup/data-raw/ci-example-*.Rds
rm -rf ${PROJECT}/.setup/data-raw/delta-example-*.Rds
rm -rf ${PROJECT}/.setup/data-raw/mc-example-*.Rds
rm -rf ${PROJECT}/.setup/data-raw/pb-bc-example-*.Rds
rm -rf ${PROJECT}/.setup/data-raw/pb-pc-example-*.Rds
rm -rf ${PROJECT}/.setup/data-raw/med-example-*.Rds
rm -rf ${PROJECT}/.setup/data-raw/example-*.Rds
rm -rf ${PROJECT}/.setup/data-raw/pb_replication_*.Rds
rm -rf ${PROJECT}/.setup/data-raw/illustration_pb_*.RDs
rm -rf ${PROJECT}/.setup/latex/figures/png/*.png
rm -rf ${PROJECT}/.setup/latex/figures/pdf/*.pdf

# make

apptainer exec ${SIF} make all

# remake

cd ${PROJECT} || exit
cp ${PROJECT}/vignettes/*.png ${PROJECT}/.setup/latex/figures/png
apptainer exec ${SIF} make all
# apptainer exec ${SIF} make auto
