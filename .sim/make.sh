#! /bin/bash
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --mem 0
#SBATCH --time=2-00:00:00
#SBATCH --output=make.out
#SBATCH --error=make.err

# define project variables
PROJECT=/scratch/$USER/manCTMed
SIF=/scratch/$USER/manCTMed/.sif/manctmed.sif

# build sif

if [ ! -f ${SIF} ]; then
    apptainer pull ${SIF} docker://ijapesigan/manctmed:2025-04-07-05390291
fi

# clean

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
rm -rf ${PROJECT}/vignettes/*.png
rm -rf ${PROJECT}/vignettes/containers.Rmd
rm -rf ${PROJECT}/vignettes/fig-example-1.Rmd
rm -rf ${PROJECT}/vignettes/fig-example-2.Rmd
rm -rf ${PROJECT}/vignettes/fig-example-3.Rmd
rm -rf ${PROJECT}/vignettes/fig-sampling-distribution.Rmd
rm -rf ${PROJECT}/vignettes/fig-scatter-plots-illustration.Rmd
rm -rf ${PROJECT}/vignettes/fig-scatter-plots-neg.Rmd
rm -rf ${PROJECT}/vignettes/fig-scatter-plots-pos.Rmd
rm -rf ${PROJECT}/vignettes/fig-scatter-plots-zero.Rmd
rm -rf ${PROJECT}/vignettes/replication.Rmd
rm -rf ${PROJECT}/vignettes/session.Rmd

# make

cd ${PROJECT} || exit
apptainer exec ${SIF} make all

# remake

cd ${PROJECT} || exit
cp ${PROJECT}/vignettes/*.png ${PROJECT}/.setup/latex/figures/png
apptainer exec ${SIF} make all

# push

cd ${PROJECT} || exit
apptainer exec ${SIF} make auto
