#!/usr/bin/python

import sys, getopt, boto
from boto.s3.connection import S3Connection
from boto.s3.key import Key
from socket import gethostname


awskey = ''
awssecretkey = ''
bucket = ''
file = ''
targetfile = ''

def usage():
       print 'usage: s3restore.py -k <awskey> -s <aws-secretkey> -f <inputfile> -b <bucket> -t <targetfile>'
       print '    --file  ,       -f  : input file to copy from S3'
       print '    --targetfile,   -t  : targetfile name'
       print '    --bucket,       -b  : bucket on S3 to copy file from ( will create if not there)'
       print '    --awssecretkey, -a  : aws secret key for access'
       print '    --awskey,       -k  : aws key for access'
       sys.exit()

def loadvalues(argv):
   global awskey
   global awssecretkey
   global bucket
   global file
   global targetfile
   inputfile = ''
   outputfile = ''
   try:
      opts, args = getopt.getopt(argv,"hk:s:f:b:t:",["awskey=", "awssecretkey=","file=","bucket=","targetfile="])
   except getopt.GetoptError:
      usage()
   for opt, arg in opts:
      if opt == '-h':
         usage()
      elif opt in ("-f", "--file"):
         file = arg
      elif opt in ("-t", "--targetfile"):
         targetfile = arg
      elif opt in ("-b", "--bucket"):
         bucket = arg
      elif opt in ("-s", "--awssecretkey"):
         awssecretkey = arg
      elif opt in ("-k", "--awskey"):
         awskey = arg

def restore():
   global awskey
   global awssecretkey
   global bucket
   global file
   global targetfile
   con = S3Connection(awskey, awssecretkey)
   targetBucket = con.create_bucket(bucket)
   k = Key(targetBucket)
   k.key = file
   k.get_contents_to_filename(targetfile)


if __name__ == "__main__":
        loadvalues(sys.argv[1:])
        restore();


