#!/usr/bin/env bash

modeldir=$1

# find zero-size files:
cd $modeldir
# total number of files
totfiles=$(find . | wc -l)
echo "There are $totfiles files in total in $modeldir"

echo "Found " $(find . -size 0 | wc -l) "zero sized files"
echo "Deleting ..."
find . -size 0 -delete

# The ice.log.task files are useless if they have 105 bytes so delete these and look for anything bigger
echo "Found " $(find . -size +105c -iname "ice.log.task_*" | wc -l) " information free ice.log.task files"
echo "Deleting ..."
find . -size 105c -iname "ice.log.task_*" -delete

# put error and pbs logs into compressed tar files
cd error_logs/
tar --remove-files -zcvf$(date +error_logs_%Y-%m-%d.tar.gz) *.err *.out
cd ../pbs_logs/
tar --remove-files -zcvf$(date +pbs_logs_%Y-%m-%d.tar.gz) *.[oe][0-9]*

# total number of files
totfiles=$(find . | wc -l)
echo "There are now $totfiles files in total in $modeldir"