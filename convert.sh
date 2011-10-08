#!/bin/bash

set -e

tar_file=$1

if [ ! -f "$tar_file" ]
then
	echo "Expected path to PostgreSQL JDBC CVS export; got '$tar_file'"
	exit 1
fi

tar -zxf "$tar_file"
mv pgjdbc CVSROOT

cvs2git --dumpfile=dumpfile.dat --blobfile=blobfile.dat --username=repoadmin CVSROOT --encoding=iso-8859-15

mkdir pgjdbc.git
cd pgjdbc.git
git init --bare
cat ../blobfile.dat ../dumpfile.dat | git fast-import

cd ..

git clone pgjdbc.git pgjdbc-non-bare


