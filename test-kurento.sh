#!/usr/bin/env bash

[ -n "$BROWSER_IMAGE" ] || exit 1
[ -n "$BROWSER_NAME" ] || exit 1
[ -n "$HUB_VERSION" ] || exit 1
[ -n "$BROWSER_VERSION" ] || exit 1

echo 'Building test container image'
docker build -t selenium/test:local ./Test

echo 'Starting Selenium Hub Container...'
HUB=$(docker run -d selenium/hub:$HUB_VERSION)
HUB_NAME=$(docker inspect -f '{{ .Name  }}' $HUB | sed s:/::)
echo 'Waiting for Hub to come online...'
docker logs -f $HUB &
sleep 2

echo 'Starting Selenium Chrome node...'
NODE=$(docker run -d --link $HUB_NAME:hub -e 'JAVA_OPTS=-Dwebdriver.gecko.driver=/usr/bin/geckodriver' $BROWSER_IMAGE:$BROWSER_VERSION)
docker logs -f $NODE &
echo 'Waiting for node to register and come online...'
sleep 2

function test_node {
  BROWSER=$1
  echo Running $BROWSER test...
  TEST_CMD="node smoke-$BROWSER.js"
  docker run --link $HUB_NAME:hub -e TEST_CMD="$TEST_CMD" selenium/test:local
  STATUS=$?
  TEST_CONTAINER=$(docker ps -aq | head -1)

  if [ ! $STATUS == 0 ]; then
    echo Failed
    exit 1
  fi

  echo Removing the test container
  docker rm $TEST_CONTAINER

}

test_node $BROWSER_NAME

echo Tearing down browser container
docker stop $NODE
docker rm $NODE

echo Tearing down Selenium Hub container
docker stop $HUB
docker rm $HUB

echo Done
