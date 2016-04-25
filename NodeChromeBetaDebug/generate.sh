#!/bin/bash

echo FROM kurento/node-chrome-beta:2.47.1-rc1 > ./Dockerfile
cat ../NodeChromeDebug/Dockerfile.txt >> ./Dockerfile
cp ../NodeChromeDebug/entry_point.sh .
