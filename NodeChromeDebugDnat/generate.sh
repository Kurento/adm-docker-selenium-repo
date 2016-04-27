#!/bin/bash
VERSION=$1

echo FROM kurento/node-chrome-debug:$VERSION > ./Dockerfile
echo ./Dockerfile.txt >> ./Dockerfile
