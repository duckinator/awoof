#!/bin/bash

rm -rf pngs
mkdir -p pngs
pushd pngs

convert -crop 16x16 +repage ../awoof.png awoof-%d.png

for x in $(find -type f); do
  OLD=$x
  NEW=$(echo $x | sed 's/\-\([0-9][0-9]\)\./-0\1./' | sed 's/\-\([0-9]\)\./-00\1./')

  mv $OLD $NEW
done

popd
