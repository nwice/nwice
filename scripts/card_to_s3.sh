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
      ~/git/websites/nwice/scripts/s3copy.py -k $EC2_KEY -s $EC2_PASS -b www.card.nwice.com -f $f -t $dest_f -p public-read      
    fi
  done
}

checkDir "/home/kevin/git/card/html/*" "/"
