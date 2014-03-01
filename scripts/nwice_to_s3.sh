#! /bin/bash

function checkDir {
  echo "Processing $1 to $2"
  for f in $1
  do
    if [ -d $f ] ; then
      if [[ `basename $f` != np_* ]] ; then      
        checkDir "$f/*" "$2"`basename $f`"/"
      fi
    elif [[ `basename $f` != np_* ]] ; then
      dest_f="$2`basename $f`"
      echo "copy $f to $dest_f"
      ~/6998159/s3copy.py -b www.nwice.com -f $f -t $dest_f -p public-read      
    fi
  done
}

checkDir "/home/kevin/nwice/*" "/"
