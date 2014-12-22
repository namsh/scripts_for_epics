#!/usr/bin/python
# coding=utf-8 
#
# Shell   : getData.py
# Author  : Jeong Han Lee
# email   : jhlee@ibs.re.kr
# Date    : Friday, December 19 10:18:02 KST 2014
# Version : 0.1.0
#
#   * I intend to develop this script in order to extact or get data from
#     Archiver Appliance Service, which is running on an Ethernet accessiable
#     server. This script creates a file per a PV. In one example,
#     
#    # Filename    : /tmp/pi2_dht11_tem.txt
#    # PV name     : PI2:DHT11:TEM
#    # From        : 2014-12-15T19:15:02.200201
#    # To          : 2014-12-22T19:15:02.200201
#    # queryString : ?pv=mean_300(PI2:DHT11:TEM)&from=2014-12-15T19%3A15%3A02.200201%2B09%3A00&to=2014-12-22T19%3A15%3A02.200201%2B09%3A00
#    # hostname    : kaffee
#    # host IP     : 10.1.4.24
#    # 
#    # time, val, nanos, status, severity
#    2014-12-19T11:07:30, 22.4814814815, 0, 0, 0 
#    2014-12-19T11:12:30, 22.45, 0, 0, 0 
#    2014-12-19T11:17:30, 21.6279069767, 0, 0, 0 
#    2014-12-19T11:22:30, 21.4333333333, 0, 0, 0 
#    2014-12-19T11:27:30, 21.4936708861, 0, 0, 0 
#    2014-12-19T11:32:30, 21.4791666667, 0, 0, 0 
#
#     By default, time is the mean over 5 mins. 
#    
#  * The created files are located in /tmp/ and copy them in to /var/www/data directory.   
#    In there, another scripts read these files, and generate a *static* web site by using
#    SIMILE Timeplot. See http://www.simile-widgets.org/timeplot/
#
#
#  - 0.0.0  Friday, December 19 10:18:02 KST 2014
#           Created.
#  - 0.1.1  Monday, December 22 19:19:27 KST 2014
#           Real Working Script...
#
#     crontab -e, add the following line
#
#* *  * * * export DISPLAY=:0.0 && /usr/bin/python /where/the/script/is/getData.py >/dev/null 2>&1
# */5 *  * * * export DISPLAY=:0.0 && /usr/bin/python /home/jhlee/programming/scripts/python/archiver.appliance/getData.py -i 10.1.4.173 -d 7 >/dev/null 2>&1

import os
import sys
import argparse 
import socket
import shutil
# import numpy as np
from chaco.shell import *

import urllib
import urllib2
import json
from datetime import timedelta, datetime, date


# epoch_secs : 
# This is the Java epoch seconds of the EPICS record processing timestamp. The times are in UTC; so any conversion to local time needs to happen at the client. 

def convertDate(epoch_secs):
    _date = datetime.fromtimestamp(epoch_secs)
    return _date.isoformat()

#    s = ''.join(dataList)
    

def setMGMTurl(url):
    return url + "/mgmt/bpl/"


def getAllPVs(url, patterns):
    applianceMGMTUrl= url + "/mgmt/bpl/getAllPVs"
    pv_list= []

    #    print "patterns :", patterns
    #    print "mgmturl  :", applianceMGMTUrl
    #    print patterns.split()

    for pattern in patterns.split():
#        print pattern
#        print urllib.urlencode({"pv" : pattern})
        resp = urllib2.urlopen(url= applianceMGMTUrl + "?" + urllib.urlencode({"pv" : pattern}))
        matchingPVs = json.load(resp)
        pv_list.extend(matchingPVs)

    return pv_list


def print_data_info(element):
    #  {u'nanos': 887037220, u'status': 0, u'secs': 1418979266, u'severity': 0, u'val': 24.0}
    
#    print element.nanos
    return 

def setJsonRetUrl(url):
    return url + "/retrieval/data/getData.json"

def setRawRetUrl(url):
    return url + "/retrieval/data/getData.raw"

def main():

#   https://docs.python.org/2/howto/argparse.html
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--ip", help="This is the URL for appliance")
    parser.add_argument("-p", "--pattern", help="PVs patterns")
    parser.add_argument("-v", "--verbose", action="store_true", help="increase output verbosity")
    parser.add_argument("-d", "--days", type=float, help="how many days do you want to monitor from now")
    args = parser.parse_args()

    if not args.ip :
        args.ip = "10.1.4.173"

    # if(len(args.pattern) > 1):
    #     PVPatterns.extend(args.pattern))
    if not args.pattern :
        args.pattern = "*"
        
    if not args.days :
        args.days = 7.0

    url = "http://" + args.ip + ":17665"
    if args.verbose:
        print ""
        print ">>>" 
        print ">>> Default URL and Pattern are used as follows:"
        print ">>>  URL :" + url
        print ">>>  Pattern : " + args.pattern
        print ">>>"
        

    matchingPVs = []
    matchingPVs =  getAllPVs(url, args.pattern)

