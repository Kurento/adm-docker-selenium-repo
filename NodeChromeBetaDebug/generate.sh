#!/bin/bash
VERSION=$1

echo FROM kurento/node-chrome-beta:$VERSION > ./Dockerfile
cat ../NodeChromeDebug/Dockerfile.txt >> ./Dockerfile
cp ../NodeChromeDebug/entry_point.sh .
