#! /bin/sh

repo=mkz@cvs.pgfoundry.org:/cvsroot/jdbc
c2g=/opt/src/vcs/cvs2svn/cvs2git
dst=git@github.com:markokr/pgjdbc-test.git


rsync -avz --delete $repo/pgjdbc .

rm -rf cvs2svn-tmp pgjdbc.git
mkdir -p cvs2svn-tmp pgjdbc.git

$c2g --options=c2g.config.py

# create repo
cd pgjdbc.git
git init
cat ../cvs2svn-tmp/git-blob.dat ../cvs2svn-tmp/git-dump.dat | git fast-import

# compress better
git repack -a -d -f

# checkout source
git checkout master

# push somewhere
git remote add dst $dst
git push -f --mirror dst

