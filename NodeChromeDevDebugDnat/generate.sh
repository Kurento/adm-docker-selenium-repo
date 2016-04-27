#!/bin/bash
VERSION=$1

echo FROM kurento/node-chrome-dev-debug:$VERSION > ./Dockerfile
echo ./Dockerfile.txt >> ./Dockerfile
