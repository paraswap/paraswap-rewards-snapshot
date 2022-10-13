-- Notice this script is not executable
-- you should be replacing the S3 credentials place holders '<access-key-id>' and '<secret-access-key>' by valid crednetials.
-- Also file locations on S3 still on S3 but maybe deleted cleaned in the future.
-- Notice that Polygon's V5 couldn't be imported as is due to Redshift limit with max integer cannot be stored so it was changed manually before imported.
-- Notice that JSON import doesn't work with array wrapper and commas, basically you need a multiline of JSON objects with no commas between them and no array [] wrapping
CREATE TABLE rewards_avalanche_v5 (
    id VARCHAR(300) NOT NULL,
    uuid VARCHAR(108) NOT NULL,
    augustus VARCHAR(300) NOT NULL,
    augustusversion VARCHAR(30) NOT NULL,
    side VARCHAR(30) NOT NULL,
    method VARCHAR(120) NOT NULL,
    initiator VARCHAR(150) NOT NULL,
    beneficiary VARCHAR(150) NOT NULL,
    blocknumber integer NOT NULL,
    blockhash VARCHAR(210) NOT NULL,
    txtimestamp integer NOT NULL,
    srctoken VARCHAR(150) NOT NULL,
    desttoken VARCHAR(150) NOT NULL,
    srcamount decimal(38,0) NOT NULL,
    srcamountusd decimal(28,10),
    destamount decimal(38,0) NOT NULL,
    destamountusd decimal(28,10),
    expectedamount decimal(38,0),
    txhash VARCHAR(231) NOT NULL,
    txgasprice decimal(38,0) NOT NULL,
    txgasused integer NOT NULL,
    txorigin VARCHAR(150) NOT NULL,
    txtarget VARCHAR(150) NOT NULL
);

CREATE TABLE rewards_bsc_v4 (
    id VARCHAR(300) NOT NULL,
    augustus VARCHAR(300) NOT NULL,
    augustusversion VARCHAR(30) NOT NULL,
    side VARCHAR(30) NOT NULL,
    method VARCHAR(120) NOT NULL,
    initiator VARCHAR(150) NOT NULL,
    beneficiary VARCHAR(150) NOT NULL,
    blocknumber integer NOT NULL,
    blockhash VARCHAR(210) NOT NULL,
    txtimestamp integer NOT NULL,
    referrer VARCHAR(300),
    srctoken VARCHAR(150) NOT NULL,
    desttoken VARCHAR(150) NOT NULL,
    srcamount decimal(38,0) NOT NULL,
    srcamountusd decimal(28,10),
    destamount decimal(38,0) NOT NULL,
    destamountusd decimal(28,10),
    expectedamount decimal(38,0),
    txhash VARCHAR(231) NOT NULL,
    txgasprice decimal(38,0) NOT NULL,
    txgasused integer NOT NULL,
    txorigin VARCHAR(150) NOT NULL,
    txtarget VARCHAR(150) NOT NULL,
    uuid VARCHAR(150)
);

CREATE TABLE rewards_bsc_v5 (
    id VARCHAR(300) NOT NULL,
    uuid VARCHAR(108) NOT NULL,
    augustus VARCHAR(300) NOT NULL,
    augustusversion VARCHAR(30) NOT NULL,
    side VARCHAR(30) NOT NULL,
    method VARCHAR(120) NOT NULL,
    initiator VARCHAR(150) NOT NULL,
    beneficiary VARCHAR(150) NOT NULL,
    blocknumber integer NOT NULL,
    blockhash VARCHAR(210) NOT NULL,
    txtimestamp integer NOT NULL,
    srctoken VARCHAR(150) NOT NULL,
    desttoken VARCHAR(150) NOT NULL,
    srcamount decimal(38,0) NOT NULL,
    srcamountusd decimal(28,10),
    destamount decimal(38,0) NOT NULL,
    destamountusd decimal(28,10),
    expectedamount decimal(38,0),
    txhash VARCHAR(231) NOT NULL,
    txgasprice decimal(38,0) NOT NULL,
    txgasused integer NOT NULL,
    txorigin VARCHAR(150) NOT NULL,
    txtarget VARCHAR(150) NOT NULL
);

