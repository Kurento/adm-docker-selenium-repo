#!/bin/bash
VERSION=$1

echo FROM kurento/node-firefox:$VERSION > ./Dockerfile
cat ./Dockerfile.txt >> ./Dockerfile
