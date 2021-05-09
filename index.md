* Will be replaced with the ToC
{:toc}

This website aims to walk you through the automated creation of a self-contained project workspace suitable for most bioinformatics and data science analyses. The workspace consists of a well-defined directory structure and a software environment focused on reproducible analysis.

## Why use reproducible environments?
Using reproducible environments allows experiments and analyses to be repeated by yourself or others, increase traceability, and improve collaborations of teams sharing and running code. If you have set up an environment and installed packages, having a collaborator or team member reproduce your work can be as trivial as 1) point to the project directory and run code with packages installed only for that project or 2) send a collaborator you environment build properties that rebuilds you environment on a new machine.<br/>
Additionally, reproducible environments will aim to coordinate and install all low-level operating system dependencies, allowing you to create code that is more OS-independent. For example, when sharing an environment, it can be shared betwee unix and windows machines with little or no issues.

How do reproducible environments fit into the large picture of good data science analyses?
When we think about data analysis, we often think just about the resulting reports, insights, or visualizations; the output ("product") is the essence of the analysis. Instead, it is much more useful to think of your analysis as a workflow, in which workflow-related operations (QC, visualizaiton) occur within a well-defined project directory structure and using a project specific software environment. Such a _Project-Oriented Workflow_ will save time, reduce errors, and becomes critical as the size and complexity of analyses grow.

We will cover two important topics to establish a project-oriented workflow:
- Create a self-contained project, structured for bioinformatics workflows
- Create a reproducible analysis environment containing common data science tools

## Get started
What will be installed?

Directory Structure:<br/>
Setup will manage the creation and organize your new project folder and subfolders using a well-documented directory structure (adapted from the Snakemake workflow) that is very useful for most analyses. In addition to making organizing your new project, the directory structure is compatable with Snakemake workflows. After you develop each distinct analysis script, you can place you can add a step to your Snakemake workflow, to build a reproducible and transparent analysis as you go. _Everything within the main project folder is self-contained, isolated from other projects on your system, and will not harm existing software installations or configurations elsewhere_

Software Environment:<br/>
Setup will also install 1) **R** and many common CRAN packages, 2) **Python** and core SciPy packages, 3) **Jupyter** Lab and Notebook for interactive R/Python use and 4) **Snakemake** workflow management system. Collectively the installed environment will allow reproducible analyses in interactive or batch modes that can be executed on local, cluster and cloud platforms. Importantly, the installed software will be contained in the newly installed conda environment. _They will not conflict with existing installations elsewhere on your system_

Config Files:<br/>
Setup will also streamline the setup of R within a conda env by creating: **Project-level** .Rprofile and .Renvironment files, a .here file to set project-level working directory in R, and an external R library directory for ad hoc installation of R packages not yet on conda-forge or bioconda channels. _They will not conflict with existing config files elsewhere on your system_

Importantly, when you use R with conda you need to stick to conda as much as you can. Whenever possible, DON'T LET R INSTALL PACKAGES FOR YOU. In other words ALWAYS USE CONDA TO INSTALL THE PACKAGES YOU NEED unless there is not a conda recipe for that package. In that case, see below.

Currently only unix based systems supported.


### Create project folder with Cookiecutter
Optional, but _**higly encouraged**_:<br/>
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

or if your project directory already exists:
```
conda activate cookiecutter
cookiecutter -s https://github.com/ctrhodes/cookiecutter-snakemake-workflow
conda deactivate
```

Either way, if you see a message like:<\br>
'You've downloaded /Users/rhodesct/.cookiecutters/cookiecutter-snakemake-workflow before. Is it okay to delete and re-download it? [yes]:'<\br>
type 'yes' or press enter.


This will create a project folder with the following structure

```
project/
├── LICENSE
├── README.md
├── config                      <- Experiment wide config files and sample info
│   ├── config.yaml
│   └── samples.tsv             <- main file containing sample info
│   └── units.tsv               <- additional sample info
├── data                        <- Raw data (treat as immutable). Better to put sample info in samples.tsv
├── resources                   <- Download Bioconductor packages defined in env.yaml files
│   └── README.md
├── results                     <- Create results subdirs as you (or snakemake) adds analysis steps/rules
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


### Create analysis environment in main project directory

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


## R interactively

### Rstudio

Currently, Rstudio is not available on open-source channels. If you want to use Rstudio with R in the installed Conda environment there are a few options:
- On a personal machine, use a locally installed Rstudio Desktop.
- On a cloud platform, use Rstudio Server, described here: [gce-startup](https://github.com/ctrhodes/gce-startup)
- On a cluster with environment modules such as LMOD, use the included Rstudio startup script while in the project root dir:

```
sinteractive # Compute intensive jobs often not allowed on cluster head node
source start_Rstudio.sh ./env
```

### Jupyter

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

### Nvim-R

## Python interactively

### Jupyter

## Snakemake and R
The input snakemake S4 object used in R scripts has the following structure, str(snakemake):
Formal class 'Snakemake' [package ".GlobalEnv"] with 12 slots
  ..@ input          :List of 2
  .. ..$    : chr "data/test_in.txt"
  .. ..$ txt: chr "data/test_in.txt"
  ..@ output         :List of 1
  .. ..$ : chr "results/test/test_out.txt"
  ..@ params         : list()
  ..@ wildcards      : list()
  ..@ threads        : num 1
  ..@ log            : list()
  ..@ resources      : list()
  ..@ config         : list()
  ..@ rule           : chr "test"
  ..@ bench_iteration: num NA
  ..@ scriptdir      : chr "/absolute/path/to/projectdir/workflow/scripts"
  ..@ source         :function (...)
  
  
