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


logfile="/tmp/common_package_installation.log"
filename="package_list_common"

function local_aptitude()
{
    echo "aptitude  -q --log-level=info --log-file=$logfile --assume-yes install $1"
}

# the following logic doesn't handle sudo case....
# 
# user=`whoami`
# 
# case "$whoami" in
#     root)
# 	continue;
# 	;;
#     *)
# 	echo >&2
# 	echo "You should run $0 script with the root privilege" >&2
# 	echo >&2
# 	exit 0
# 	;;
# esac


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
case "$version" in
   wheezy)
	echo "Wheezy">&2
	filename="package_list_wheezy"
	;;
    jessie)
	echo "Jessie">&2
	filename="package_list_jessie"
	;;
    *)
	echo >&2
	echo "Doesn't support $version" >&2
	echo >&2
	exit 0
	;;
esac

logfile="/tmp/${version}_package_installation.log"

while read -r line           
do
# Skip the empty line
    if [ "$line" ]; then
	# Skip command 
	[[ "$line" =~ ^#.*$ ]] && continue
	local_aptitude $line
    fi
done < $filename


# For example,
# For Wheezy lesstif2-dev
# For Jessi  libmotif-dev

