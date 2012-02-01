#!/bin/bash

set -e

pushd pgjdbc-checkout
# Purge the evils of keywords from the repository
git checkout -b squash-keywords
for branch in master REL{8_2,8_3,8_4,9_0,9_1}_STABLE
do
    git reset --hard origin/${branch}
    # Replace all $PostgreSQL: ... $ custom keywords with just the (relative) file path
	find -type f | xargs sed -i -r 's/\$PostgreSQL: pgjdbc\/(.*),v .*\$\s*$/\1/'
    git commit . -m "Purging keyword expansions"
	git push origin HEAD:${branch}
done
git checkout master
git branch -D squash-keywords
