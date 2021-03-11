#!/bin/bash

# this setup script only needs to be run once, after each R installation/update

# cd into main project directory, where conda env with R exists, then run this scipt:
# usage: source setup_R.sh <environment>
# CMD: source setup_R.sh ./env-r


# activate specified conda in current dir.
###########
echo -e "Activating conda environment containing R binary.\n"

conda activate $1

# make external library for R packages not yet on Conda channels.
# detects R version used in 'which R'
###########
Rversion=$(R --version | grep -oP 'R version \K([0-9]\.[0-9])')
if [[ -n "$Rversion" ]]
then
	if [[ $(basename $PWD) == "setup" ]]
	then
		echo "moving out of setup dir to project dir"
		cd ..
	else
		echo "already in project dir"
	fi

	valid_version=$(ls R/ -v | grep "^[0-9]\.[0-9]$" | tail -n 1)
	if [[ "$valid_version" != "$Rversion" ]]
	then
		echo "Adding R library folder:"
		echo "$Rversion"
		mkdir -p R/${Rversion}/library
	else
	fi

	# add project specific settings to the project-level .Rprofile
	##########
	f_profile=".Rprofile"

	if [[ ! -f $f_profile ]]
	then
		echo -e "Writing to project-level .Rprofile.\n"

		echo "
		print('Path to R:')
		print(R.home())

		print('Remember to install non-conda R packages by:')
		print(\"install.packages(<package_name>, lib=Sys.getenv('R_LIBS_USER')\")
		" > $f_profile

		# add project specific info to the project-level .Rprofile
		f_library=$(find . -maxdepth 2 -type f -name 'add_external_lib_path.R')

		if [[ -f $f_library ]]
		then
			echo -e "Adding external library path to project-level .Rprofile.\n"
			cat $f_library >> $f_profile
		else
			echo -e "External library path was not added to project-level .Rprofile.\n"
		fi
	else
		echo -e "Project-level .Rprofile already exists.\n"
	fi

	# add project specific settings to the project-level .Renviron
	##########
	f_environ=".Renviron"

	if [[ ! -f $f_environ ]]
	then
		echo -e "Setting empty R_LIBS_SITE in project-level .Renviron.\n"
		R_LIBS_SITE='' > $f_environ
	else
		echo -e "Project-level .Renviron already exists.\n"
	fi

	echo -e "Deactivating Conda environment containing R binary.\n"
	conda deactivate

	echo -e "R is ready for use in Rstudio from within a Conda environment.
	Run the 'start_Rstudio.sh' file to easily start Rstudio.\n"

	ln -s setup/setup_R.sh .
	ln -s setup/start_Rstudio.sh .
else
	echo "R is not installed in the active conda env."
	echo "Please install conda to the activate env and re-run this setup script."
fi