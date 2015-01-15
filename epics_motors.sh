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

#
# EPICS/epicsLibs
#

# Define the epics path
epics=${HOME}/epics
# Define the epics download dir
epics_downloads=${epics}/downloads
# Where we are
current_epics_path=${EPICS_PATH}
# Define the epicsLibs
current_epicsLibs_path=${current_epics_path}/epicsLibs
# Make epicsLibs
motorApps_path=${current_epicsLibs_path}/motorApps



make_release()
{
    local name=$1
    local rfile="${motorApps_path}/${name}/configure/RELEASE"
      # #
    # # substitution a path with b path in a file by using sed
    # #
    # # PATH has /, so use | instead of / as a seperator
    # #
    # # ^SUPPORT : ^ selects only the first character
    # # ^SUPPORT=.* : Start with SUPPORT=blabla..... 
    # #
    # sed -i~ "s|^SUPPORT=.*|SUPPORT=${motor_dir}|g" "${motor_release}"
    sed -i  "s|^EPICS_BASE=.*|EPICS_BASE=${EPICS_PATH}/base|g" "${rfile}"

    # # make release
    # # make clean uninstall
    # # make -j
}

downloads()
{
    local site=$1
    local file=$2
    local link=${site}${file}
#    echo "$wget_options ${link} -P ${epics_downloads} "
    $wget_options ${link} -P ${epics_downloads} 
    $tar_command ${epics_downloads}/${file} -C  ${motorApps_path}

}


mkdir -p ${motorApps_path}


ipac_version="2.13"
seq_version="2.1.16"
asyn_version="4-24"
busy_version="R1-6-1"
motor_version="6-9"

ipac_name="ipac-${ipac_version}"
seq_name="seq-${seq_version}"
asyn_name="asyn${asyn_version}"
busy_name="busy_${busy_version}"
motor_name="motorR${motor_version}"


ipac_filename="${ipac_name}.tar.gz"
seq_filename="${seq_name}.tar.gz"
asyn_filename="${asyn_name}.tar.gz"
busy_filename="${busy_name}.tar.gz"
motor_filename="${motor_name}.tar.gz"

ipac_site="http://www.aps.anl.gov/epics/download/modules/"
seq_site="http://www-csr.bessy.de/control/SoftDist/sequencer/releases/"
asyn_site="http://www.aps.anl.gov/epics/download/modules/"
busy_site="http://www.aps.anl.gov/bcda/synApps/tar/"
motor_site="http://www.aps.anl.gov/bcda/synApps/motor/tar/"

filenum=5
names=( "${ipac_name}" "${seq_name}" "${asyn_name}" "${busy_name}" "${motor_name}" )
files=( "${ipac_filename}" "${seq_filename}" "${asyn_filename}" "${busy_filename}" "${motor_filename}" )
sites=( "${ipac_site}" "${seq_site}" "${asyn_site}" "${busy_site}" "${motor_site}" )


for (( i = 0 ; i < ${filenum} ; i++ )) 
do
    downloads ${sites[$i]} ${files[$i]} 

done



for (( i = 0 ; i < ${filenum} ; i++ )) 
do
    make_release ${names[$i]} 

done



# $tar_command ${epics_downloads}/${motor_filename} -C ${current_epicsLibs_path}

# # Predefine in tar.gz file
# #
# current_motor_path=${current_epicsLibs_path}/${motor_name}

# echo $current_motor_path
# make_motor "${current_motor_path}"

exit