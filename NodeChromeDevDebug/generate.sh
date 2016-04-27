#!/bin/bash
VERSION=$1

echo FROM kurento/node-chrome-dev:$VERSION > ./Dockerfile
cat ../NodeChromeDebug/Dockerfile.txt >> ./Dockerfile
cp ../NodeChromeDebug/entry_point.sh .
