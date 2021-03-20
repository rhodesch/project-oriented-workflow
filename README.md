# Install R, Python and Snakemake in Conda environments
Reproducible analysis with R, Python and Snakemake via Conda

For full documentation and instructions: [Project Homepage](https://ctrhodes.github.io/conda-r-python-snakemake)

This repository contains setup scripts to automate the installation of R, Python and Snakemake and other software used for bioinformatic and data science projects in conda environments. Setup will install conda (if needed) as well as 1) *R* and the conda-forge r-essentials package, 2) *Python* and core SciPy packages, 3) *Jupyter* Lab and Notebook and 4) *Snakemake* workflow management system allowing interactive or batch analysis on local, cluster and cloud platforms.

Setup will also streamline the setup of R within a conda env by creating: project-level .Rprofile and .Renvironment files, a .here file to set project-level working directory in R, and an external R library directory for ad hoc installation of R packages not yet on conda-forge or bioconda channels.

Currently only supports unix based systems.
