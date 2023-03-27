#!/bin/bash
set -x

# smart contract address
bnb=0xB8c77482e45F1F44dE1745F52C74426C631bDD52
uniswap=0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984
#sushiswap:
sushiToken=0x6B3595068778DD592e39A122f4f5a5cF09C90fE2
curve=0xD533a949740bb3306d119CC777fa900bA034cd52
blur=0x5283D291DBCF85356A21bA090E6db59121208b44

fileArray=( "" "bnb_tmt.txt" "uniswap_tmt.txt" "sushiToken_tmt.txt" "curve_tmt.txt" "blur_tmt.txt" )
index=0

function getTokenData() {
for arg in "$@"
  do 
	let index+=1
	curl -X "POST" "https://api.chainbase.online/v1/dw/query" \
	     -H 'x-api-key: [your api key]' \
	     -H 'Content-Type: application/json; charset=utf-8' \
	     -d "{\"query\":\"select count(*)\nfrom ethereum.token_transfers\nwhere contract_address='$arg'\"}" > count.txt

	awk -F \" '{print $36}' count.txt > c.txt
	total_count=$(cat c.txt) 

	echo "total count: " $total_count
	echo "###########################################"
	echo "start to iterator records per page(1000)\n"
	echo "###########################################"
	i=$total_count
	start=0
	page=1000

	while ((i > 0))
	do
		step=$(($i < $page?$i:$page))
		echo "===============[$start,$(($start+$step))]=================="
		curl -X "POST" "https://api.chainbase.online/v1/dw/query" \
		     -H 'x-api-key: [your api key]' \
		     -H 'Content-Type: application/json; charset=utf-8' \
		     -d "{\"query\":\"[your quey sentence]\"}" >> ${fileArray[$index]}

		let start+=$page;
		let i-=$page
	done


	rm count.txt c.txt
  done
}

getTokenData $bnb $uniswap $sushiToken $curve $blur 
