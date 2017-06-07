#!/bin/bash
#
# This script will replace FROM line in Dockerfile in
# order to use our images instead of Selenium ones

sed -i 's/selenium\/base/kurento\/selenium-base/g' ./Dockerfile

