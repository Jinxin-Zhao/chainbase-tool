#!/bin/bash


#set -x

if [ $# != 1 ]; then
	echo "Usage: $0 [filename]"
	exit;
fi

file=$1
prefix="fm_"
new_file=$prefix$1

echo $new_file

sed  's/},/}\n/g' $file > t1.txt 
sed  's/\[/\n/g' t1.txt > t2.txt
sed  '/task_id/,+7d' t2.txt > t3.txt

awk -F \" '{print $4",", $8",", $12",",$16",",$20",",$26}' t3.txt > t.txt

awk 'BEGIN{print("block_number,timestamp,from,to,tx_hash,value")}{print}' t.txt > $new_file

rm t1.txt t2.txt t3.txt t.txt

