#!/bin/bash
# Jeong Han Lee
# jhlee@ibs.re.kr
#
# a short cut to cloning site{Libs,Apps}
# Tuesday, March 10 07:29:12 KST 2015, jhlee

#source ${EPICS_BASE}/setEpicsEnv.sh

# This will exit your script if you try to use an uninitialised variable
set -u

cd ${EPICS_BASE}

git clone http://github.com/RaonControl/siteLibs
git clone http://github.com/RaonControl/siteApps