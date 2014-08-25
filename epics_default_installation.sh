#!/bin/bash
# Shell  : epics_default_installation.sh
# Author : Jeong Han Lee
# email  : jhlee@ibs.re.kr
# Date   : Tuesday, December 31 16:20:08 KST 2013
# version : 0.0.4
#
#   * I intend to develop this script in order to reduce the painful
#     copy and paste from EPICS and its extensions installation logs
#     from everywhere. So only for Linux 64bit Debian for PC and 
#     Rasberian for Raspberry Pi, this script works well.
#     Anyway, it will reduce significantly my time for just installing
#     EPICS and its extenstions.
# 
#
#   * Must install the following packages via root or sudo
#     before running this script
#
#     For Debian Wheezy,
# 
#     aptitude install libreadline-dev  g++ libxt-dev lesstif2-dev x11proto-print-dev libxmu-headers libxp-dev libxmu-dev libxmu6  libxpm-dev libxmuu-dev libxmuu1 libxmu6 
#
#   * EPICS Base and extensionTop
#   * Extensions List
#     - StripTool2_5_15_0 
#     - alh1_2_31 
#     - medm3_1_8_1 
#     - probe1_1_7_1 
#     - msi1-6 
#     - cau_20130110 
#     - dbVerbose_20130124 
#     - gnuregex0_13 
#     - nameserver2_0_0_12
#
#  - 0.0.1  Tue, December 31 16:20:15 KST 2013, jhlee
#           * created
#
#  - 0.0.2  Wed, January   1 02:45    KST 2013, jhlee
#           * make thisepicsall.sh file to provide 
#             users to set EPICS environments easily
#
#  - 0.0.3 Wednesday, January  1 19:26:03 KST 2014, jhlee
#          * refine, .... 
#
#
#
# TO-DO-LIST
# 1. Enviroment settings could add EPICS env again, and again, and again...........
#    it should introduce the better way to reset the old enviroment, 
#     if the old env has EPICS envs. 
# 2. How about Modules, e.g. SEQ, ASYN, and so on. 
# 3. Seperate EPICS base, Extensions, and so on...
#
#  bash epics_default_installation.sh "/data/programs/"
#  install EPICS in /data/programs/epics
#
#  bash epics_default_installation.sh 
#  - install EPICS in ${HOME}/epics
#
# cq   : quiet 
# c    : verbose
wget_options="wget -cq"
# xzf  : quiet
# xzfv : verbose
tar_command="tar xzf"

this_script_name=`basename $0`
LOGDATE=`date +%Y.%m.%d.%H:%M`
epics_download_site="http://www.aps.anl.gov/epics/download/"
host_name=${HOSTNAME}
user_name=${USERNAME}
output_filename="thisepicsall"

make_ext()
{
    extn_name=$1
    extn_filename=${extn_name}.tar.gz 
    cd $EPICS_EXTENSIONS/src
    $wget_options ${epics_download_site}/extensions/${extn_filename}
    $tar_command ${extn_filename}
    cd ${extn_name}
    make  

}   

make_thisepicsall()
{
    output=$1
    echo "#!/bin/bash"  >>$output
    echo "# Shell  : ${output_filename}.sh"  >>$output
    echo "# Author : Jeong Han Lee"    >>$output
    echo "# email  : jhlee@ibs.re.kr"  >>$output
    echo "# Generated at  $LOGDATE"    >>$output
    echo "#           on  $host_name"  >>$output
    echo "#           by  $user_name" >> $output
    echo "# version : 0.0.2"  >>$output
    echo "#   * This script is genenated by $this_script_name." >>$output
    echo "#     In order to setup EPICS base and its extentions correctly," >>$output
    echo "#     please run the following command:">>$output
    echo "#     . thisepicsall.sh " >> $output
    echo "" >>$output
    echo "" >>$output
    echo "export EPICS_HOST_ARCH=${EPICS_HOST_ARCH}" >>$output
    echo "export EPICS_BASE=${EPICS_BASE}" >>$output
    echo "export EPICS_EXTENSIONS=${EPICS_EXTENSIONS}" >>$output
    echo "export PATH=${PATH}" >>$output
    echo "export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}" >>$output
    
    chmod +x $output

    echo ""
    echo "The following command shall setup the EPICS enviroments on your $HOSTNAME."
    echo ". $output"
    echo ""

}


###
###
###  EPICS base
###
###

base_version="3.14.12.4"
base_filename="baseR${base_version}.tar.gz"
base_raw_dirname="base-${base_version}"

