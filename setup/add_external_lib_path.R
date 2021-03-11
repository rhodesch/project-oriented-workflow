
start_conda_env = function(conda_lib, ext_lib) { 
  # packages will be loaded and installed from .libPaths()[1] (e.g. conda_lib) first, then the next path.
  .libPaths(new=c(conda_lib, ext_lib))
  
  cat("using lib paths:\n")
  print(.libPaths())
}

current_conda_env = Sys.getenv('CONDA_DEFAULT_ENV')
cat('current_conda_env:', current_conda_env, '\n')

current_conda_prefix = Sys.getenv('CONDA_PREFIX')
cat('current_conda_prefix:', current_conda_prefix, '\n')

if (current_conda_env != "") {
  r_version = R.Version()
  version_major = r_version$major
  version_minor = gsub('\\.[0-9]+', '', r_version$minor)
  r_version = paste0(version_major, '.', version_minor)
  
  ext_lib_path = file.path(dirname(current_conda_env), 'R', r_version, 'library')
  
  if (dir.exists(ext_lib_path)) {
    r_lib_path = ext_lib_path
  } else {
    message("no compatible external lib")
    r_lib_path = ''
  }
  
  conda_lib_path = file.path(current_conda_env, 'lib', 'R', 'library')
  start_conda_env(conda_lib = conda_lib_path, ext_lib = r_lib_path)
} else {
  print("no conda env")
}

# Overrides default user library path set on R startup, to ensure R doesn't look there.
# Also allows easy calling of non-conda library path for external lib install
# CMD: install.packages(pkgs, lib=Sys.getenv('R_LIBS_USER')
Sys.setenv('R_LIBS_USER' = r_lib_path)

rm(list = ls())
