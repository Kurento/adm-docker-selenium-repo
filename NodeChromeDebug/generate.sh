#!/bin/bash
VERSION=$1

echo FROM kurento/node-chrome:$VERSION > ./Dockerfile
cat ./Dockerfile.txt >> ./Dockerfile
