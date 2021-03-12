#!/bin/bash

# CMD: source install_miniconda.sh

echo "Installing miniconda:"

conda_data=$(find -L "/data/$USER" -path "*conda/bin/conda")
conda_home=$(find "$HOME" -path "*conda/bin/conda")
if [[ -n "$conda_data" ]] || [[ -n "$conda_home" ]]
then
	echo -e "\nFound Conda executable installed at:"
	echo "$conda_data"
	echo "$conda_home"
else
	echo -e "\nCould not find Conda executable installed in common locations.\n"
	
	read -p "Install miniconda? (y/n)" -n 1 -r
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		echo ""

		unameOut="$(uname -s)"
		case "${unameOut}" in
			Linux*)     machine=Linux;;
			Darwin*)    machine=Mac;;
			CYGWIN*)    machine=Cygwin;;
			MINGW*)     machine=MinGw;;
			*)          machine="UNKNOWN:${unameOut}"
		esac
		echo ${machine}

		if [[ ${machine} == "Mac" ]]
		then
			# MacOS likely does not support '-i' option for read
			dir_use="$HOME"
		elif [[ -d "/data/$USER" ]]
		then
			name="/data/$USER"
			read -e -i "$name" -p "Enter installation path, or press enter to install in: [$name] " input
			dir_use="${input:-$name}"
		else
			name="$HOME"
			read -e -i "$name" -p "Enter installation path, or press enter to install in: [$name] " input
			dir_use="${input:-$name}"
		fi

		echo "Installing miniconda to:"
		echo $dir_use
		cd $dir_use

		if [[ -d /scratch ]]
		then
			echo "using /scratch/temp as temp dir."
			tmp_dir=/scratch/$USER/temp
			mkdir -p $tmp_dir
		else
			echo "using $HOME/temp as temp dir."
			tmp_dir=$HOME/temp
			mkdir -p $tmp_dir
		fi
		
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
		
		if [[ ${machine} == "Linux" ]]
		then
			echo "Installing for Linux."
			download https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
		elif [[ ${machine} == "Mac" ]]
		then
			echo "Installing for Mac."
			download https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
		else
			echo "Only Linux or Mac supported currently."
		fi
		
		TMPDIR=$tmp_dir bash Miniconda3-latest-*-x86_64.sh -p $dir_use/conda -b
		rm Miniconda3-latest-*-x86_64.sh
		source $dir_use/conda/etc/profile.d/conda.sh
		conda activate base
		conda clean --all
		conda config --add channels bioconda
		conda config --add channels conda-forge
		conda config --set channel_priority strict
		conda config --set auto_activate_base false
		conda install --yes --name=base -c conda-forge mamba
		conda deactivate

		echo -e "Conda will add initialization entry to your shell config file."
		echo -e "Cofirm by trying 'cat ~/.bashrc' or 'cat ~/.bash_profile' and go to end of file.\n"
		echo -e "After restarting shell, activate base conda environment by typing:"
		echo -e "conda activate base (for base environment)"

		conda init
	else
		echo -e "Skipping miniconda installation.\n"
	fi
fi
