#!/bin/bash

set -e

# List tags in git and check out corresponding tags from CVS
rm -rf cvs-co
mkdir cvs-co
pushd cvs-co
(cd ../pgjdbc-checkout && git tag -l ) | while read tag
do
    cvs co -r "$tag" -d "$tag" pgjdbc
done
popd

# Verify that the tags are correct.
pushd pgjdbc-checkout
git tag -l | while read tag
do 
    git checkout $tag
	diff -r --exclude=CVS --exclude=.git . ../cvs-co/${tag} \
			| grep "\$Header:" -v \
			| egrep -v "^\-\-\-$"  \
			| egrep -v "^[0-9]+c[0-9]+" \
			| grep -v "^diff \-r '\-\-exclude" || true # don't fail on diff
done >> ../diff.log
popd

if [ -s "diff.log" ]
then
	echo "Found differences in diff.log"
	exit 1
fi


