#!/bin/bash
VERSION=$1

echo FROM kurento/node-firefox-beta:$VERSION > ./Dockerfile
cat ../NodeFirefoxDebug/Dockerfile.txt >> ./Dockerfile
cp ../NodeFirefoxDebug/entry_point.sh .