CREATE TABLE rewards_ethereum_v4 (
    id VARCHAR(300) NOT NULL,
    augustus VARCHAR(300) NOT NULL,
    augustusversion VARCHAR(30) NOT NULL,
    side VARCHAR(30) NOT NULL,
    method VARCHAR(120) NOT NULL,
    initiator VARCHAR(150) NOT NULL,
    beneficiary VARCHAR(150) NOT NULL,
    blocknumber integer NOT NULL,
    blockhash VARCHAR(210) NOT NULL,
    txtimestamp integer NOT NULL,
    referrer VARCHAR(900),
    srctoken VARCHAR(150) NOT NULL,
    desttoken VARCHAR(150) NOT NULL,
    srcamount decimal(38,0) NOT NULL,
    srcamountusd decimal(28,10),
    destamount decimal(38,0) NOT NULL,
    destamountusd decimal(28,10),
    expectedamount decimal(38,0),
    txhash VARCHAR(231) NOT NULL,
    txgasprice decimal(38,0) NOT NULL,
    txgasused integer NOT NULL,
    txorigin VARCHAR(150) NOT NULL,
    txtarget VARCHAR(150) NOT NULL,
    uuid VARCHAR(150)
);

CREATE TABLE rewards_ethereum_v5 (
    id VARCHAR(300) NOT NULL,
    uuid VARCHAR(324) NOT NULL,
    augustus VARCHAR(300) NOT NULL,
    augustusversion VARCHAR(30) NOT NULL,
    side VARCHAR(30) NOT NULL,
    method VARCHAR(120) NOT NULL,
    initiator VARCHAR(150) NOT NULL,
    beneficiary VARCHAR(150) NOT NULL,
    blocknumber integer NOT NULL,
    blockhash VARCHAR(210) NOT NULL,
    txtimestamp integer NOT NULL,
    srctoken VARCHAR(150) NOT NULL,
    desttoken VARCHAR(150) NOT NULL,
    srcamount decimal(38,0) NOT NULL,
    srcamountusd decimal(28,10),
    destamount decimal(38,0) NOT NULL,
    destamountusd decimal(28,10),
    expectedamount decimal(38,0),
    txhash VARCHAR(231) NOT NULL,
    txgasprice decimal(38,0) NOT NULL,
    txgasused integer NOT NULL,
    txorigin VARCHAR(150) NOT NULL,
    txtarget VARCHAR(150) NOT NULL
);

DROP TABLE rewards_polygon_v4;
CREATE TABLE rewards_polygon_v4 (
    id VARCHAR(300) NOT NULL,
    augustus VARCHAR(300) NOT NULL,
    augustusversion VARCHAR(30) NOT NULL,
    side VARCHAR(30) NOT NULL,
    method VARCHAR(120) NOT NULL,
    initiator VARCHAR(150) NOT NULL,
    beneficiary VARCHAR(150) NOT NULL,
    blocknumber integer NOT NULL,
    blockhash VARCHAR(210) NOT NULL,
    txtimestamp integer NOT NULL,
    referrer VARCHAR(900),
    srctoken VARCHAR(150) NOT NULL,
    desttoken VARCHAR(150) NOT NULL,
    srcamount decimal(38,0) NOT NULL,
    srcamountusd decimal(28,10),
    destamount decimal(38,0) NOT NULL,
    destamountusd decimal(28,10),
    expectedamount decimal(38,0),
    txhash VARCHAR(231) NOT NULL,
    txgasprice decimal(38,0) NOT NULL,
    txgasused integer NOT NULL,
    txorigin VARCHAR(150) NOT NULL,
    txtarget VARCHAR(150) NOT NULL
);

