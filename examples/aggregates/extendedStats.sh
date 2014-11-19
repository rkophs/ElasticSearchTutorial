#!/bin/bash

#These next two lines are necessary for ensure your environment has the necessary
# installations and sets the address and port number where ES is listening.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "${DIR}/../../config/header.sh"

# "$ADDR" is provided by the ${DIR}/config/header.sh script. (e.g. http://127.0.0.1:9200)

echo "Display the general stats about a state's density for each bucket of states. Buckets are defined by the 2012 state populations."
echo "Also show the states (terms) that contain the majority of these cities for each bucket."
echo

curl -XGET "${ADDR}/test-data/cities/_search?pretty&search_type=count" -d '{
    "aggs": {
        "pupulation_ranges": {
            "range": {
                "field": "population2012",
                "ranges": [
                {"from": "1000000"},
                {"from": "500000", "to": "1000000"},
                {"from": "200000",  "to": "500000"},
                {"from": "0",      "to": "200000"}
                ]
            },
            "aggs": {
                "avg_density": {
                    "extended_stats": {
                        "field": "density"
                    }
                },
                "states": {
                    "terms": {
                        "field": "state",
                        "size":5
                    }
                }
            }
        }
    }
}'

echo
exit
