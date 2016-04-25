#!/bin/bash

echo FROM kurento/node-firefox-beta:2.47.1-rc1 > ./Dockerfile
cat ../NodeFirefoxDebug/Dockerfile.txt >> ./Dockerfile
cp ../NodeFirefoxDebug/entry_point.sh .
