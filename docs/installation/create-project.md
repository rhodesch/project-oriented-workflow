---
layout: default
title: Create Project
parent: Installation
nav_order: 1
---

# Create Project Folder
Optional, but _**higly encouraged**_:<br/>
Prior to setting up an analysis environment, create a self-contained project directory with well-defined directory structure. This should contain everything needed for an analysis, with the possible exception of raw data maintained on a dedicated data storage drive. The creation of the project folder is automated using a package called cookiecutter which will use a template to create the same directory structure every time. To do so, conda will need to be installed:

If conda is not istalled, clone this repo, then install miniconda by running the following:

```
git clone https://github.com/ctrhodes/project-oriented-workflow.git
source ./project-oriented-workflow/install_miniconda.sh
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


## Directory Structure
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
