#!/bin/bash
VERSION=$1

echo FROM kurento/node-firerox-beta:$VERSION > ./Dockerfile
cat ./Dockerfile.txt >> ./Dockerfile
