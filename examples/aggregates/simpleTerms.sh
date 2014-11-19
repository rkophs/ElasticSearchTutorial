#!/bin/bash

#These next two lines are necessary for ensure your environment has the necessary
# installations and sets the address and port number where ES is listening.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "${DIR}/../../config/header.sh"

# "$ADDR" is provided by the ${DIR}/config/header.sh script. (e.g. http://127.0.0.1:9200)

echo "Display the word counts of top 5 most popular words within each state's state tree."
echo

curl -XGET "${ADDR}/test-data/states/_search?pretty" -d '{
    "query": {
        "match_all": { }
    },
    "aggs": {
        "popular_tree_words": {
            "terms": {
                "field": "tree",
                "size":5
            }
        }
    },
    "size":0
}'

echo
exit