#    print "Total length" , len(matchingPVs)

    _now = datetime.now()
    
#    print "now : ", _now
    _td = timedelta(days=args.days)
    _from = _now - _td
#    _from = datetime(2014,12,19,17,40,00,00)


#    _from_string = _from.strftime("%Y-%m-%dT%H:%M:%S")
#    _now_string  = _now.strftime ("%Y-%m-%dT%H:%M:%S")
#    "From" and "To" have the iso time format at  http://epicsarchiverap.sourceforge.net/userguide.html
#    Python datetime has the isoformat at https://docs.python.org/2/library/datetime.html
#   Monday, December 22 13:42:51 KST 2014, jhlee

    _from_iso_string = _from.isoformat()
    _now_iso_string  = _now.isoformat()
    

    fromString = urllib.urlencode( {'from' : _from_iso_string} ) 
    toString   = urllib.urlencode( {'to'   : _now_iso_string } )
 #   userString = urllib.urlencode( {'userreduced' : "true"} )


#   Still don't understand what the following Strings means,
#   get the structure form archiveViewer, and simply add only 
#   magicString to queryString  
#  
#   Monday, December 22 10:40:19 KST 2014, jhlee
#
    magicString = "%2B09%3A00"
    # http://en.wikipedia.org/wiki/Percent-encoding
    # %2B : "+"
    # %3A : ":"
    # userString  = "&usereduced=true"
    # cahowString = "&ca_how=0"
    # cacountString = "&ca_count=1907"

    suffixString = magicString
    # suffixString = magicString# + userString + cahowString + cacountString

    if args.verbose:
        print "fromString : ",  fromString
        print "toString   : ",  toString
        print "userString : ",  userString
        print ""

    hostname = socket.gethostname() 
    hostip   = socket.gethostbyname(hostname)
    
    report_filename = ""
    dest_directory = "/var/www/data/"

    for pv in sorted(matchingPVs):
        
        report_filename = "/tmp/" + pv.replace(":", "_").lower() + ".txt"
        queryString = '?pv=mean_300(' + pv + ')'
        queryString += '&'
        queryString += fromString
        queryString += magicString
        queryString += '&'
        queryString += toString 
        queryString += suffixString

        #+ From + To
#        print queryString
#        print ""
        dataresp = urllib2.urlopen(setJsonRetUrl(url) + queryString)
        data = json.load(dataresp)
        #       print "Total Data Size " , len(data[0]['data'])
        # print ">>> ", data[0]['data'][0]
        #       print data[0]['data']
    	# # typeInfo = json.load(urllib2.urlopen(setMGMTurl(url) + 'getPVTypeInfo?' + queryString))
        # # if typeInfo: 
        # #     dataStores = typeInfo['dataStores']
        # #     print dataStores


        
        try :
            file = open(report_filename, "w")
            file.write("# \n")
            file.write("# Filename    : " + report_filename + "\n")
            file.write("# PV name     : " + pv + "\n")
            file.write("# From        : " + _from_iso_string + "\n")
            file.write("# To          : " + _now_iso_string + "\n")
            file.write("# queryString : " + queryString + "\n")
            file.write("# hostname    : " + hostname + "\n")
            file.write("# host IP     : " + hostip   + "\n")
            file.write("# \n")
            file.write("# time, val, nanos, status, severity\n")

            dataList = []

            for el in data[0]['data']:

#               print type(el) ; returns <type 'dict'> 


#               print el; returns {u'nanos': 887056444, u'status': 0, u'secs': 1418979584, u'severity': 0, u'val': 25.0}
#
#                print "%s, %s  \n" % (el['secs'], datetime.fromtimestamp(el['secs']))

                dataList.append("%s, %s, %s, %s, %s \n" % (convertDate(el['secs']), el['val'], el['nanos'], el['status'], el['severity']))

                
            s = ''.join(dataList)
            file.write(s)
            file.close()

 
            shutil.copy (report_filename, dest_directory)

        except IOError, (errno, strerror):
            print "I/O error(%s): %s" % (errno, strerror)



        # plot(secs, vals, "r-")
        # xscale('time')
        # show()



    sys.exit()

if __name__ == '__main__': main()