if [ -f $1xtn_conf_os ]; then
    mv ${extn_conf_os} ${extn_conf_os}_original
#     sed -e 's/\/usr\/lib64/\/usr\/lib\/'${EXTN_LIB_ARCH}'/g'  ${extn_conf_os}_old > ${extn_conf_os}
fi

if [ -z "${PATH}" ]; then
    PATH=${EPICS_EXTENSIONS}/bin/${EPICS_HOST_ARCH}; 
else
    PATH=${EPICS_EXTENSIONS}/bin/${EPICS_HOST_ARCH}:$PATH; 
fi




target_dir=$1

if [ -z "${target_dir}" ]; then
    target_dir=${HOME}
fi

EPICS=${target_dir}/epics
EPICS_BASE=${EPICS}/${base_raw_dirname}

current_dir=$PWD

mkdir -p ${EPICS}

cd ${EPICS}

$wget_options ${epics_download_site}/base/${base_filename}
$tar_command ${base_filename}

# What are we running on?
# copy the following code from vlinac shell scripts
#  2013.12.31 jhlee
#
case `uname -sm` in
    "Linux i386" | "Linux i486" | "Linux i586" | "Linux i686")
        EPICS_HOST_ARCH=linux-x86

	EXTN_LIB_ARCH=i386-linux-gnu
        ;;
    "Linux x86_64")
        EPICS_HOST_ARCH=linux-x86_64
	EXTN_LIB_ARCH=x86_64-linux-gnu
        ;;
    "Linux armv6l")
	EPICS_HOST_ARCH=linux-arm
	EXTN_LIB_ARCH=arm-linux-gnueabihf
	;;
    *)
        echo "This script  doesn't support this architecture : `uname -sm`"
        exit 1
        ;;
esac

# #
# # export EPICS enviromental settings for compiling...
# #
export EPICS_HOST_ARCH
export EPICS
export EPICS_BASE

cd ${EPICS_BASE}
make clean uninstall
make  -j 


# The following enviroment settings could add EPICS env again, and again, and again....
# it should introduce the better way to reset the old enviroment, if the old env has
# EPICS envs. 
# 2014.1.1  02:35 jhlee

if [ -z "${PATH}" ]; then
    PATH=${EPICS_BASE}/bin/${EPICS_HOST_ARCH}; 
else
    PATH=${EPICS_BASE}/bin/${EPICS_HOST_ARCH}:$PATH; 
fi


if [ -z "${LD_LIBRARY_PATH}" ]; then
    LD_LIBRARY_PATH=${EPICS_BASE}/lib/${EPICS_HOST_ARCH}; 
else
    LD_LIBRARY_PATH=${EPICS_BASE}/lib/${EPICS_HOST_ARCH}:$LD_LIBRARY_PATH;
fi


###
###
###  EPICS extensions
###
###


extn_version="20120904"
extn_filename="extensionsTop_${extn_version}.tar.gz"
extn_raw_dirname="extensions_for_${base_version}"

cd ${EPICS}

$wget_options ${epics_download_site}/extensions/${extn_filename}
$tar_command ${extn_filename} --transform 's/extensions/'${extn_raw_dirname}'/'

EPICS_EXTENSIONS=${EPICS}/${extn_raw_dirname}

export EPICS_EXTENSIONS


# # # #CONFIG_SITE.linux-x86_64.linux-x86_64 file in extensions/configure/os 
# # # # modify 

##
## create  "${EPICS_EXTENSIONS}/configure/RELEASE"
## if the file exists, remove it to name_old, then create one for
## EPICS_BASE and EPICS_EXTENSIONS
## 



extn_release="${EPICS_EXTENSIONS}/configure/RELEASE"

if [ -f $extn_release ]; then
    mv ${extn_release} ${extn_release}_original
#     sed -e 's/..\/base/..\/'${base_raw_dirname}'/g'  ${extn_release}_old > ${extn_release}
fi
touch ${extn_release}
echo -e 'EPICS_BASE=$(TOP)/../'${base_raw_dirname}'' >> $extn_release
echo -e 'EPICS_EXTENSIONS=$(TOP)' >> $extn_release


##
## create  configure/os/CONFIG_SITE.${EPICS_HOST_ARCH}.${EPICS_HOST_ARCH}
## if the file exists, remove it to name_old, then create one according to its EXTN_LIB_ARCH
## 

extn_conf_os="${EPICS_EXTENSIONS}/configure/os/CONFIG_SITE.${EPICS_HOST_ARCH}.${EPICS_HOST_ARCH}"

if [ -f $extn_conf_os ]; then
    mv ${extn_conf_os} ${extn_conf_os}_original
