#!/bin/bash
# Shell   : epics_synApps.sh
# Author  : Jeong Han Lee
# email   : jhlee@ibs.re.kr
# Date    : Friday, December 12 14:37:20 KST 2014
# version : 0.0.2
#
#           0.0.1 created  Friday, December 12 14:37:20 KST 2014
#
#           0.0.2 Tuesday, January 13 17:16:53 KST 2015
#                 - change the installation directory epicsLibs
#                   instead of modules. epicsLibs will be used
#                   for other EPICS driven libraries (EtherIP,
#                   and so on ....)
#           0.0.3 
#                 - remove AREA_DETECTOR, DXP on linux-arm architecture
# 
#         
#           0.0.4 Monday, March 30 07:32:40 KST 2015, jhlee
#                 - change the default synApps as 5_8


## This tells bash that it should exit the script if any statement returns a non-true return value. 
set -e
# This will exit your script if you try to use an uninitialised variable
set -u


# cq   : quiet 
# c    : continue getting a partially-downloaded file. So it allows us not to re-download an existent file
# 
wget_options="wget -c"
# xzf  : quiet
# xzfv : verbose
# xzfk : don't replace existing files when extracting
tar_command="tar xzf "
make_command=""


make_synApps()
{
    synApps_dir=$1
    cd ${synApps_dir}
#    echo ${synApps_dir}
    synApps_release="${synApps_dir}/configure/RELEASE"
    #
    # substitution a path with b path in a file by using sed
    #
    # PATH has /, so use | instead of / as a seperator
    #
    # ^SUPPORT : ^ selects only the first character
    # ^SUPPORT=.* : Start with SUPPORT=blabla..... 
    #
    sed -i~ "s|^SUPPORT=.*|SUPPORT=${synApps_dir}|g" "${synApps_release}"
    sed -i  "s|^EPICS_BASE=.*|EPICS_BASE=${EPICS_BASE}|g" "${synApps_release}"


    case `uname -sm` in
	"Linux i386" | "Linux i486" | "Linux i586" | "Linux i686")
            EPICS_HOST_ARCH=linux-x86
	    EXTN_LIB_ARCH=i386-linux-gnu
#	    sed -i  "s|^AREA_DETECTOR=.*|#AREA_DETECTOR=.*|g" "${synApps_release}"
#	    sed -i  "s|^DXP=.*|#DXP=.*|g" "${synApps_release}"
	    make_command="make -j"
            ;;
	"Linux x86_64")
            EPICS_HOST_ARCH=linux-x86_64
	    EXTN_LIB_ARCH=x86_64-linux-gnu
	    make_command="make -j"
            ;;
	"Linux armv6l")
	    EPICS_HOST_ARCH=linux-arm
	    EXTN_LIB_ARCH=arm-linux-gnueabihf
	    sed -i  "s|^AREA_DETECTOR=.*|#AREA_DETECTOR=.*|g" "${synApps_release}"
	    sed -i  "s|^DXP=.*|#DXP=.*|g" "${synApps_release}"
	# 
	# There are missing header files when make -j is used on 
	# Raspberry Pi 
	# Tuesday, August 26 14:44:43 KST 2014, jhlee
	# 
	    make_command="make"
	    ;;
	"Linux armv7l")
	    EPICS_HOST_ARCH=linux-arm
	    EXTN_LIB_ARCH=arm-linux-gnueabihf
	    sed -i  "s|^AREA_DETECTOR=.*|#AREA_DETECTOR=.*|g" "${synApps_release}"
	    sed -i  "s|^DXP=.*|#DXP=.*|g" "${synApps_release}"
	    make_command="make -j 2"
	    ;;
	*)
            echo "This script  doesn't support this architecture : `uname -sm`"
            exit 1
            ;;
    esac
    
    make release
    make clean uninstall
    $make_command
}



#
# EPICS/EPICS_BASE
# EPICS/EPICS_EXTENSIONS
#


epics=${HOME}/epics

epics_downloads=${epics}/downloads

current_epics_path=${EPICS_PATH}

current_modules_path=${current_epics_path}/epicsLibs

mkdir -p ${current_modules_path}


#
#  synApps
#  http://www.aps.anl.gov/bcda/synApps/
#
#
# http://www.aps.anl.gov/bcda/synApps/tar/synApps_5_8.tar.gz


synApps_version="5_8"
synApps_name="synApps_${synApps_version}"
synApps_filename="${synApps_name}.tar.gz"
synApps_download_site="http://www.aps.anl.gov/bcda/synApps/tar/"
synApps_link=${synApps_download_site}${synApps_filename}

$wget_options ${synApps_link} -P ${epics_downloads}
$tar_command ${epics_downloads}/${synApps_filename} -C ${current_modules_path}

# Predefine in tar.gz file
#
current_synApps_path=${current_modules_path}/${synApps_name}/support

echo $current_synApps_path
make_synApps "${current_synApps_path}"

exit
