#! /bin/bash
# script to download my github rss and publish to www.nwice.com

wget -O /tmp/github_rss.xml https://github.com/kmcintyre.atom
diff /tmp/github_rss.xml ~/nwice/github_rss.xml
cp /tmp/github_rss.xml ~/nwice/github_rss.xml
~/6998159/s3copy.py -b www.nwice.com -f ~/nwice/github_rss.xml -t github_rss.xml -p public-read

#
# I used to check to see if the file was different...
#
#if diff /tmp/github_rss.xml /home/kevin/nwice/github_rss.xml >/dev/null ; then
  #echo Same
  #rm /tmp/github_rss.xml
#else
#  diff /tmp/github_rss.xml /home/kevin/nwice/github_rss.xml
#  cp /tmp/github_rss.xml /home/kevin/nwice/github_rss.xml
#  ~/6998159/s3copy.py -b www.nwice.com -f /tmp/github_rss.xml -t github_rss.xml -p public-read
#fi
