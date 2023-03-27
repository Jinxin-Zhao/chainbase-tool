# Get Blockchain data from chainbase
#### chainbase website(https://docs.chainbase.com/docs)

Chainbase is an all-in-one data infrastructure for Web3 that allows you to index, transform, and use on-chain data at scale. By leveraging enriched on-chain data and streaming computing technologies across one data infrastructure, Chainbase automates the indexing and querying of blockchain data, enabling developers to accomplish more with less effort.

#### the tool is only for research
##### getData tool(in 10w records)
+ If the number of records you want to get are in 10w, you can use this tool $getData.sh$, the tool used 'task_id' provided by chainbase.
    + first of all, you should generate a task_id of your query sentences in chainbase website which execute the sql-like sentences.
    ```shell
    # Usage: ./getData.sh [task_id] [filename]
    ]./getData.sh 0x....... test.csv 
    ```
##### get all Data tool
+ 1. Most of all, you need to apply an api-key of chainbase by signing up in its website.
+ 2. Then you can use these 2 scripts to help you get the csv format file.
+ 3. the tool consists of 2 shell scripts(getTokenData.sh, format.sh).
  - getTokenData.sh: just as its name implies, the script only get token data by 'Data Cloud API' provided by chainbase. In this script,you can write your own sql-like sentences to query the data you want(it means that you'd better modify some contents as you need). I just get the token transactions below: bnb,uniswap,sushiToken,curve,blur.
  + you'd better fill the content in '[]' with your own data in $getTokenData.sh$.
  ```shell
  curl -X "POST" "https://api.chainbase.online/v1/dw/query" \
	     -H 'x-api-key: [your api-key]' \
	     -H 'Content-Type: application/json; charset=utf-8' \
	     -d "{\"query\": [your sql-like query sentence]}" > count.txt
  ```
  + run $getTokenData.sh$
  ```shell
  ]$ ./getTokenData.sh
  ```
+ 4. After running $getTokenData.sh$, you can use $format.sh$ like this:
    ```shell
    # Usage: ./format.sh [filename]
    # example: ./format.sh test.csv
    ]$ ./format 'filename you named'

    ]$ head -5 test.csv
    # data format like this:
    block_number,timestamp,from,to,tx_hash,value
    16528709, 2023-01-31 18:50:35, 0x0000000000000000000000000000000000000000, 0x2ec1c79e71594373123d7b86d5847eef1ce0a475, 0xdb0c0f0ce449b615b98aca57675667937d2b96e0e7ff8c4fdaffb93aa9bb9309, 3000000000000000000000000000
    16542975, 2023-02-02 18:42:47, 0x2ec1c79e71594373123d7b86d5847eef1ce0a475, 0xe2190ad070035bde83e35b2f88ab939372049e96, 0x44db505d4e8e737c22e60c2b3e3370ec98d972f2e2e457d71a8f0812c23f2057, 435000000000000000000
    16572478, 2023-02-06 21:37:23, 0xe2190ad070035bde83e35b2f88ab939372049e96, 0x61b87f35286143f3be7cc4fe130f3a3b58d5d875, 0xd0860c9a3fd8fef53fde2bfa8a30d2fa75eaabe9befbf688fee0c98b5b97b0ee, 10000000000000000000
    16585979, 2023-02-08 18:58:11, 0x2ec1c79e71594373123d7b86d5847eef1ce0a475, 0xab810605a846ae87ae12b6260b506983344efa7a, 0x6c34a26228367af6ad467d758fa31611808aab2a10a133a116823c6ae34283ad, 100000000000000000000
    ```
+ 5 Notice that the query sql can only get 1000 records every time(and the data is unordered), You can only iterate to get all the data（the logic is already in getTokenData.sh）.




  
