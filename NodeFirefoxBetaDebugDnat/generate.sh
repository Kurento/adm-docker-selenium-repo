#!/bin/bash
VERSION=$1

echo FROM kurento/node-firefox-beta-debug:$VERSION > ./Dockerfile
echo ./Dockerfile.txt >> ./Dockerfile
