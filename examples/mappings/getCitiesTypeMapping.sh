#!/bin/bash

#These next two lines are necessary for ensure your environment has the necessary
# installations and sets the address and port number where ES is listening.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "${DIR}/../../config/header.sh"

# "$ADDR" is provided by the ${DIR}/config/header.sh script. (e.g. http://127.0.0.1:9200)

curl -XGET "${ADDR}/test-data/cities/_mapping?pretty" 
