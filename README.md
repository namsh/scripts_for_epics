scripts_for_epics
=================

Some Installation scripts for EPICS base and its selected extensions



1. epics_default_installation.sh

   bash epics_default_installation.sh

  * I intend to develop this script in order to reduce the painful
    copy and paste from EPICS and its extensions installation logs
    from everywhere. So only for Linux 64bit Debian for PC and 
    Rasberian for Raspberry Pi, this script works well.
    Anyway, it will reduce significantly my time for just installing
    EPICS and its extenstions.
 
  * Must install the following packages via root or sudo
    before running this script

    For Debian Wheezy,
    aptitude install libreadline-dev  g++ libxt-dev lesstif2-dev x11proto-print-dev libxmu-headers libxp-dev libxmu-dev libxmu6  libxpm-dev libxmuu-dev libxmuu1 libxmu6 

  * EPICS Base and extensionTop
  * Extensions List
     - StripTool2_5_15_0 
     - alh1_2_31 
     - medm3_1_8_1 
     - probe1_1_7_1 
     - msi1-6 
     - cau_20130110 
     - dbVerbose_20130124 
     - gnuregex0_13 
     - nameserver2_0_0_12


2. chanarch.sh

   bash chanarch.sh

   This script may give a little room to install again-and-again 
   the Classic EPICS Channel Archiver located at 
   http://sourceforge.net/projects/epicschanarch/

   I hope it would reduce our time to concentrate real works
   instead of painful modification of unmaintained source codes.
 
   Must install the following packages via root or sudo
   before running this script
   For Debian Wheezy,

   aptitude install libxmlrpc-c++4-dev  libxerces-c-dev  libcurl3-dev 

   Of course, EPICS base, and its extension must be installed
