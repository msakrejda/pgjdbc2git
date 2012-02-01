#!/bin/bash

set -e

# List tags in git and check out corresponding tags from CVS
rm -rf cvs-co
mkdir cvs-co
pushd cvs-co
(cd ../pgjdbc-checkout && git tag -l ) | while read tag
do
    cvs co -r "$tag" -d "$tag" pgjdbc
    find -type f | xargs sed -i "s;\\\$Header: $CVSROOT;\$Header: /cvsroot;"
done
popd

# Verify that the tags are correct.
rm -f diff.log
pushd pgjdbc-checkout
git tag -l | while read tag
do 
    git checkout $tag
	diff -r --exclude=CVS --exclude=.git . ../cvs-co/${tag} || true # don't fail on diff
done >> ../diff.log
popd

if [ -s "diff.log" ]
then
	echo "Found differences in diff.log"
	exit 1
fi


