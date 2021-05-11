---
layout: default
title: Installation Via Conda
parent: Installation
nav_order: 2
---


# Create analysis environments

Move into the desired directory, such as the main project folder, and create the new conda environment, This will take a while.

```
cd project/
git clone https://github.com/ctrhodes/project-oriented-workflow.git
source ./project-oriented-workflow/create_env.sh
```

Next run R setup up script from the project directory (a symlink is created in the current directory):

```
source ./project-oriented-workflow/setup_R.sh ./env
```
