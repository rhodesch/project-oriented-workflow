---
layout: default
title: Overview
parent: Python And Conda
nav_order: 1
---

# Intro to Python in Conda

Python and SciPy core packages were installed in a self-contained conda environment. To avoid package conflicts, only Python, Python packages and dependencies were installed in the environment. Separate conda environments were created for R and Snakemake.

To use R, activate the environment:
```
conda activate ./env
```

Since the conda environment was installed in a non-default location, be sure to include './' when specifying the path to the environment.

When finished using Python, deactivate the environment:
```
conda deactivate
```
