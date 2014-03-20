#!/bin/bash
# Shell  : epics_apps.sh
# Author : Jeong Han Lee
# email  : jhlee@ibs.re.kr
# Date   : Wednesday, February 12 16:28:45 KST 2014
# version : 0.0.1
#
#    * This script may give a little room to install again-and-again
#      Classic EPICS Channel Archiver located at

#
#      I hope it would reduce our time to concentrate real works
#      instead of painful modification of unmaintained source codes.
# 
#   * Must install the following packages via root or sudo
#     before running this script
#
#     For Debian Wheezy,
# 
#
#     Of course, EPICS base, and its extension must be installed
#
#
#
#  - 0.0.1  Wednesday, February  5 00:47:14 KST 2014, jhlee
#           * created
#




# cq   : quiet 
# c    : continue getting a partially-downloaded file. So it allows us not to re-download an existent file
# 
wget_options="wget -c"
# xzf  : quiet
# xzfv : verbose
tar_command="tar xzf"


make_devIocStats()
{
    #    
    #    See
    #    https://www.slac.stanford.edu/grp/cd/soft/epics/site/devIocStats/
    # 
    devIocStats_dir=$1
    cd ${devIocStats_dir}
    
    devIocStats_release="${devIocStats_dir}/configure/RELEASE"
  
    if [ -f $devIocStats_release ]; then
     	mv ${devIocStats_release} ${devIocStats_release}_original
    fi

    touch ${devIocStats_release}
    echo -e 'EPICS_BASE='${EPICS_BASE}'' >> ${devIocStats_release}

    #
    # In my enviroment, thisepicsall.sh sets PATH in EXTENSIONS/bin
    # So, I don't need to set MSI in configure/CONFIG_SITE
    # Wednesday, February 12 18:53:34 KST 2014, jhlee
    #
    # devIocStats_config_site="${devIocStatsdir}/configure/CONFIG_SITE"
    # sed -i~ '/MSI/d' ${devIocStats_release}
    # sed -i '$ a MSI=msi' ${devIocStats_release}

    make

}

#http://sourceforge.net/projects/epics/files/devIocStats/devIocStats-3.1.11.tar.gz/download

#
# EPICS/EPICS_BASE
# EPICS/EPICS_EXTENSIONS
# EPICS/MODULES
# EPICS/APPS

APPS_HOME=${EPICS_BASE}/../apps

mkdir -p ${APPS_HOME}

cd ${APPS_HOME}

###
###  devIocStats 
###  
###  http://sourceforge.net/projects/epics/files/devIocStats/
###  https://www.slac.stanford.edu/grp/cd/soft/epics/site/devIocStats/
###


devIocStats_version="3.1.11"
devIocStats_name="devIocStats-${devIocStats_version}"
devIocStats_filename="${devIocStats_name}.tar.gz"
devIocStats_download_site="http://downloads.sourceforge.net/project/epics/devIocStats/"
devIocStats_link=${devIocStats_download_site}${devIocStats_filename}
devIocStats_path=${APPS_HOME}/${devIocStats_name}

cd ${APPS_HOME}

#echo ${devIocStats_link}

if [ ! -f ${devIocStats_filename} ] 
then
    $wget_options ${devIocStats_link}
fi

$tar_command  ${devIocStats_filename}

make_devIocStats "${devIocStats_path}"





# ###
# ###  EtherIP
# ###  
# ###  http://sourceforge.net/projects/epics/files/ether_ip/
# ###
# ###

# ether_ip_version="2.24.1"
# ether_ip_name="ether_ip-${ether_ip_version}"
# ether_ip_filename="${ether_ip_name}.tgz"
# ether_ip_download_site="http://downloads.sourceforge.net/project/epics/ether_ip/"
# ether_ip_link=${ether_ip_download_site}${ether_ip_filename}



# #http://downloads.sourceforge.net/project/epics/ether_ip/ether_ip-2.24.1.tgz

# cd ${APPS_HOME}

# if [ ! -f ${ether_ip_filename} ] 
# then
#     echo
#     $wget_options ${ether_ip_link}
# fi

# $tar_command  ${ether_ip_filename}
