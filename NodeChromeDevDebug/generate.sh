#!/bin/bash
VERSION=$1

echo FROM kurento/node-chrome-dev:$VERSION > ./Dockerfile
cat ./Dockerfile.txt >> ./Dockerfile
