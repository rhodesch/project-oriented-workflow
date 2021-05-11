---
layout: default
title: What Is Installed?
parent: Installation
nav_order: 3
---

# What will be installed?

## Directory Structure:
Setup will manage the creation and organize your new project folder and subfolders using a well-documented directory structure (adapted from the Snakemake workflow) that is very useful for most analyses. In addition to making organizing your new project, the directory structure is compatable with Snakemake workflows. After you develop each distinct analysis script, you can place you can add a step to your Snakemake workflow, to build a reproducible and transparent analysis as you go. _Everything within the main project folder is self-contained, isolated from other projects on your system, and will not harm existing software installations or configurations elsewhere_

## Software Environment:
Setup will also install 1) **R** and many common CRAN packages, 2) **Python** and core SciPy packages, 3) **Jupyter** Lab and Notebook for interactive R/Python use and 4) **Snakemake** workflow management system. Collectively the installed environment will allow reproducible analyses in interactive or batch modes that can be executed on local, cluster and cloud platforms. Importantly, the installed software will be contained in the newly installed conda environment. _They will not conflict with existing installations elsewhere on your system_

## Config Files:
Setup will also streamline the setup of R within a conda env by creating: **Project-level** .Rprofile and .Renvironment files, a .here file to set project-level working directory in R, and an external R library directory for ad hoc installation of R packages not yet on conda-forge or bioconda channels. _They will not conflict with existing config files elsewhere on your system_

Currently only unix based systems supported.
