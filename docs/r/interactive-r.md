---
layout: default
title: Interactive R
parent: R And Conda
nav_order: 4
---

# Using R interactively

## Rstudio

Currently, Rstudio is not available on open-source channels. If you want to use Rstudio with R in the installed Conda environment there are a few options:
- On a personal machine, use a locally installed Rstudio Desktop.
- On a cloud platform, use Rstudio Server, described here: [gce-startup](https://github.com/ctrhodes/gce-startup)
- On a cluster with environment modules such as LMOD, use the included Rstudio startup script while in the project root dir:

```
sinteractive # Compute intensive jobs often not allowed on cluster head node
source start_Rstudio.sh ./env
```

## Jupyter

Alternatively, the excellent Jupyter package and dependcies were installed into the current conda environment. To use R in Jupyter, go to project root directory, activate the newly created conda environment, start Jupyter server and select the R kernal in the Notebooks section:

```
jupyter lab #local install
```
or

```
sinteractive --gres=lscratch:5 --mem=10g --tunnel #cluster install (slurm) with SSH tunnel
conda activate ./env
jupyter notebook --ip localhost --port $PORT1 --no-browser
```
or

```
sinteractive --gres=lscratch:5 --mem=10g #cluster install (slurm) with NoMachine
conda activate ./env
jupyter notebook --ip localhost --port $PORT1 --no-browser
```

If you have multiple R versions and/or irkernels installed in the current conda environment or plan on doing so (not a great idea), you can choose specific kernel by running the irkernel setup sript:

```
setup_irkernal.R
```

Then specify the R kernel on Jupyter startup

```
jupyter-lab --kernel=irxx
```

## Nvim-R
