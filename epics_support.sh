#!/bin/bash
# Shell  : epics_support.sh
# Author : Jeong Han Lee
# email  : jhlee@ibs.re.kr
# Date   : Wednesday, February 12 16:28:45 KST 2014
# version : 0.0.1
#
#    * This script may give a little room to install again-and-again
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
#  - 0.0.1  Wednesday, February 12 19:26:26 KST 2014, jhlee
#           * created
#           - devIocStats
#           - ether_ip




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



make_ether_ip()
{

    ether_ip_dir=$1
    cd ${ether_ip_dir}
    
    ether_ip_release="${ether_ip_dir}/configure/RELEASE"
  
    if [ -f $ether_ip_release ]; then
     	mv ${ether_ip_release} ${ether_ip_release}_original
    fi

    touch ${ether_ip_release}
    echo -e 'EPICS_BASE='${EPICS_BASE}'' >> ${ether_ip_release}
    echo -e 'ETHER_IP='${ether_ip_dir}'' >> ${ether_ip_release}


    # copy from README file, but I don't understand 4 now
    # Wednesday, February 12 19:25:57 KST 2014, jhlee
    #
    # * II. Build
    # 1. Your usual EPICS environment variables need to be set:
    #    EPICS_HOST_ARCH, PATH to include the EPICS base tools
    # 2. cd where_the_ether_ip_sources_are
    # 3. Edit configure/RELEASE for EPICS BASE and ETHER_IP directory
    #    locations.
    # 4. Edit iocBoot/iocether_ip/Makefile for ARCH
    # 5. make


    #     #
    # In my enviroment, thisepicsall.sh sets PATH in EXTENSIONS/bin
    # So, I don't need to set MSI in configure/CONFIG_SITE
    # Wednesday, February 12 18:53:34 KST 2014, jhlee
    #
    ether_ip_makefile="${ether_ipdir}/iocBoot/iocether_ip/Makefile"
    
    #
    # Use EPICS_HOST_ARCH, so remove all ARCH enviroments in Makefile
    # Wednesday, February 12 19:24:46 KST 2014, jhlee
    #
    sed -i~ '/ARCH/d' ${ether_ip_release}
    
    make

}



#http://sourceforge.net/projects/epics/files/devIocStats/devIocStats-3.1.11.tar.gz/download

#
# EPICS/EPICS_BASE
# EPICS/EPICS_EXTENSIONS
# EPICS/MODULES
# EPICS/APPS

SUPPORT_HOME=${EPICS_BASE}/../support

mkdir -p ${SUPPORT_HOME}

cd ${SUPPORT_HOME}

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
devIocStats_path=${SUPPORT_HOME}/${devIocStats_name}

cd ${SUPPORT_HOME}

#echo ${devIocStats_link}

if [ ! -f ${devIocStats_filename} ] 
then
    $wget_options ${devIocStats_link}
fi

$tar_command  ${devIocStats_filename}

make_devIocStats "${devIocStats_path}"





###
###  EtherIP
###  
###  http://sourceforge.net/projects/epics/files/ether_ip/
###
###



ether_ip_version="2.24.1"
ether_ip_name="ether_ip-${ether_ip_version}"
ether_ip_filename="${ether_ip_name}.tgz"
ether_ip_download_site="http://downloads.sourceforge.net/project/epics/ether_ip/"
ether_ip_link=${ether_ip_download_site}${ether_ip_filename}
ether_ip_path=${SUPPORT_HOME}/${ether_ip_name}

cd ${SUPPORT_HOME}

#echo ${ether_ip_link}

if [ ! -f ${ether_ip_filename} ] 
then
    $wget_options ${ether_ip_link}
fi

$tar_command ${ether_ip_filename} --transform 's/ether_ip/'${ether_ip_name}'/'

#
# tgz file may be created by BSD tar, so it returns the following errors
# by using GNU untar.
# Wednesday, February 12 19:28:03 KST 2014, jhlee
#
# tar: Ignoring unknown extended header keyword `SCHILY.dev'
# tar: Ignoring unknown extended header keyword `SCHILY.ino'
# tar: Ignoring unknown extended header keyword `SCHILY.nlink'
# tar: Ignoring unknown extended header keyword `SCHILY.dev'
# tar: Ignoring unknown extended header keyword `SCHILY.ino'
# tar: Ignoring unknown extended header keyword `SCHILY.nlink'

make_ether_ip "${ether_ip_path}"


