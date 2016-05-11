#!/bin/bash
VERSION=$1

echo FROM kurento/node-firefox-debug:$VERSION > ./Dockerfile
cat ./Dockerfile.txt >> ./Dockerfile
