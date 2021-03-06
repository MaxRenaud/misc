#!/usr/bin/python
#
# Tracks Duet3d print time predictions and prints the data in CSV format.
# Tested with Python 2.7.16.
# Hit Ctrl-C to stop. 

import json
import time
import urllib

url='http://10.0.0.9/rr_status?type=3'

print 'Duet3 URL: [%s]' % url

def ReportHeader():
  print ','.join([
    'status',
    'printer_time',
    'print_time',
    'layer',
    'fraction',
    'sec_left_layer',
    'sec_left_filament',
    'sec_left_file' ])

def ReportCurrentValues():
  response = urllib.urlopen(url)
  doc = json.loads(response.read())
  #print json.dumps(doc, sort_keys=False, indent=2)
  values = [
    str(doc['status']),
    str(doc['time']),
    str(doc['printDuration']),
    str(doc['currentLayer']),
    str(doc['fractionPrinted']),
    str(doc['timesLeft']['layer']),
    str(doc['timesLeft']['filament']),
    str(doc['timesLeft']['file']),
  ]
  print ','.join(values)

# Main
ReportHeader()
while True:
  ReportCurrentValues()
  time.sleep(60)

