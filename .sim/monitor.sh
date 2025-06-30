#! /bin/bash

cd /scratch/ibp5092/manCTMed/.sim
watch 'squeue -u ibp5092 ; for i in *.out ; do tail -1 "$i" ; done ; grep "check" *.out ; cat *.err'
