#!/bin/bash

# start an interactivate job before running.
# usage: source start_Rstudio.sh <environment>
# CMD: source start_Rstudio.sh ./env

# activate specified conda in current dir.
###########
echo -e "Activating Conda environment containing R binary.\n"

conda activate $1

module load Rstudio

# Figure out here::here() works in Snakemake workflows then replace .Rproj and batch
# descriptions below with here::here() usage to set project level pwd for R/Rmd envs
echo -e "Interactive (Rstudio) use:
	Within Rstudio, open 'project.Rproj' file before running code.
	This sets project root directory and sources the .Rprofile
	containing path to external (non-conda) R libraries.

Non-Interactive (Rmarkdown, batch jobs) use:
	Call Rscript/Rmarkdown from project root directory.
	Within 'script.R' or 'markdown.Rmd' file, 
	just source the project-level.Rprofile
	containing path to external (non-conda) R libraries
	(either at top of file, or passed during
	rmarkdown::render argument parsing).\n"

echo -e "Remember to start an interactive session BEFORE activating conda environment.
Compute intensive interactive jobs are not allowed on the Biowulf head node.\n"

echo -e "Starting R/Rstudio.\n"

rstudio --conda


# Move to github README.md
# Basic startup steps (if not using this startup script):
# CMD: cd /path/to/project/folder/
# CMD: sinteractive --cpus-per-task=4 --mem=4g --time=8:00:00
# CMD: source /data/$USER/conda/etc/profile.d/conda.sh #if needed
# CMD: conda activate <environment>
# CMD: module load Rstudio/1.4.1103
# CMD: rstudio --conda
