# Automated setup of project directory and bioinformatic software

## This repo is outdated. Use [dotfiles](https://github.com/daler/dotfiles) instead of this repo. Keeping visible in the off chance external R libs with conda is useful.

Reproducible, self-contained analyses with R, Python and Snakemake via Conda

For full documentation and instructions: [Project Homepage](https://ctrhodes.github.io/project-oriented-workflow)

This repository contains setup scripts to automate the installation of R, Python and Snakemake and other common software used for bioinformatic and data science analyses. The software is intalled via the Conda package manager. The installation includes creation of a directory structure to promote well-organized analyses. Setup will includes 1) **R** and many common CRAN packages, 2) **Python** and core SciPy packages, 3) **Jupyter** Lab and Notebook for interactive R/Python use and 4) **Snakemake** workflow management system. Collectively the installed environment promote reproducible and self-contained analyses.

Setup will also streamline the setup of R within a conda env by creating: project-level .Rprofile and .Renvironment files, a .here file to set project-level working directory in R, and an external R library directory for ad hoc installation of R packages not yet on conda-forge or bioconda channels.

Currently only unix based systems supported.
