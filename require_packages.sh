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

function local_aptitude()
{
    package_name = $1
    aptitude  -q --log-level=info --log-file=$logfile --assume-yes install $package_name
}


aptitude update


while read -r line           
do
# Skip the empty line
    if [ "$line" ]; then
	# Skip command 
	[[ "$line" =~ ^#.*$ ]] && continue
#        echo "aptitude  -q --log-level=info --log-file=$logfile --assume-yes install $line"
#	aptitude  -q --log-level=info --log-file=$logfile --assume-yes install $line
	local_aptitude $line
    fi
done < $filename

version=`lsb_release -c | awk '{print $2}'`
echo $version


# add logic to install some packa
case "$DO" in

    local)
ges which are dependent upon Debian version
# For example,
# For Wheezy lesstif2-dev
# For Jessi  libmotif-dev