CREATE TABLE rewards_polygon_v5 (
    id VARCHAR(300) NOT NULL,
    uuid VARCHAR(108) NOT NULL,
    augustus VARCHAR(900) NOT NULL,
    augustusversion VARCHAR(30) NOT NULL,
    side VARCHAR(30) NOT NULL,
    method VARCHAR(120) NOT NULL,
    initiator VARCHAR(150) NOT NULL,
    beneficiary VARCHAR(150) NOT NULL,
    blocknumber integer NOT NULL,
    blockhash VARCHAR(210) NOT NULL,
    txtimestamp integer NOT NULL,
    srctoken VARCHAR(150) NOT NULL,
    desttoken VARCHAR(150) NOT NULL,
    srcamount decimal(38,0) NOT NULL,
    srcamountusd decimal(28,10),
    destamount decimal(38,0) NOT NULL,
    destamountusd decimal(28,10),
    expectedamount decimal(38,0),
    txhash VARCHAR(231) NOT NULL,
    txgasprice decimal(38,0) NOT NULL,
    txgasused integer NOT NULL,
    txorigin VARCHAR(150) NOT NULL,
    txtarget VARCHAR(150) NOT NULL
);

CREATE TABLE rewards_user_info (
    useraddress varchar(150) NOT NULL,
    network integer NOT NULL,
    balance decimal(38,0) NOT NULL,
    txCount INTEGER NOT NULL,
    PRIMARY KEY(userAddress, network)
);

CREATE materialized VIEW rewards_network_filtered_users AS
SELECT distinct(useraddress)
   FROM rewards_user_info
   WHERE ((network = 1
           AND balance > 28000000000000000)
          OR (network = 56
              AND balance > 250000000000000000)
          OR (network = 137
              AND balance > 20000000000000000000)
          OR (network = 43114
              AND balance > 900000000000000000))
     OR txcount > 50;

CREATE TABLE rewards_blob_user_blacklist (
    useraddress varchar(150) NOT NULL,
    PRIMARY KEY(userAddress)
);

CREATE TABLE rewards_eligible_users (
    useraddress varchar(150) NOT NULL,
    network integer NOT NULL,
    PRIMARY KEY(useraddress, network)
);

CREATE TABLE rewards_cow_swap_txs (
    sellamount decimal(38,0) NOT NULL,
    buyamount decimal(38,0) NOT NULL,
    feeamount decimal(38,0) NOT NULL,
    owner VARCHAR(150) NOT NULL,
    txhash VARCHAR(231) NOT NULL,
    selltoken VARCHAR(150) NOT NULL,
    buytoken VARCHAR(150) NOT NULL
);

COPY rewards_avalanche_v5
FROM 's3://datalake.paraswap.io/avalanche_v5.csv'
credentials
'aws_access_key_id=<access-key-id>;aws_secret_access_key=<secret-access-key>'
CSV;

SELECT * from rewards_avalanche_v5;


COPY rewards_bsc_v4
FROM 's3://datalake.paraswap.io/bsc_v4.csv'
credentials
'aws_access_key_id=<access-key-id>;aws_secret_access_key=<secret-access-key>'
CSV;

SELECT * from rewards_bsc_v4;


COPY rewards_bsc_v5
FROM 's3://datalake.paraswap.io/bsc_v5.csv'
credentials
'aws_access_key_id=<access-key-id>;aws_secret_access_key=<secret-access-key>'
CSV;

SELECT * from rewards_bsc_v5;


COPY rewards_ethereum_v4
FROM 's3://datalake.paraswap.io/ethereum_v4.csv'
credentials
'aws_access_key_id=<access-key-id>;aws_secret_access_key=<secret-access-key>'
CSV;

SELECT * from rewards_ethereum_v4;


COPY rewards_ethereum_v5
FROM 's3://datalake.paraswap.io/ethereum_v5.csv'
credentials
'aws_access_key_id=<access-key-id>;aws_secret_access_key=<secret-access-key>'
CSV;

SELECT * from rewards_ethereum_v5;


COPY rewards_polygon_v4
FROM 's3://datalake.paraswap.io/polygon_v4.csv'
credentials
'aws_access_key_id=<access-key-id>;aws_secret_access_key=<secret-access-key>'
CSV;
maxerror as 20000;

SELECT count(*) from rewards_polygon_v4;


