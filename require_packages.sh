#!/bin/bash
# Shell  : require_packages.sh
# Author : Jeong Han Lee
# email  : jhlee@ibs.re.kr
# Date   : Monday, March 16 09:12:52 KST 2015
# version : 0.0.3
#
#   - 0.0.1  December 1 00:01 KST 2014, jhlee
#           * created
#
#   - 0.0.2 Tuesday, December  2 16:28:19 KST 2014, jhlee
#           * seperated package lists according to distribution
#
#   - 0.0.3 Monday, March 16 09:13:20 KST 2015, jhlee
#
#           * better handling the installation package name list
#             so, now we can use one aptitude command to install
#             all packages at once (technically, 2 or 3  instead of
#             total package numbers)
#
#           * comment out "set -e" in order to work at least,
#             don't know how to handle "if any statement returns
#             a non-true return value"   
#             
#
#
# Some errors are printing while installing.....
#
# E: Can not write log (Is stdout a terminal?) - tcgetattr (25: Inappropriate ioctl for device)



## This tells bash that it should exit the script if any statement returns a non-true return value. 
#set -e
#

#
# This will exit your script if you try to use an uninitialised variable
set -u


logfile="/tmp/common_package_installation.log"
common_filename="package_list_common"
package_filename=""



declare -a packagelist

function aptitude_from_list()
{
    unset packagelist
    let i=0
    while IFS= read -r line_data; do
	if [ "$line_data" ]; then
	# Skip command 
	    [[ "$line_data" =~ ^#.*$ ]] && continue
	    packagelist[i]="${line_data}"
	    ((++i))
	fi
    done < $1
    echo "-----"
    echo "aptitude  -q --log-level=info --log-file=$logfile --assume-yes install ${packagelist[@]}"
    echo "-----"
    aptitude  -q --log-level=info --log-file=$logfile --assume-yes install ${packagelist[@]}
}

# #the following logic doesn't handle sudo case....

# user=`whoami`

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

#
# find the current script directory
#
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
common_filepath=${DIR}/${common_filename}

#
# update the repository 
#
aptitude update

echo "Logfile is saving in $logfile"

#
# Read the common package list, and install them with the one "aptitude"
#
aptitude_from_list ${common_filename}
#


#
# Check the distribution version of Debian
#
version=`lsb_release -c | awk '{print $2}'`
#echo $version

# add logic to install some packa
case "$version" in
    wheezy)
#	echo "Wheezy">&2
	package_filename="package_list_wheezy"
	;;
    jessie)
#	echo "Jessie">&2
	package_filename="package_list_jessie"
	;;
    *)
	echo >&2
	echo "Doesn't support $version" >&2
	echo >&2
	exit 0
	;;
esac


#
# Define the log, and read packge list dependent upon the distribution
#
logfile="/tmp/${version}_package_installation.log"
echo "Logfile is saving in $logfile"
package_filepath=${DIR}/${package_filename}

#
# Install the package dependent upon the distribution.
#
aptitude_from_list $package_filepath