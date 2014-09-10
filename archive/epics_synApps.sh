#!/bin/bash
# Shell   : epics_synApps.sh
# Author  : Jeong Han Lee
# email   : jhlee@ibs.re.kr
# Date    : Wednesday, February 12 20:11:49 KST 2014
# version : 0.0.1
#
#    * This script may give a little room to install again-and-again
#      asynDriver: Asynchronous Driver Support
#      http://www.aps.anl.gov/epics/modules/soft/asyn/
# 
#      I hope it would reduce our time to concentrate real works
#      instead of painful modification of unmaintained source codes.
# 
#   * Must install the following packages via root or sudo
#     before running this script
#     re2c : seq
#        
#     For Debian Wheezy,
# 
#      aptitude install re2c
#
#      synApps
#      aptitude install libnetcdf-dev libhdf5-dev libnexus0-dev libpng12-0-dev libbz2-dev
#     Of course, EPICS base, and its extension must be installed
#
#
#
#  - 0.0.1  Wednesday, February 12 11:17:57 KST 2014, jhlee
#           * created
#




# cq   : quiet 
# c    : continue getting a partially-downloaded file. So it allows us not to re-download an existent file
# 
wget_options="wget -c"
# xzf  : quiet
# xzfv : verbose
tar_command="tar xzf"



make_synApps()
{
    synApps_dir=$1
    cd ${synApps_dir}
    echo ${synApps_dir}

    synApps_release="${synApps_dir}/configure/RELEASE"

# unknown sed errro, I stop..
# Wednesday, February 12 22:10:59 KST 2014    
#     a=${synApps_dir}

#     echo "$EPICS_BASE"
#     sed -e 's/..\/base/..\/'${base_raw_dirname}'/g'  ${extn_release}_old > ${extn_release}
# #    sed -i~ 's/SUPPORT=\/APSshare\/epics\/synApps_5_7\/support/SUPPORT='${synApps_dir}'/g' ${synApps_release}
# #    sed -i~ -e 's/SUPPORT=\/APSshare\/epics\/synApps_5_7\/support/SUPPORT='${synApps_dir}'/g'  ${synApps_release}
#     sed -i  's/EPICS_BASE=\/APSshare\/epics\/base-3.14.12.3/EPICS_BASE=\'${EPICS_BASE}'\/g' ${synApps_release}
# #      sed: -e expression #1, char 60: unknown option to `s'

#     # make
}



#
# EPICS/EPICS_BASE
# EPICS/EPICS_EXTENSIONS
#

SYNAPPS_HOME_TMP=${EPICS_BASE}/../
cd ${SYNAPPS_HOME_TMP} 
SYNAPPS_HOME=${PWD}


echo ${SYNAPPS_HOME}



#
#  synApps
#  http://www.aps.anl.gov/bcda/synApps/
#
#
# http://www.aps.anl.gov/bcda/synApps/tar/synApps_5_7.tar.gz


synApps_version="5_7"
synApps_name="synApps_${synApps_version}"
synApps_filename="${synApps_name}.tar.gz"
synApps_download_site="http://www.aps.anl.gov/bcda/synApps/tar/"
synApps_link=${synApps_download_site}${synApps_filename}
synApps_path=${SYNAPPS_HOME}/support

# cd ${SYNAPPS_HOME}
# $wget_options ${synApps_link}
#$tar_command ${synApps_filename} --strip-components=1

make_synApps "${synApps_path}"
