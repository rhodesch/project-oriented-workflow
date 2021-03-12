# ikernel configuration not needed for main R/Jupyter setup. This script is included for troubleshooting.

library(IRkernel)

r_version = R.Version()
version_major = r_version$major
# remove patch version
version_minor = gsub('\\.[0-9]+', '', r_version$minor)
r_version = paste0(version_major, '.', version_minor)

ir_name = paste0('ir', r_version)
ir_displayname = paste0('R ', r_version)

# to register the kernel in the current R installation
IRkernel::installspec(name = ir_name, displayname = ir_displayname)

# for RStudio’s shortcuts (requires Node.js)
# jupyter labextension install @techrah/text-shortcuts

q()
