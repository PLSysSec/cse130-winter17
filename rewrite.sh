for file in $(grep -lR cse130.programming.systems public |grep -v .bak | grep -v .pdf); do
  echo rewriting $file
  sed -i .bak -e "s#cse130.programming.systems#cseweb.ucsd.edu/~dstefan/cse130-winter17#g;" $file
  # sec creates .bak file, let's remove it
  rm -f $file.bak
done
