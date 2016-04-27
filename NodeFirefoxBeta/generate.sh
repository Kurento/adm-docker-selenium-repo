#!/bin/bash
VERSION=$1

echo FROM selenium/node-base:$VERSION > ./Dockerfile
cat ../NodeFirefox/Dockerfile.txt >> ./Dockerfile
sed -i 's|RUN apt-get update -qqy|RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0AB215679C571D1C8325275B9BDB3D89CE49EC21 \\ \n \&\& echo "deb http://ppa.launchpad.net/mozillateam/firefox-next/ubuntu trusty main" >> /etc/apt/sources.list.d/firefox-beta.list \\ \n \&\& apt-get update -qqy \ |' ./Dockerfile
cp ../NodeChrome/config.json .