COPY rewards_polygon_v5
FROM 's3://datalake.paraswap.io/polygon_v5.csv'
credentials
'aws_access_key_id=<access-key-id>;aws_secret_access_key=<secret-access-key>'
CSV
maxerror as 20000;

COPY rewards_user_info
FROM 's3://datalake.paraswap.io/balance.csv'
credentials
'aws_access_key_id=<access-key-id>;aws_secret_access_key=<secret-access-key>'
CSV;

select * from rewards_user_info;
REFRESH materialized VIEW rewards_network_filtered_users;
select * from rewards_network_filtered_users;

COPY rewards_blob_user_blacklist
FROM 's3://datalake.paraswap.io/userBlobsBlacklist.csv'
credentials
'aws_access_key_id=<access-key-id>;aws_secret_access_key=<secret-access-key>'
CSV;

select * from rewards_blob_user_blacklist;

COPY rewards_eligible_users
FROM 's3://datalake.paraswap.io/eligible-users.json'
credentials
'aws_access_key_id=<access-key-id>;aws_secret_access_key=<secret-access-key>'
JSON 'auto';

select * from rewards_eligible_users;

COPY rewards_cow_swap_txs
FROM 's3://datalake.paraswap.io/cow-swap-txs.csv'
credentials
'aws_access_key_id=<access-key-id>;aws_secret_access_key=<secret-access-key>'
CSV;

select * from rewards_cow_swap_txs;

CREATE VIEW rewards_top_ethereum_tokens AS
SELECT address,
       sum(volume) AS volume
FROM
  (SELECT srctoken AS address,
          srcamountusd AS volume
   FROM rewards_ethereum_v4
   UNION SELECT srctoken AS address,
                srcamountusd AS volume
   FROM rewards_ethereum_v5
   UNION SELECT desttoken AS address,
                destamountusd AS volume
   FROM rewards_ethereum_v4
   UNION SELECT desttoken AS address,
                destamountusd AS volume
   FROM rewards_ethereum_v5) AS tokenTable
GROUP BY address
HAVING sum(volume) > 1000000
ORDER BY volume DESC;

select * from rewards_top_ethereum_tokens;

CREATE VIEW rewards_top_polygon_tokens AS
SELECT address,
       sum(volume) AS volume
FROM
  (SELECT srctoken AS address,
          srcamountusd AS volume
   FROM rewards_polygon_v4
   UNION SELECT srctoken AS address,
                srcamountusd AS volume
   FROM rewards_polygon_v5
   UNION SELECT desttoken AS address,
                destamountusd AS volume
   FROM rewards_polygon_v4
   UNION SELECT desttoken AS address,
                destamountusd AS volume
   FROM rewards_polygon_v5) AS tokenTable
GROUP BY address
HAVING sum(volume) > 1000000
ORDER BY volume DESC;

select * from rewards_top_polygon_tokens;

CREATE VIEW rewards_top_bsc_tokens AS
SELECT address,
       sum(volume) AS volume
FROM
  (SELECT srctoken AS address,
          srcamountusd AS volume
   FROM rewards_bsc_v4
   UNION SELECT srctoken AS address,
                srcamountusd AS volume
   FROM rewards_bsc_v5
   UNION SELECT desttoken AS address,
                destamountusd AS volume
   FROM rewards_bsc_v4
   UNION SELECT desttoken AS address,
                destamountusd AS volume
   FROM rewards_bsc_v5) AS tokenTable
GROUP BY address
HAVING sum(volume) > 1000000
ORDER BY volume DESC;

select * from rewards_top_bsc_tokens;

CREATE VIEW rewards_top_avalanche_tokens AS
SELECT address,
       sum(volume) AS volume
FROM
  (SELECT srctoken AS address,
          srcamountusd AS volume
   FROM rewards_avalanche_v5
   UNION SELECT desttoken AS address,
                destamountusd AS volume
   FROM rewards_avalanche_v5) AS tokenTable
GROUP BY address
HAVING sum(volume) > 1000000
ORDER BY volume DESC;

select * from rewards_top_avalanche_tokens;

CREATE OR REPLACE VIEW rewards_filtered_ethereum_txs AS
SELECT *,
       1 AS network
