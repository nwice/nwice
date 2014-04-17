#!/usr/bin/python

import sys, getopt, boto
from boto.s3.connection import S3Connection
from boto.s3.key import Key
from socket import gethostname


awskey = ''
awssecretkey = ''
bucket = ''
prefix = ''

def usage():
       print 'usage: s3copy.py -k <awskey> -s <aws-secretkey> -b <bucket> -p <prefix>'
       print '    --bucket,       -b  : bucket on S3 to copy file to ( will create if not there)'
       print '    --awssecretkey, -a  : aws secret key for access'
       print '    --awskey,       -k  : aws key for access'
       print '    --prefix,       -p  : prefix'
       sys.exit()

def loadvalues(argv):
   global awskey
   global awssecretkey
   global bucket
   global prefix
   try:
      opts, args = getopt.getopt(argv,"hk:s:f:b:t:p:",["awskey=", "awssecretkey=","bucket=","prefix="])
   except getopt.GetoptError:
      usage()
   for opt, arg in opts:
      if opt == '-h':
         usage()
      elif opt in ("-b", "--bucket"):
         bucket = arg
      elif opt in ("-s", "--awssecretkey"):
         awssecretkey = arg
      elif opt in ("-k", "--awskey"):
         awskey = arg
      elif opt in ("-p", "--prefix"):
         prefix = arg         
def list():
   global awskey
   global awssecretkey
   global bucket
   global prefix
   con = S3Connection(awskey, awssecretkey)
   targetBucket = con.create_bucket(bucket)
   keys = targetBucket.list(prefix=prefix)
   for key in keys:
       if key.name.endswith(".sh") or key.name.endswith(".py"):
           print key.name         
           key.copy(targetBucket.name, key.name, {'Content-Type':'text/plain'}, preserve_acl=True)
       	           	   
   	       
if __name__ == "__main__":
   loadvalues(sys.argv[1:])
   list();