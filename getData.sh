#!/bin/bash -v

#set -x
# echo $#
if [ $# != 2 ]; then
	echo "Usage: $0 [task_id] [filename]"
	exit;
fi

taskID=$1
file=$2
echo $taskID

for i in {1..100}
do
curl -X "POST" "https://api.chainbase.online/v1/dw/query" \
     -H 'x-api-key: 2FRSuc9VljxMZpcXmVUdgvpXGFU' \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
        "task_id": "'$1'",
        "page": '$i'
}' >> $file
done

