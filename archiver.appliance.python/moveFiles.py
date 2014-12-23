#!/usr/bin/python
# coding=utf-8 
#
# Shell   : moveFiles.py
# Author  : Jeong Han Lee
# email   : jhlee@ibs.re.kr
# Date    : 
# Version : 0.1.0
#
#     crontab -e, add the following line
#
#* *  * * * export DISPLAY=:0.0 && /usr/bin/python /where/the/script/is/getData.py >/dev/null 2>&1
# */5 *  * * * export DISPLAY=:0.0 && /usr/bin/python /home/jhlee/programming/scripts/python/archiver.appliance/getData.py -i 10.1.4.173 -d 7 >/dev/null 2>&1

import os
import sys
import shutil
# import numpy as np
#from chaco.shell import *
import socket
from datetime import timedelta, datetime, date



def main():


#    print "Total length" , len(matchingPVs)

    _now = datetime.now()
    
    print _now

    _now_iso_string  = _now.isoformat()
    
    hostname = socket.gethostname() 
    hostip   = socket.gethostbyname(hostname)
    
    capture_filename1 = "munji-pi0"
    capture_filename2 = "munji-pi1"

    dest_directory = "/var/www/images/"

    fileList =[]

    fileList.append(capture_filename1)
    fileList.append(capture_filename2)

    temp_filename = ""

#    print fileList

    for afile in sorted(fileList):
        
        temp_filename = "/home/ctrluser/pi_camera_captures/" + afile
        dest_filename = dest_directory + _now_iso_string + "_" + afile + ".jpg"

#        shutil.copy (temp_filename, dest_directory)
#        print temp_filename, dest_filename
        shutil.copyfile (temp_filename, dest_filename)

        # plot(secs, vals, "r-")
        # xscale('time')
        # show()



    sys.exit()

if __name__ == '__main__': main()

