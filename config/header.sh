#!/bin/bash

ADDR="http://127.0.0.1:9200"

CURL_PATH=`which curl`
if [ -z "$CURL_PATH" ]; then
   echo "Please install curl"
   exit
fi
