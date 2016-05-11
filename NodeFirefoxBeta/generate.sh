#!/bin/bash
VERSION=$1

echo FROM $KURENTO_REGISTRY_URI/kurento/node-firefox:$VERSION > ./Dockerfile
cat ./Dockerfile.txt >> ./Dockerfile
