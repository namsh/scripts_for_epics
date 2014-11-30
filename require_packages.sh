#!/bin/bash
# Shell  : require_packages.sh
# Author : Jeong Han Lee
# email  : jhlee@ibs.re.kr
# Date   : 2014.11.30
# version : 0.0.1
#
#   - 0.0.1  December 1 00:01 KST 2014, jhlee
#           * created
#
# Some errors are printing while installing.....
#
# E: Can not write log (Is stdout a terminal?) - tcgetattr (25: Inappropriate ioctl for device)
#

logfile=/tmp/package_installation.log
filename=package_list


aptitude update


while read -r line           
do
# Skip the empty line
    if [ "$line" ]; then
	# Skip command 
	[[ "$line" =~ ^#.*$ ]] && continue
#        echo "aptitude  -q --log-level=info --log-file=$logfile --assume-yes install $line"
	aptitude  -q --log-level=info --log-file=$logfile --assume-yes install $line
    fi
done < $filename

version=`cat /etc/debian_version`
echo $version
# add logic to install some packages which are dependent upon Debian version
# For example,
# For Wheezy lesstif2-dev
# For Jessi  libmotif-dev

