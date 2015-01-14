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
#


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
tar_command="tar xzfk "
make_command_base=""


make_motor()
{
    motor_dir=$1
    cd ${motor_dir}
#    echo ${motor_dir}
    motor_release="${motor_dir}/configure/RELEASE"
    #
    # substitution a path with b path in a file by using sed
    #
    # PATH has /, so use | instead of / as a seperator
    #
    # ^SUPPORT : ^ selects only the first character
    # ^SUPPORT=.* : Start with SUPPORT=blabla..... 
    #
    sed -i~ "s|^SUPPORT=.*|SUPPORT=${motor_dir}|g" "${motor_release}"
    sed -i  "s|^EPICS_BASE=.*|EPICS_BASE=${EPICS_BASE}|g" "${motor_release}"

    # make release
    # make clean uninstall
    # make -j
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
# http://www.aps.anl.gov/bcda/synApps/motor/
# http://www.aps.anl.gov/bcda/synApps/motor/tar/motorR6-9.tar.gz
#
motor_version="6-9"
motor_name="motorR${motor_version}"
motor_filename="${motor_name}.tar.gz"
motor_download_site="http://www.aps.anl.gov/bcda/synApps/motor/tar/"
motor_link=${motor_download_site}${motor_filename}

$wget_options ${motor_link} -P ${epics_downloads}
$tar_command ${epics_downloads}/${motor_filename} -C ${current_modules_path}

# Predefine in tar.gz file
#
current_motor_path=${current_modules_path}/${motor_name}

echo $current_motor_path
make_motor "${current_motor_path}"

exit