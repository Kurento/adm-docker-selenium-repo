#!/bin/bash
VERSION=$1

echo FROM kurento/node-chrome-beta:$VERSION > ./Dockerfile
cat ./Dockerfile.txt >> ./Dockerfile
