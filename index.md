* Will be replaced with the ToC
{:toc}

## Why use reproducile environments?
Using reproducible environments allows experiments and analyses to be repeated by yourself or others, increase traceability, and improve collaborations of teams sharing and running code. If you have set up an environment and installed packages, having a collaborator or team member reproduce your work can be as trivial as 1) point to the project directory and run code with packages installed only for that project or 2) send a collaborator you environment build properties that rebuilds you environment on a new machine.
Additionally, reproducible environments will aim to coordinate and install all low-level operating system dependencies, allowing you to create code that is more OS-independent. So in the examples above, when an environment is shared, it can be shared from a unix machine to one running windows with little or no issues. 

How do reproducible environments fit into the large picture of good data science analyses?
When we think about data analysis, we often think just about the resulting reports, insights, or visualizations; the output ("product") is the essence of the analysis. Instead, it is much more helpful to this of your analysis as a workflow, in which workflow-related operations (QC, visualizaiton) are executed within a well-defined project directory structure and using a project specific reproducible environment. 
The current documentation will cover two important topics to establish a project-oriented workflow:
- Create a directory structure designed for bioinformatics workflows
- Create a reproducible conda environment containing common data science tools


## Install

This repository contains setup scripts to automate the installation of R, Python and Snakemake and other software used for bioinformatic and data science projects in conda environments. Setup will install 1) r-base and r-essentials, 2) python, JupyterLab and core SciPy packages and 3) Snakemake workflow management system allowing interactive or batch analysis on local, cluster and cloud platforms.

Setup will also streamline the setup of R within a conda env by creating: project-level .Rprofile and .Renvironment files, a .here file to set project-level working directory in R, and an external R library directory for ad hoc installation of R packages not yet on conda-forge or bioconda channels.

Importantly, when you use R with conda you need to stick to conda as much as you can. Whenever possible, DON'T LET R INSTALL PACKAGES FOR YOU. In other words ALWAYS USE CONDA TO INSTALL THE PACKAGES YOU NEED unless there is not a conda recipe for that package. In that case, see below.

Currently only supports unix based systems.




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
