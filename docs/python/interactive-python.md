---
layout: default
title: Interactive Python
parent: Python And Conda
nav_order: 2
---

# Using Python interactively

## Jupyter

The excellent Jupyter package and dependcies were installed into the current conda environment. To use Python in Jupyter, go to project root directory, activate the newly created conda environment, start Jupyter server and select the python kernal:

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
