# Install R, Python and Snakemake in Conda environments
Reproducible analysis with R, Python and Snakemake via Conda

This repository contains setup scripts to automate the installation of R, Python and Snakemake and other software used for bioinformatic and data science projects in conda environments. Setup will install 1) r-base and r-essentials, 2) python, JupyterLab and core SciPy packages and 3) Snakemake workflow management system allowing interactive or batch analysis on local, cluster and cloud platforms.

As Conda support for R is not as robust as other software, R and R packages are installed into an isolated Conda environment, while Snakemake, Python and related packages are installed in a separate environment (both created in the current working directory). Setup will also streamline the setup of R within a conda env by creating: project-level .Rprofile and .Renvironment files, a .here file to set project-level working directory in R, and an external R library directory for ad hoc installation of R packages not yet on conda-forge or bioconda channels.

Currently only supports unix based systems.

Instructions:
Clone this repo into your main project directory.

Run "create_envs.sh" script to create conda environments (and install conda, if needed)"

```
source ./conda-r-python-snakemake/create_envs.sh
```

Next run R setup up script (a symlink is created in the current directory):
```
source setup_R.sh
```

Important:
Do not mix conda proprietary channels (anaconda, r) with open-source channels (conda-forge, bioconda, defaults). Problems will arise.

Currently, Rstudio is not available on open-source channels. Consequently, if you want to use Rstudio with R in the installed Conda environment there are a few options:
- On a personal machine, use a locally installed Rstudio Desktop.
- On a cloud platform, use Rstudio Server, described here: [gce-startup](https://github.com/ctrhodes/gce-startup)
- On a cluster with environment modules such as LMOD, use the included Rstudio startup script:

```
source start_Rstudio.sh
```
