#####################################
# Variable Definition
#####################################
pkg_web='httpd mod_ssl'
svc_web='httpd'
indexfile='/var/www/html/index.html'

pkg_esential='gnome-tweaks epel-release'
pkg_additional='boxes cowsay'

######################################
# Function Definition
######################################
function print_good () {
    echo -e "\x1B[01;32m[  OK  ]\x1B[0m $1"
}

function print_error () {
    echo -e "\x1B[01;31m[ FAIL ]\x1B[0m $1"
}

function print_info () {
    echo -e "\x1B[01;34m[ INFO ]\x1B[0m $1"
}

###########################################
# etc
###########################################