FROM
  (SELECT id,
          augustus,
          augustusversion,
          side,
          METHOD,
          initiator,
          beneficiary,
          blocknumber,
          blockhash,
          txtimestamp,
          referrer,
          srctoken,
          desttoken,
          srcamount,
          srcamountusd,
          destamount,
          destamountusd,
          expectedamount,
          txhash,
          txgasprice,
          txgasused,
          txorigin,
          txtarget,
          NULL AS UUID,
          initiator AS userAddress
   FROM rewards_ethereum_v4
   WHERE referrer IN ('argent',
                      '3')
   UNION SELECT id,
                augustus,
                augustusversion,
                side,
                METHOD,
                initiator,
                beneficiary,
                blocknumber,
                blockhash,
                txtimestamp,
                referrer,
                srctoken,
                desttoken,
                srcamount,
                srcamountusd,
                destamount,
                destamountusd,
                expectedamount,
                rewards_ethereum_v4.txhash,
                txgasprice,
                txgasused,
                txorigin,
                txtarget,
                NULL AS UUID,
                rewards_cow_swap_txs.owner AS userAddress
   FROM rewards_ethereum_v4,
        rewards_cow_swap_txs
   WHERE initiator IN ('0x9008d19f58aabd9ed0d60971565aa8510560ab41',
                       '0x3328f5f2cecaf00a2443082b657cedeaf70bfaef')
     AND rewards_cow_swap_txs.txHash = rewards_ethereum_v4.txhash
     AND rewards_cow_swap_txs.selltoken = rewards_ethereum_v4.srctoken
   UNION SELECT id,
                augustus,
                augustusversion,
                side,
                METHOD,
                initiator,
                beneficiary,
                blocknumber,
                blockhash,
                txtimestamp,
                referrer,
                srctoken,
                desttoken,
                srcamount,
                srcamountusd,
                destamount,
                destamountusd,
                expectedamount,
                txhash,
                txgasprice,
                txgasused,
                txorigin,
                txtarget,
                NULL AS UUID,
                txorigin AS userAddress
   FROM rewards_ethereum_v4
   WHERE initiator NOT IN ('0x9008d19f58aabd9ed0d60971565aa8510560ab41',
                           '0x3328f5f2cecaf00a2443082b657cedeaf70bfaef')
     AND referrer NOT IN ('argent',
                          '3')
   UNION SELECT id,
                augustus,
                augustusversion,
                side,
                METHOD,
                initiator,
                beneficiary,
                blocknumber,
                blockhash,
                txtimestamp,
                NULL AS referrer,
                srctoken,
                desttoken,
                srcamount,
                srcamountusd,
                destamount,
                destamountusd,
                expectedamount,
                txhash,
                txgasprice,
                txgasused,
                txorigin,
                txtarget,
                UUID,
                txorigin AS userAddress
   FROM rewards_ethereum_v5) AS allTXs
WHERE srctoken in
    (SELECT address
     FROM rewards_top_ethereum_tokens)
  AND desttoken in
    (SELECT address
     FROM rewards_top_ethereum_tokens)
  AND txtimestamp < 1633730399
  AND txtimestamp > 1614977606
  AND NOT (srctoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
           AND desttoken = '0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2')
  AND NOT (desttoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
           AND srctoken = '0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2');

select * from rewards_filtered_ethereum_txs;

CREATE OR REPLACE VIEW rewards_filtered_polygon_txs AS
SELECT *,
       137 AS network
FROM
  (SELECT id,
          augustus,
          augustusversion,
          side,
          METHOD,
          initiator,
          beneficiary,
          blocknumber,
          blockhash,
          txtimestamp,
          referrer,
          srctoken,
          desttoken,
          srcamount,
          srcamountusd,
          destamount,
          destamountusd,
          expectedamount,
          txhash,
          txgasprice,
          txgasused,
          txorigin,
          txtarget,
          NULL AS UUID,
          txorigin AS userAddress
   FROM rewards_polygon_v4
   UNION SELECT id,
                augustus,
                augustusversion,
                side,
                METHOD,
                initiator,
                beneficiary,
                blocknumber,
                blockhash,
                txtimestamp,
                NULL AS referrer,
                srctoken,
                desttoken,
                srcamount,
                srcamountusd,
                destamount,
                destamountusd,
                expectedamount,
                txhash,
                txgasprice,
                txgasused,
                txorigin,
                txtarget,
                UUID,
                txorigin AS userAddress
   FROM rewards_polygon_v5) AS allTXs
