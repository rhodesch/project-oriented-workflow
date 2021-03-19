* Will be replaced with the ToC
{:toc}

## Why use reproducile environments?
Using reproducible environments allows experiments and analyses to be repeated by yourself or others, increase traceability, and improve collaborations of teams sharing and running code. If you have set up an environment and installed packages, having a collaborator or team member reproduce your work can be as trivial as 1) point to the project directory and run code with packages installed only for that project or 2) send a collaborator you environment build properties that rebuilds you environment on a new machine.
Additionally, reproducible environments will aim to coordinate and install all low-level operating system dependencies, allowing you to create code that is more OS-independent. So in the examples above, when an environment is shared, it can be shared from a unix machine to one running windows with little or no issues. 

How do reproducible environments fit into the large picture of good data science analyses?
When we think about data analysis, we often think just about the resulting reports, insights, or visualizations; the output ("product") is the essence of the analysis. Instead, it is much more helpful to this of your analysis as a workflow, in which workflow-related operations (QC, visualizaiton) are executed within a well-defined project directory structure and using a project specific reproducible environment.

The current documentation will cover two important topics to establish a project-oriented workflow:
- Create a self-contained project, structured for bioinformatics workflows
- Create a reproducible analysis environment containing common data science tools

## Get started
This document describes automated creation of a self-contained project structure and installation of R, Python and Snakemake and other software used for bioinformatic and data science projects in conda environments. Packages installed include 1) r-base and r-essentials, 2) python, JupyterLab and core SciPy packages and 3) Snakemake workflow management system allowing interactive or batch analysis on local, cluster and cloud platforms.

Setup will also streamline the setup of R within a conda env by creating: project-level .Rprofile and .Renvironment files, a .here file to set project-level working directory in R, and an external R library directory for ad hoc installation of R packages not yet on conda-forge or bioconda channels.

Importantly, when you use R with conda you need to stick to conda as much as you can. Whenever possible, DON'T LET R INSTALL PACKAGES FOR YOU. In other words ALWAYS USE CONDA TO INSTALL THE PACKAGES YOU NEED unless there is not a conda recipe for that package. In that case, see below.

Currently only supports unix based systems.

## Create project folder with Cookiecutter
Optional, but *higly encouraged*:
Prior to setting up an analysis environment, create a self-contained project directory with well-defined directory structure. This should contain everything needed for an analysis, with the possible exception of raw data maintained on a dedicated data storage drive. The creation of the project folder is automated using a package called cookiecutter which will use a template to create the same directory structure every time. To do so, conda will need to be installed:

If conda is not istalled, clone this repo, then install miniconda by running the following:

```
git clone https://github.com/ctrhodes/conda-r-python-snakemake.git
source ./conda-r-python-snakemake/install_miniconda.sh
```

If conda is installed but not cookiecutter, install cookiecutter in an environment other than base:

```
conda create --name cookiecutter -c conda-forge cookiecutter
```

After installing cookiecutter, go to the directory where to want to create your main project folder.
Clone the following cookiecutter snakemake template:

```
conda activate cookiecutter
cookiecutter https://github.com/ctrhodes/cookiecutter-snakemake-workflow
conda deactivate
```

This creates a template defined by the snakemake project with the following structure:

```
project/
├── LICENSE
├── README.md
├── config
│   ├── config.yaml
│   └── samples.tsv
├── resources
│   └── README.md
├── results
│   ├── README.md
│   ├── logs
│   ├── plots
│   └── tables
└── workflow
    ├── Snakefile
    ├── envs
    │   └── myenv.yaml
    ├── notebooks
    │   ├── notebook.py.ipynb
    │   └── notebook.r.ipynb
    ├── report
    │   ├── some-plot.rst
    │   └── workflow.rst
    ├── rules
    │   ├── common.smk
    │   └── other.smk
    ├── schemas
    │   ├── config.schema.yaml
    │   └── samples.schema.yaml
    └── scripts
        └── common.py
```

## Create analysis environment in main project directory

Move into the desired directory, such as the main project folder, and create the new conda environment, This will take a while.

```
cd project/
git clone https://github.com/ctrhodes/conda-r-python-snakemake.git
source ./conda-r-python-snakemake/create_env.sh
```

Next run R setup up script from the project directory (a symlink is created in the current directory):

```
source ./conda-r-python-snakemake/setup_R.sh ./env
```

Important note about installing R packages (adapted from [here](https://community.rstudio.com/t/why-not-r-via-conda/9438/4)):
Do not mix conda proprietary channels (anaconda, r) with open-source channels (conda-forge, bioconda, defaults). Problems will arise. R versions in different channels are often not compatible as they are compiled with different internals. If you setup R with the setup scripts in this repo, there will be a R library folder for installing external R libraries from CRAN/Bioconductor/Github, created in the current working directory. If you must install R packages directly in R (conda recipe not available), always specify the library path in R using something like:

```
install.packages(pkgs, lib=Sys.getenv('./R/4.0/library')
```

This will very likely install packages that have already been installed via conda channels, including those installed in r-essentials. Consequently, when installing an R package externally (and if you need to do this a lot, then conda may not be the solution for you), look up the dependencies in the docs and install those first with conda.

## Working Directory
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


## If using R interactively

Currently, Rstudio is not available on open-source channels. If you want to use Rstudio with R in the installed Conda environment there are a few options:
- On a personal machine, use a locally installed Rstudio Desktop.
- On a cloud platform, use Rstudio Server, described here: [gce-startup](https://github.com/ctrhodes/gce-startup)
- On a cluster with environment modules such as LMOD, use the included Rstudio startup script while in the project root dir:

```
sinteractive # Compute intensive jobs often not allowed on cluster head node
source start_Rstudio.sh ./env
```

Alternatively, the excellent Jupyter package and dependcies were installed into the current conda environment. To use R in Jupyter, go to project root directory, activate the newly created conda environment, start Jupyter server and select the R kernal in the Notebooks section:

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

If you have multiple R versions and/or irkernels installed in the current conda environment or plan on doing so (not a great idea), you can choose specific kernel by running the irkernel setup sript:

```
setup_irkernal.R
```

Then specify the R kernel on Jupyter startup

```
jupyter-lab --kernel=irxx
```






## Welcome to GitHub Pages

You can use the [editor on GitHub](https://github.com/ctrhodes/conda-r-python-snakemake/edit/gh-pages/index.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/ctrhodes/conda-r-python-snakemake/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://docs.github.com/categories/github-pages-basics/) or [contact support](https://support.github.com/contact) and we’ll help you sort it out.
