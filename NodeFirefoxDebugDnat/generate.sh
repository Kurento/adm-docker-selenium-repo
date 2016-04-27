#!/bin/bash
VERSION=$1

echo FROM kurento/node-firefox-debug:$VERSION > ./Dockerfile
echo ./Dockerfile.txt >> ./Dockerfile
