#!/bin/bash

#These next two lines are necessary for ensure your environment has the necessary
# installations and sets the address and port number where ES is listening.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "${DIR}/../../config/header.sh"

# "$ADDR" is provided by the ${DIR}/config/header.sh script. (e.g. http://127.0.0.1:9200)

echo "Getting all cities with populations in 2012 was larger than 1.3 Million"
echo

curl -XGET "${ADDR}/test-data/cities/_search?pretty" -d '
{
    "query": {
        "range": {
            "population2012": {
                "gte" : 1300000
            }
        }
    }
}
'
echo
exit
