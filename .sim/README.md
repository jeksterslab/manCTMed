# Directory Tree Structure

## Simulation Source Files/Project Folder

Run the following to prepare the project folder.

```bash
git clone git@github.com:jeksterslab/manCTMed.git
mv manCTMed "/scratch/ibp5092"
chmod -R 777 "/scratch/ibp5092/manCTMed"
```

## Simulation Temporary Folder

Run the following to prepare the temporary folder.

```bash
mkdir -p "/scratch/ibp5092/manCTMed/.sim/tmp"
chmod 777 "/scratch/ibp5092/manCTMed/.sim/tmp"
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

In order to save the output files in the `"/scratch/ibp5092/manCTMed/.sim"` directory, make sure that `$PWD` is equal to `"/scratch/ibp5092/manCTMed/.sim"`.

# Scripts to Run in the HPC Cluster

## Simulation

Run the following to run the simulations.

```bash
cd /scratch/ibp5092/manCTMed/.sim
sbatch sim.sh
```

> **NOTE**: You have a couple of options for adjusting the number of nodes requested:
>
> *Flexible Node Requests:* Modify the script so that the number of nodes requested can be dynamically changed. This way, you can easily adjust the resource allocation based on your specific needs.
>
> *Multiple Instances with Varying Sample Sizes:* Alternatively, consider running multiple copies of the `sim.sh` script, each with different sample sizes (`n`). By doing so, you avoid having all sample sizes in a single script and requesting a separate node for each simulation.

## Summary

Run the following to summarize the results.

```bash
cd /scratch/ibp5092/manCTMed/.sim
sbatch sum.sh
```
