# Directory Tree Structure

## Simulation Source Files/Project Folder

Run the following to prepare the project folder.

```bash
PROJECT=manCTMed
git clone git@github.com:jeksterslab/$PROJECT.git
mv $PROJECT "/scratch/$USER"
chmod -R 777 "/scratch/$USER/$PROJECT"
```

## Simulation Scripts

The simulation scripts are in the following folder.

```bash
"/scratch/$USER/$PROJECT/.sim"
```

> **NOTE**: Build or request for `manctmed.sif` and place it in `"/scratch/$USER/$PROJECT/.sif"`.

[comment]: <> (The manctmed.sif used can be built using `apptainer pull manctmed.sif docker://ijapesigan/manctmed:2025-04-07-05390291`)

Run the following for `manctmed.sif` to be executable and accessible to anyone.

```bash
chmod 777 /scratch/$USER/$PROJECT/.sif/manctmed.sif
```

# Scripts to Run in the HPC Cluster

## Simulation

Run the following to run the simulations.

```bash
cd /scratch/$USER/$PROJECT/.sim
sbatch sim.sh
```

## Summary

Run the following to summarize the results.

```bash
cd /scratch/$USER/$PROJECT/.sim
sbatch sum.sh
```
