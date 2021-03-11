#!/bin/bash

# CMD: source create_envs.sh

working_dir="$PWD"
echo "Preparing project workspace and installing conda environment and/or R at:"
echo $working_dir

conda_data=$(find -L "/data/$USER" -path "*conda/bin/conda")
conda_home=$(find "$HOME" -path "*conda/bin/conda")
if [[ -n "$conda_data" ]] || [[ -n "$conda_home" ]]
then
	echo -e "\nFound Conda executable installed at:"
	echo "$conda_data"
	echo "$conda_home"
else
	echo -e "\nCould not find Conda executable installed in common locations.\n"
	read -p "Install miniconda? (y/n)" -n 1 -r response
	if [[ "$response" =~ ^[Yy]$ ]]
	then
		if [[ -d "/data/$USER" ]]
		then
			dir_default="/data/$USER"
			read -p "Enter directory to install in [$dir_default]: " dir_use
			dir_use=${dir_use:-$dir_use}
		else
			dir_default="$HOME"
			read -p "Enter directory to install in [$dir_default]: " dir_use
			dir_use=${dir_use:-$dir_use}
		fi

		echo "Installing miniconda to:"
		echo $dir_use
		cd $dir_use
		
		function download {
		url=$1
		filename=$(basename "$url")

		echo $url
		echo $filename

		if [[ -x "$(which wget)" ]]
		then
			wget -O $filename $url
			echo ""
		elif [[ -x "$(which curl)" ]]
		then
			curl -o $filename $url
			echo ""
		else
			echo "Could not find curl or wget, please install either.\n"
			exit
		fi
		}
		download https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh

		if [[ -d /scratch ]]
		then
			echo "using /scratch as temp dir."
			tmp_dir=/scratch/$USER/temp
			mkdir -p $tmp_dir
		else
			echo "using $HOME as temp dir."
			tmp_dir=$HOME/temp
			mkdir -p $tmp_dir
		fi

		TMPDIR=$tmp_dir bash Miniconda3-latest-Linux-x86_64.sh -p $dir_use/conda -b
		rm Miniconda3-latest-Linux-x86_64.sh
		source $dir_use/conda/etc/profile.d/conda.sh
		conda activate base
		conda clean --all
		conda config --add channels bioconda
		conda config --add channels conda-forge
		conda config --set channel_priority strict
		conda config --set auto_activate_base false
		conda install --name=base -c conda-forge mamba
		conda deactivate
	else
		echo -e "Skipping miniconda installation.\n"
	fi
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

	echo -e "Installing Jupyter lab/notebook, scipy core and scikit-learn into active env\n"
	conda install --yes -c conda-forge scikit-learn jupyterlab numpy scipy matplotlib ipython pandas sympy nose
	mamba install --yes -c conda-forge -c bioconda snakemake
	conda install --yes -c conda-forge r-base r-essentials
	conda install --yes -c conda-forge r-irkernel
	conda env export --no-builds > env.yml
	conda deactivate

	# # create conda env for R/Rstudio
	# echo -e "Creating environment containing R at './env-r'\n"
	# conda create --yes -p env-r
	# conda activate ./env-r

	# echo -e "Installing r-base and r-essentials to activate env\n"
	# conda install --yes -c conda-forge r-base r-essentials
	# # mamba install --yes -c conda-forge -c bioconda snakemake
	# conda env export --no-builds > env-r.yml
	# conda deactivate
else
	echo -e "Skipping creation of conda environment.\n"
fi

if [[ "$response" =~ ^[Yy]$ ]]
then
	echo -e "Conda will add initialization entry to your shell config file."
	echo -e "Cofirm by trying 'cat ~/.bashrc' or 'cat ~/.bashprofile' and go to end of file.\n"
	echo -e "After restarting, shell activate conda environment by typing:"
	# echo -e "Conda activate (for base environment)"
	echo -e "Conda activate <env_name> (for user create env)\n"

	conda init
fi

# # loaded by biowulf 'R' module or required by Rstudio but not installed here:
# # conda install -c conda-forge qt
# # conda install -c conda-forge hdf5
# # conda install -c conda-forge openmpi
# # conda install -c conda-forge libnetcdf
# # Eventually deal with gcc and zlib to keep everything contained in conda
