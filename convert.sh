#!/bin/bash

set -e

tar_file=$1

if [ ! -f "$tar_file" ]
then
	echo "Expected path to PostgreSQL JDBC CVS export; got '$tar_file'"
	exit 1
fi

if [ -z "$CVS2GIT_HOME" ]
then
    echo "Expected CVS2GIT_HOME environment variable pointing to root of cvs2git code checkout."
    echo "The current release version of cvs2git does not work with our configuration file."
	echo "The trunk version can be checked out via"
	echo 'svn co --username=guest --password="" http://cvs2svn.tigris.org/svn/cvs2svn/trunk cvs2svn-trunk'
    exit 1
fi

# Clean up and extract a fresh copy from the CVS repository archive
rm -rf CVSROOT pgjdbc.git pgjdbc-checkout cvs2svn-tmp
tar -zxf "$tar_file"

# Relabel tag REL7_1 as REL7_1_BETA in various files that were deleted between
# the original placement of that tag and its renaming.  The renaming action
# evidently missed files that'd been deleted in between.
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/Attic/README_6.3
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/org/postgresql/xa/Attic/Test.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/Attic/Connection.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/Attic/Driver.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/Attic/Field.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/Attic/PG_Stream.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/Attic/ResultSet.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/Attic/errors.properties
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/Attic/errors_fr.properties
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/fastpath/Attic/Fastpath.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/fastpath/Attic/FastpathArg.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/geometric/Attic/PGbox.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/geometric/Attic/PGcircle.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/geometric/Attic/PGline.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/geometric/Attic/PGlseg.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/geometric/Attic/PGpath.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/geometric/Attic/PGpoint.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/geometric/Attic/PGpolygon.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/jdbc1/Attic/CallableStatement.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/jdbc1/Attic/Connection.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/jdbc1/Attic/DatabaseMetaData.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/jdbc1/Attic/PreparedStatement.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/jdbc1/Attic/ResultSet.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/jdbc1/Attic/ResultSetMetaData.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/jdbc1/Attic/Statement.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/jdbc2/Attic/CallableStatement.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/jdbc2/Attic/Connection.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/jdbc2/Attic/DatabaseMetaData.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/jdbc2/Attic/PreparedStatement.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/jdbc2/Attic/ResultSet.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/jdbc2/Attic/ResultSetMetaData.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/jdbc2/Attic/Statement.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/largeobject/Attic/LargeObject.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/largeobject/Attic/LargeObjectManager.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/util/Attic/PGmoney.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/util/Attic/PGobject.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/util/Attic/PGtokenizer.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/util/Attic/PSQLException.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/util/Attic/Serialize.java
rcs -x,v -nREL7_1_BETA:REL7_1 pgjdbc/postgresql/util/Attic/UnixCrypt.java

rcs -x,v -nREL7_1 pgjdbc/Attic/README_6.3
rcs -x,v -nREL7_1 pgjdbc/org/postgresql/xa/Attic/Test.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/Attic/Connection.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/Attic/Driver.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/Attic/Field.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/Attic/PG_Stream.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/Attic/ResultSet.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/Attic/errors.properties
rcs -x,v -nREL7_1 pgjdbc/postgresql/Attic/errors_fr.properties
rcs -x,v -nREL7_1 pgjdbc/postgresql/fastpath/Attic/Fastpath.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/fastpath/Attic/FastpathArg.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/geometric/Attic/PGbox.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/geometric/Attic/PGcircle.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/geometric/Attic/PGline.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/geometric/Attic/PGlseg.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/geometric/Attic/PGpath.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/geometric/Attic/PGpoint.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/geometric/Attic/PGpolygon.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/jdbc1/Attic/CallableStatement.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/jdbc1/Attic/Connection.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/jdbc1/Attic/DatabaseMetaData.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/jdbc1/Attic/PreparedStatement.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/jdbc1/Attic/ResultSet.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/jdbc1/Attic/ResultSetMetaData.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/jdbc1/Attic/Statement.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/jdbc2/Attic/CallableStatement.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/jdbc2/Attic/Connection.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/jdbc2/Attic/DatabaseMetaData.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/jdbc2/Attic/PreparedStatement.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/jdbc2/Attic/ResultSet.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/jdbc2/Attic/ResultSetMetaData.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/jdbc2/Attic/Statement.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/largeobject/Attic/LargeObject.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/largeobject/Attic/LargeObjectManager.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/util/Attic/PGmoney.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/util/Attic/PGobject.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/util/Attic/PGtokenizer.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/util/Attic/PSQLException.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/util/Attic/Serialize.java
rcs -x,v -nREL7_1 pgjdbc/postgresql/util/Attic/UnixCrypt.java

# Finally, manually patch assorted files in which the file was added to
# mainline and then back-patched into release branches at a significantly
# later point.  The CVS repository fails to show that these files didn't
# exist on the back branch right along, so we need a hack to show that.
# NOTE: the log messages for the dead revisions must match a regexp
# inside cvs2git, or it won't do what we want with these.

for patch in $PWD/patches/*.patch
do
    patched_files="$(grep -a ^diff $patch | awk '{ print $NF }')"
    pushd pgjdbc
    chmod u+w $patched_files
    patch -p0 < $patch
    chmod u-w $patched_files
	popd
done

mkdir CVSROOT
mv pgjdbc CVSROOT

$CVS2GIT_HOME/cvs2git --options=c2g.config.py --encoding=iso-8859-15

mkdir pgjdbc.git
cd pgjdbc.git
git init --bare
cat ../cvs2svn-tmp/git-blob.dat ../cvs2svn-tmp/git-dump.dat | git fast-import

cd ..

git clone pgjdbc.git pgjdbc-checkout

# Fix up the REL6_4 branch, which cvs2git puts in the wrong place (it's easier
# to fix here than in CVS):
cd pgjdbc-checkout
git checkout -b REL6_4 $(git log --format='%H' --grep 'Remove various files that were moved to various subdirectories...')
git push --force origin REL6_4
git checkout master
git branch -d REL6_4

# Something like the following can be used to change the IDENTIFIER tags that
# JDBC uses into just the file names (as the PostgreSQL core project did)
#
# find -type f | xargs sed -i -r 's/\$PostgreSQL: pgjdbc\/(.*),v .*\$\s*$/\1/'
#