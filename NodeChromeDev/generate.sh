#!/bin/bash
VERSION=$1

echo FROM selenium/node-base:$VERSION > ./Dockerfile
cat ../NodeChrome/Dockerfile.txt >> ./Dockerfile
sed -i 's/google-chrome-stable/google-chrome-unstable/' ./Dockerfile
sed -i 's|COPY chrome_launcher.sh /opt/google/chrome/google-chrome|COPY chrome_launcher.sh /opt/google/chrome-beta/google-chrome|' ./Dockerfile
sed -i 's|RUN chmod +x /opt/google/chrome/google-chrome|RUN chmod +x /opt/google/chrome-beta/google-chrome|' ./Dockerfile
sed -i 's|https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip|http://chromedriver-data.storage.googleapis.com/continuous/chromedriver_linux64_2.23.412753.zip|' ./Dockerfile
cp ../NodeChrome/config.json .
cp ../NodeChrome/chrome_launcher.sh .
sed -i 's|export CHROME_VERSION_EXTRA="stable"|export CHROME_VERSION_EXTRA="unstable"|' ./chrome_launcher.sh
