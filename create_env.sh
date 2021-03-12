#!/bin/bash

# CMD: source create_env.sh

working_dir="$PWD"
echo "Installing conda environment and/or R at:"
echo $working_dir

conda_data=$(find -L "/data/$USER" -path "*conda/bin/conda")
conda_home=$(find "$HOME" -path "*conda/bin/conda")
if [[ -n "$conda_data" ]] || [[ -n "$conda_home" ]]
then
	echo -e "\nFound Conda executable installed at:"
	echo "$conda_data"
	echo "$conda_home"
else
	echo -e "Could not find Conda executable installed in common locations.\n"
	echo -e "Please run the included 'install_miniconda.sh', verify conda installation.\n"
fi

read -p "Create conda envs (1 python, 1 R)? (y/n)" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
	# start prepping the project dir
	cd $working_dir
	
	# create conda env for general use
	echo -e "Creating general use conda environment at './env'\n"
	conda activate base
	conda create --yes -p env
	conda activate ./env

	echo -e "Installing Jupyter, scipy core, scikit-learn and R into active env\n"
	conda install --yes -c conda-forge scikit-learn jupyterlab numpy scipy matplotlib ipython pandas sympy nose
	mamba install --yes -c conda-forge -c bioconda snakemake
	conda install --yes -c conda-forge r-base r-essentials
	conda install --yes -c conda-forge r-irkernel
	conda env export --no-builds > env.yml
	conda deactivate

	echo -e "Activate this conda environment by typing:"
	echo -e "conda activate <env_path>\n"
	echo -e "For exampe, 'conda activate ./env' (not 'conda activate env')"
else
	echo -e "Skipping creation of conda environment.\n"
fi

# loaded by 'R' module or required by Rstudio but not installed here: 
# conda install -c conda-forge qt
# conda install -c conda-forge hdf5
# conda install -c conda-forge openmpi
# conda install -c conda-forge libnetcdf
# Eventually deal with gcc and zlib to keep everything contained in conda
