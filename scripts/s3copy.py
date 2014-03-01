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
acl = 'private'

def usage():
       print 'usage: s3copy.py -k <awskey> -s <aws-secretkey> -f <inputfile> -b <bucket> -t <targetfile> -p <acl>'
       print '    --file  ,       -f  : input file to copy to S3'
       print '    --targetfile,   -t  : targetfile name'
       print '    --bucket,       -b  : bucket on S3 to copy file to ( will create if not there)'
       print '    --awssecretkey, -a  : aws secret key for access'
       print '    --awskey,       -k  : aws key for access'
       print '    --acl,          -p  : acl publish setting'
       sys.exit()

def loadvalues(argv):
   global awskey
   global awssecretkey
   global bucket
   global file
   global targetfile
   global acl
   inputfile = ''
   outputfile = ''
   try:
      opts, args = getopt.getopt(argv,"hk:s:f:b:t:p:",["awskey=", "awssecretkey=","file=","bucket=","targetfile=","acl="])
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
      elif opt in ("-p", "--acl"):
         acl = arg

def copy():
   global awskey
   global awssecretkey
   global bucket
   global file
   global targetfile
   global acl
   con = S3Connection(awskey, awssecretkey)
   targetBucket = con.create_bucket(bucket)
   k = Key(targetBucket)
   k.key = targetfile
   k.set_contents_from_filename(file)
   if acl in ('private', 'public-read', 'public-read-write', 'authenticated-read'):
	k.set_acl(acl)


if __name__ == "__main__":
        loadvalues(sys.argv[1:])
        copy();