#     sed -e 's/\/usr\/lib64/\/usr\/lib\/'${EXTN_LIB_ARCH}'/g'  ${extn_conf_os}_old > ${extn_conf_os}
fi

touch ${extn_conf_os}
echo -e '-include $(TOP)/configure/os/CONFIG_SITE.linux-x86.linux-x86' >> $extn_conf_os
echo "X11_LIB=/usr/lib/${EXTN_LIB_ARCH}" >>$extn_conf_os
echo "X11_INC=/usr/include" >>$extn_conf_os
echo "MOTIF_LIB=/usr/lib/${EXTN_LIB_ARCH}" >>$extn_conf_os
echo "MOTIF_INC=/usr/include" >> $extn_conf_os
echo "JAVA_DIR=/usr" >>$extn_conf_os
echo "SCIPLOT=YES" >>$extn_conf_os
#
# I don't understand why the following two lines are necessary
# in order to compile medm correctly on linux-x86_64
# jhlee
#
echo "XRTGRAPH_EXTENSIONS ="  >>$extn_conf_os
echo "XRTGRAPH =" >>$extn_conf_os



# #EXTN_LIST="StripTool2_5_15_0"

EXTN_LIST="StripTool2_5_15_0 alh1_2_31 medm3_1_8_1 probe1_1_7_1 msi1-6 cau_20130110 dbVerbose_20130124 gnuregex0_13 nameserver2_0_0_12"


for d in $EXTN_LIST
do
    make_ext $d
done



# The following enviroment settings could add EPICS env again, and again, and again....
# it should introduce the better way to reset the old enviroment, if the old env has
# EPICS envs. 
# 2014.1.1  02:35 jhlee


if [ -z "${PATH}" ]; then
    PATH=${EPICS_EXTENSIONS}/bin/${EPICS_HOST_ARCH}; 
else
    PATH=${EPICS_EXTENSIONS}/bin/${EPICS_HOST_ARCH}:$PATH; 
fi


if [ -z "${LD_LIBRARY_PATH}" ]; then
    LD_LIBRARY_PATH=${EPICS_EXTENSIONS}/lib/${EPICS_HOST_ARCH}; 
else
    LD_LIBRARY_PATH=${EPICS_EXTENSIONS}/lib/${EPICS_HOST_ARCH}:$LD_LIBRARY_PATH;
fi



cd ${current_dir}
#echo $current_dir

outputfile="${current_dir}/${output_filename}.sh"

#echo $outputfile
if [ -f $outputfile ]; then
    echo "EPICS env shell script [$outputfile] already exists"
    echo "Want to overwrite? ( Y/N ) : \c"
    read answer
    if [ "$answer" = "n" ] || [ "$answer" = "N" ]; then
	echo ""
	echo "" 
	echo ""
	echo "You might keep the old file, however, I am sure you will have some trobules."
	echo "If so, please use the following information temporarily. And it works well, "
	echo "please re-run this scipt to overwrite the old script. "
	echo " ---------------------snip snip------------------------"
	echo ""
	echo "export EPICS_HOST_ARCH=${EPICS_HOST_ARCH}"
	echo "export EPICS_BASE=${EPICS_BASE}"
	echo "export EPICS_EXTENSIONS=${EPICS_EXTENSIONS}"
	echo "export PATH=${PATH}" 
	echo "export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}"
	echo ""
	echo " ---------------------snip snip------------------------"
	exit
    fi

    # touch $outputfile
    # echo "#!/bin/bash"  >>$outputfile
    # echo "# Shell  : thisepicsall.sh"  >>$outputfile
    # echo "# Author : Jeong Han Lee"  >>$outputfile
    # echo "# email  : jhlee@ibs.re.kr"  >>$outputfile
    # echo "# Date   : December 31 22:07:00 KST 2013"  >>$outputfile
    # echo "# version : 0.0.1"  >>$outputfile
    # echo "" >>$outputfile
    # echo "" >>$outputfile
    # echo "export EPICS_HOST_ARCH=${EPICS_HOST_ARCH}" >>$outputfile
    # echo "export EPICS_BASE=${EPICS_BASE}" >>$outputfile
    # echo "export EPICS_EXTENSIONS=${EPICS_EXTENSIONS}" >>$outputfile
    # echo "export PATH=${PATH}" >>$outputfile
    # echo "export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}" >>$outputfile
    
    # chmod +x $outputfile
    mv ${outputfile} ${outputfile}_bak
    make_thisepicsall $outputfile

else
    make_thisepicsall $outputfile
fi






exit