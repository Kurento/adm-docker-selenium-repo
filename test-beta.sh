#!/usr/bin/env bash
DEBUG=''

if [ -z "$VERSION" ]; then
  VERSION='2.48.2'
fi

if [ -n "$1" ] && [ $1 == 'debug' ]; then
  DEBUG='-debug'
fi

echo Building test container image
docker build -t selenium/test:local ./Test

echo 'Starting Selenium Hub Container...'
HUB=$(docker run -d selenium/hub:$VERSION)
HUB_NAME=$(docker inspect -f '{{ .Name  }}' $HUB | sed s:/::)
echo 'Waiting for Hub to come online...'
docker logs -f $HUB &
sleep 2

echo 'Starting Selenium Chrome node...'
NODE_CHROME=$(docker run -d --link $HUB_NAME:hub  kurento/node-chrome-beta$DEBUG:$VERSION)
docker logs -f $NODE_CHROME &
echo 'Waiting for nodes to register and come online...'
sleep 2

function test_node {
  BROWSER=$1
  echo Running $BROWSER test...
  TEST_CMD="node smoke-$BROWSER.js"
  docker run -it --link $HUB_NAME:hub -e TEST_CMD="$TEST_CMD" selenium/test:local
  STATUS=$?
  TEST_CONTAINER=$(docker ps -aq | head -1)

  if [ ! $STATUS == 0 ]; then
    echo Failed
    exit 1
  fi

  if [ ! "$CIRCLECI" ==  "true" ]; then
    echo Removing the test container
    docker rm $TEST_CONTAINER
  fi

}

test_node chrome $DEBUG

if [ ! "$CIRCLECI" ==  "true" ]; then
  echo Tearing down Selenium Chrome Beta Node container
  docker stop $NODE_CHROME
  docker rm $NODE_CHROME

  echo Tearing down Selenium Hub container
  docker stop $HUB
  docker rm $HUB
fi

echo Done
