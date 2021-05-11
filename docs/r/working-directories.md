---
layout: default
title: Working Directories
parent: R And Conda
nav_order: 4
---

# Working Directory

The R package "here" will be installed during conda environment creation and an empty .here file is created in the project root directory. Upon R startup, the here package will move into parent directories and look for a .here file (and others like .Rproj or .git). If the .here file is found, the R root directory is set in the here object, even if the current working dir is changed with setwd(). So as long as a .R or .Rmd file are opened somewhere in the project directory tree (project/workflow/scripts/script.R), the .here file at project/.here will be found. Calling setwd() and/or file.path() can be replaced with here::here() for easy R path management. Keep in mind the here() conflicts with other functions named here(), especially Tidyverse packages, so be sure to call here::here() instead of library(here);here(). For batch or package development uses, using rprojroot::has_file('.here') may be advisable instead of here::here().

For example, opening an R script located at ./workflow/scripts/script.R (or anywhere within the project/ root dir):
```
> here::dr_here()
here() starts at /project.
- This directory contains a file ".here"
- Initial working directory: /project/workflow/scripts
- Current working directory: /project/workflow/scripts

> setwd('~')
> getwd()
/home/rhodesct
> here::here()
"/project"
```

Likewise, Snakemake sets the current directory to wherever snakemake was called and then looks for a Snakefile in the following order ./Snakefile, ./workflow/Snakefile. If you use the cookiecutter template above, the Snakefile will be at ./workflow/Snakefile. So calling snakemake or R from the project root (project/) should keep the current directory synced across R, Python and Snakemake from within the newly created environment, whether these languages are used interactively (Jupyter, Rstudio) or in a batch.
