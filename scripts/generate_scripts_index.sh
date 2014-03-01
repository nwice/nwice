#! /bin/bash
# script to remove index.html and recreate with url agument
if [ -f /home/kevin/git/websites/nwice/scripts/index.html ]
then
	echo 'removing index.html'
	rm /home/kevin/git/websites/nwice/scripts/index.html
fi
wget -O /tmp/index.html http://localhost/scripts/
mv /tmp/index.html /home/kevin/git/websites/nwice/scripts/index.html
