#!/bin/bash
VERSION=$1

echo FROM kurento/node-firefox-beta:$VERSION > ./Dockerfile
cat ./Dockerfile.txt >> ./Dockerfile
