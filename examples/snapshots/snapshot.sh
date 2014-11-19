


#!/bin/bash

#These next two lines are necessary for ensure your environment has the necessary
# installations and sets the address and port number where ES is listening.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "${DIR}/../../config/header.sh"

SNAPSHOT="${DIR}/../../backups/test_backup"

# "$ADDR" is provided by the ${DIR}/config/header.sh script. (e.g. http://127.0.0.1:9200)

echo "1. repository must be registered."
curl -XPUT "${ADDR}/_snapshot/test_backup" -d '{
    "type": "fs",
    "settings": {
        "location": "test_backup",
        "compress": true
    }
}'
echo

echo "2. delete any existing snapshot with name snapshot_1"
curl -XDELETE "${ADDR}/_snapshot/test_backup/snapshot_1"
echo

echo "3. get information about repository."
curl -XGET "${ADDR}/_snapshot/test_backup?pretty"
echo

echo "4. back up test-data index into new snapshot (you may have multiple snapshots of the same index within a repo."
curl -XPUT "${ADDR}/_snapshot/test_backup/snapshot_1?wait_for_completion=true&pretty" -d '{
	"indices":["test-data"]
}'
echo

echo "5. delete the index test-data"
curl -XDELETE "${ADDR}/test-data"
echo

echo "6. assert that a simple query returns no results"
curl -XGET "${ADDR}/test-data/_search?pretty" 
echo

echo "7. restore snapshot for test-data"
curl -XPOST "${ADDR}/_snapshot/test_backup/snapshot_1/_restore?wait_for_completion=true&pretty" -d '{
	"indices":"test-data"
}'
echo 

sleep 2

echo "8. perform query again"
curl -XGET "${ADDR}/test-data/_search?pretty" 
echo