#! /bin/sh
#
# Script to make a tag out of each directory that contains just the
# skeleton files for that release.

git checkout --orphan tags

git rm -r --cache *

for p in *; do
    if [ -d $p ]; then
	rm -rf etc
	cp -r $p/etc .
	git add etc
	git commit -a -m "Copy for $p tag."
	git tag -f $p
    fi
done

git checkout --force master
git reset --hard origin/master
git branch -D tags
