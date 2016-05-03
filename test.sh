#!/usr/bin/env bash
DEBUG=''

if [ -n "$1" ] && [ $1 == 'debug' ]; then
  DEBUG='-debug'
fi

# Due to the dependency GNU sed, we're skipping this part when running
# on Mac OS X.
if [ "$(uname)" != 'Darwin' ] ; then
  echo 'Testing shell functions...'
  which bats > /dev/null 2>&1
  if [ $? -ne 0 ] ; then
    echo "Could not find 'bats'. Please install it first, e.g., following https://github.com/sstephenson/bats#installing-bats-from-source."
    exit 1
  fi
  NodeBase/test-functions.sh || exit 1
else
  echo 'Skipping shell functions test on Mac OS X.'
fi

echo Building test container image
docker build -t selenium/test:local ./Test

echo 'Starting Selenium Hub Container...'
HUB=$(docker run -d selenium/hub:2.53.0)
HUB_NAME=$(docker inspect -f '{{ .Name  }}' $HUB | sed s:/::)
echo 'Waiting for Hub to come online...'
docker logs -f $HUB &
sleep 2

echo 'Starting Selenium Chrome node...'
NODE_CHROME=$(docker run -d --link $HUB_NAME:hub  selenium/node-chrome$DEBUG:2.53.0)
echo 'Starting Selenium Firefox node...'
NODE_FIREFOX=$(docker run -d --link $HUB_NAME:hub selenium/node-firefox$DEBUG:2.53.0)
docker logs -f $NODE_CHROME &
docker logs -f $NODE_FIREFOX &
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
test_node firefox $DEBUG

if [ ! "$CIRCLECI" ==  "true" ]; then
  echo Tearing down Selenium Chrome Node container
  docker stop $NODE_CHROME
  docker rm $NODE_CHROME

  echo Tearing down Selenium Firefox Node container
  docker stop $NODE_FIREFOX
  docker rm $NODE_FIREFOX

  echo Tearing down Selenium Hub container
  docker stop $HUB
  docker rm $HUB
fi

echo Done
