---
layout: default
title: Overview
parent: R And Conda
nav_order: 1
---

# Intro to R in Conda

R and many common R packages were installed in a self-contained conda environment. To avoid package conflicts, only R, R packages and dependencies were installed in the environment. Separate conda environments were created for Python and Snakemake.

To use R, activate the environment:
```
conda activate ./env-r
```

Since the conda environment was installed in a non-default location, be sure to include './' when specifying the path to the environment.

When finished using R, deactivate the environment:
```
conda deactivate
```
