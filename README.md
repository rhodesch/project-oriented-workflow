# conda-r-py-snakemake
Reproducible analysis with R, Python and Snakemake via Conda

This repository contains setup scripts to automate the installation of R, Python and Snakemake and other software used for bioinformatic and data science projects in conda environments. Setup will install 1) r-base and r-essentials, 2) python, JupyterLab and core SciPy packages and 3) Snakemake workflow management system allowing interactive or batch analysis on local, cluster and cloud platforms.

Setup will also several files to streamline setup of R within a conda env including: addition of .Rprofile and .Renvironment files, a .here file for setting project-level working directory, and add an external R library directory for ad hoc installation of R packages not yet on conda-forge or bioconda channels.

Currently only supports unix based systems.


Instructions:
Clone this repo into your main project directory.
Run "activate.sh" script to create conda environments"
```
    source ./conda-r-python-snakemake
```

Next run R setup up script:
  source setup_r.sh

