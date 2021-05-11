---
layout: default
title: Home
nav_order: 1
description: "Just the Docs is a responsive Jekyll theme with built-in search that is easily customizable and hosted on GitHub Pages."
permalink: /
---

# Project-Oriented Analyses using R, Python and Snakemake in Conda

This website aims to walk you through the automated creation of a self-contained project workspace suitable for most bioinformatics and data science analyses. The workspace consists of a well-defined directory structure and a software environment focused on reproducible analysis.

# Why use reproducible environments?

Using reproducible environments allows experiments and analyses to be repeated by yourself or others, increase traceability, and improve collaborations of teams sharing and running code. If you have set up an environment and installed packages, having a collaborator or team member reproduce your work can be as trivial as 1) point to the project directory and run code with packages installed only for that project or 2) send a collaborator you environment build properties that rebuilds you environment on a new machine.
Additionally, reproducible environments will aim to coordinate and install all low-level operating system dependencies, allowing you to create code that is more OS-independent. For example, when sharing an environment, it can be shared betwee unix and windows machines with little or no issues.

How do reproducible environments fit into the large picture of good data science analyses? When we think about data analysis, we often think just about the resulting reports, insights, or visualizations; the output ("product") is the essence of the analysis. Instead, it is much more useful to think of your analysis as a workflow, in which workflow-related operations (QC, visualizaiton) occur within a well-defined project directory structure and using a project specific software environment. Such a Project-Oriented Workflow will save time, reduce errors, and becomes critical as the size and complexity of analyses grow.

We will cover two important topics to establish a project-oriented workflow:
- Create a self-contained project, structured for bioinformatics workflows
- Create a reproducible analysis environment containing common data science tools