WHERE srctoken in
    (SELECT address
     FROM rewards_top_polygon_tokens)
  AND desttoken in
    (SELECT address
     FROM rewards_top_polygon_tokens)
  AND txtimestamp < 1633730399
  AND txtimestamp > 1614977606
  AND NOT (srctoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
           AND desttoken = '0x0d500b1d8e8ef31e21c99d1db9a6444d3adf1270')
  AND NOT (desttoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
           AND srctoken = '0x0d500b1d8e8ef31e21c99d1db9a6444d3adf1270');

select * from rewards_filtered_polygon_txs;

CREATE OR REPLACE VIEW rewards_filtered_bsc_txs AS
SELECT *,
       56 AS network
FROM
  (SELECT id,
          augustus,
          augustusversion,
          side,
          METHOD,
          initiator,
          beneficiary,
          blocknumber,
          blockhash,
          txtimestamp,
          referrer,
          srctoken,
          desttoken,
          srcamount,
          srcamountusd,
          destamount,
          destamountusd,
          expectedamount,
          txhash,
          txgasprice,
          txgasused,
          txorigin,
          txtarget,
          NULL AS UUID,
          txorigin AS userAddress
   FROM rewards_bsc_v4
   UNION SELECT id,
                augustus,
                augustusversion,
                side,
                METHOD,
                initiator,
                beneficiary,
                blocknumber,
                blockhash,
                txtimestamp,
                NULL AS referrer,
                srctoken,
                desttoken,
                srcamount,
                srcamountusd,
                destamount,
                destamountusd,
                expectedamount,
                txhash,
                txgasprice,
                txgasused,
                txorigin,
                txtarget,
                UUID,
                txorigin AS userAddress
   FROM rewards_bsc_v5) AS allTXs
WHERE srctoken in
    (SELECT address
     FROM rewards_top_bsc_tokens)
  AND desttoken in
    (SELECT address
     FROM rewards_top_bsc_tokens)
  AND txtimestamp < 1633730399
  AND txtimestamp > 1614977606
  AND NOT (srctoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
           AND desttoken = '0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c')
  AND NOT (desttoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
           AND srctoken = '0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c');

select * from rewards_filtered_bsc_txs;

CREATE OR REPLACE VIEW rewards_filtered_avalanche_txs AS
SELECT *,
       43114 AS network
FROM
  (SELECT id,
          augustus,
          augustusversion,
          side,
          method,
          initiator,
          beneficiary,
          blocknumber,
          blockhash,
          txtimestamp,
          NULL AS referrer,
          srctoken,
          desttoken,
          srcamount,
          srcamountusd,
          destamount,
          destamountusd,
          expectedamount,
          txhash,
          txgasprice,
          txgasused,
          txorigin,
          txtarget,
          UUID,
          txorigin AS userAddress
   FROM rewards_avalanche_v5) AS allTXs
WHERE srctoken in
    (SELECT address
     FROM rewards_top_avalanche_tokens)
  AND desttoken in
    (SELECT address
     FROM rewards_top_avalanche_tokens)
  AND txtimestamp < 1633730399
  AND txtimestamp > 1614977606
  AND NOT (srctoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
           AND desttoken = '0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7')
  AND NOT (desttoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
           AND srctoken = '0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7');

select * from rewards_filtered_avalanche_txs;

CREATE VIEW rewards_all_filtered_txs AS
  (SELECT *
   FROM rewards_filtered_ethereum_txs
   UNION SELECT *
   FROM rewards_filtered_polygon_txs
   UNION SELECT *
   FROM rewards_filtered_bsc_txs
   UNION SELECT *
   FROM rewards_filtered_avalanche_txs);

select * from rewards_all_filtered_txs;
