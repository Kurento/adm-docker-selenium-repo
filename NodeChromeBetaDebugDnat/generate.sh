#!/bin/bash
VERSION=$1

echo FROM kurento/node-chrome-beta-debug:$VERSION > ./Dockerfile
cat ./Dockerfile.txt >> ./Dockerfile
