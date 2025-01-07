# Directory Tree Structure

## Simulation Source Files/Project Folder

Run the following to prepare the project folder.

```bash
git clone git@github.com:jeksterslab/manCTMed.git
mv manCTMed "/scratch/ibp5092"
chmod -R 777 "/scratch/ibp5092/manCTMed"
```

## Simulation Scripts

The simulation scripts are in the following folder.

```bash
"/scratch/ibp5092/manCTMed/.sim"
```

> **NOTE**: Build or request for `manctmed.sif` and place it in `"/scratch/ibp5092/manCTMed/.sif"`.

[comment]: <> (The manctmed.sif used is in https://osf.io/5d43c/)

Run the following for `manctmed.sif` to be executable and accessible to anyone.

```bash
chmod 777 /scratch/ibp5092/manCTMed/.sif/manctmed.sif
```

# Scripts to Run in the HPC Cluster

## Simulation

Run the following to run the simulations.

```bash
cd /scratch/ibp5092/manCTMed/.sim
sbatch sim.sh
```

## Summary

Run the following to summarize the results.

```bash
cd /scratch/ibp5092/manCTMed/.sim
sbatch sum-hit.sh
sbatch sum-raw.sh
```
