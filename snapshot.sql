-- Create view for top tokens

CREATE VIEW topEthereumTokens AS
SELECT tokenAddress,
       sum(txVolume) AS tokenVolume
FROM
  (SELECT srctoken AS tokenAddress,
          srcamountusd AS txVolume
   FROM ethereum_v4
   UNION SELECT srctoken AS tokenAddress,
                srcamountusd AS txVolume
   FROM ethereum_v5
   UNION SELECT desttoken AS tokenAddress,
                destamountusd AS txVolume
   FROM ethereum_v4
   UNION SELECT desttoken AS tokenAddress,
                destamountusd AS txVolume
   FROM ethereum_v5) AS tokenTable
GROUP BY tokenAddress
HAVING sum(txVolume) > 1000000
ORDER BY tokenVolume DESC;


CREATE VIEW topPolygonTokens AS
SELECT tokenAddress,
       sum(txVolume) AS tokenVolume
FROM
  (SELECT srctoken AS tokenAddress,
          srcamountusd AS txVolume
   FROM polygon_v4
   UNION SELECT srctoken AS tokenAddress,
                srcamountusd AS txVolume
   FROM polygon_v5
   UNION SELECT desttoken AS tokenAddress,
                destamountusd AS txVolume
   FROM polygon_v4
   UNION SELECT desttoken AS tokenAddress,
                destamountusd AS txVolume
   FROM polygon_v5) AS tokenTable
GROUP BY tokenAddress
HAVING sum(txVolume) > 1000000
ORDER BY tokenVolume DESC;


CREATE VIEW topBSCTokens AS
SELECT tokenAddress,
       sum(txVolume) AS tokenVolume
FROM
  (SELECT srctoken AS tokenAddress,
          srcamountusd AS txVolume
   FROM bsc_v4
   UNION SELECT srctoken AS tokenAddress,
                srcamountusd AS txVolume
   FROM bsc_v5
   UNION SELECT desttoken AS tokenAddress,
                destamountusd AS txVolume
   FROM bsc_v4
   UNION SELECT desttoken AS tokenAddress,
                destamountusd AS txVolume
   FROM bsc_v5) AS tokenTable
GROUP BY tokenAddress
HAVING sum(txVolume) > 1000000
ORDER BY tokenVolume DESC;


CREATE VIEW topAvalancheTokens AS
SELECT tokenAddress,
       sum(txVolume) AS tokenVolume
FROM
  (SELECT srctoken AS tokenAddress,
          srcamountusd AS txVolume
   FROM avalanche_v5
   UNION SELECT desttoken AS tokenAddress,
                destamountusd AS txVolume
   FROM avalanche_v5) AS tokenTable
GROUP BY tokenAddress
HAVING sum(txVolume) > 1000000
ORDER BY tokenVolume DESC;

-- Create view for filtered txs

CREATE OR REPLACE VIEW FilteredEthereumTXs AS
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
          CASE
              WHEN referrer in ('argents',
                                '3') THEN initiator
              -- WHEN initiator in ('0x9008d19f58aabd9ed0d60971565aa8510560ab41',
              --                    '0x3328f5f2cecaf00a2443082b657cedeaf70bfaef') THEN
              --        (SELECT substring(trader
              --                          FROM 99
              --                          FOR 42)
              --         FROM CowSwapTxs
              --         WHERE substring(TRANSACTION
              --                         FROM 118
              --                         FOR 66) = ethereum_v4.txhash)
              ELSE txorigin
          END AS userAddress
   FROM ethereum_v4
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
   FROM ethereum_v5) AS allTXs
WHERE srctoken in
    (SELECT tokenaddress
     FROM topethereumtokens)
  AND desttoken in
    (SELECT tokenaddress
     FROM topethereumtokens)
  AND txtimestamp < 1633730399 AND txtimestamp > 1614977606
  AND NOT (srctoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
           AND desttoken = '0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2')
  AND NOT (desttoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
           AND srctoken = '0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2');

CREATE OR REPLACE VIEW FilteredPolygonTXs AS
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
   FROM polygon_v4
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
   FROM polygon_v5) AS allTXs
WHERE srctoken in
    (SELECT tokenaddress
     FROM toppolygontokens)
  AND desttoken in
    (SELECT tokenaddress
     FROM toppolygontokens)
  AND txtimestamp < 1633730399 AND txtimestamp > 1614977606
  AND NOT (srctoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
           AND desttoken = '0x0d500b1d8e8ef31e21c99d1db9a6444d3adf1270')
  AND NOT (desttoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
           AND srctoken = '0x0d500b1d8e8ef31e21c99d1db9a6444d3adf1270');


CREATE OR REPLACE VIEW FilteredBSCTXs AS
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
   FROM bsc_v4
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
   FROM bsc_v5) AS allTXs
WHERE srctoken in
    (SELECT tokenaddress
     FROM topbsctokens)
  AND desttoken in
    (SELECT tokenaddress
     FROM topbsctokens)
  AND txtimestamp < 1633730399 AND txtimestamp > 1614977606
  AND NOT (srctoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
           AND desttoken = '0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c')
  AND NOT (desttoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
           AND srctoken = '0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c');


CREATE OR REPLACE VIEW FilteredAvalancheTXs AS
SELECT *,
       43114 AS network
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
   FROM avalanche_v5) AS allTXs
WHERE srctoken in
    (SELECT tokenaddress
     FROM topavalanchetokens)
  AND desttoken in
    (SELECT tokenaddress
     FROM topavalanchetokens)
  AND txtimestamp < 1633730399 AND txtimestamp > 1614977606
  AND NOT (srctoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
           AND desttoken = '0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7')
  AND NOT (desttoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee'
           AND srctoken = '0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7');


CREATE materialized VIEW AllFilteredTxs AS
  (SELECT *
   FROM FilteredEthereumTXs
   UNION SELECT *
   FROM FilteredPolygonTXs
   UNION SELECT *
   FROM FilteredBSCTXs
   UNION SELECT *
   FROM FilteredAvalancheTXs);

-- filter eligible users
CREATE materialized VIEW EligibleUsers AS
SELECT allfilteredtxs.useraddress From allfilteredtxs, 
(SELECT distinct(useraddress)
FROM userInfo
WHERE ((network = 1
        AND balance > 28000000000000000)
       OR (network = 56
           AND balance > 250000000000000000)
       OR (network = 137
           AND balance > 20000000000000000000)
       OR (network = 43114
           AND balance > 900000000000000000))
  OR txcount > 50) as networkFilteredUsers
  Where allfilteredtxs.useraddress = networkFilteredUsers.useraddress
  Group by allfilteredtxs.useraddress having count(*) > 5;

-- Add indexes to optimise query
CREATE INDEX EligibleUsers_useraddress ON EligibleUsers(useraddress);

CREATE INDEX AllFilteredTxs_useraddress ON AllFilteredTxs(useraddress);
CREATE INDEX AllFilteredTxs_srcamountusd ON AllFilteredTxs(srcamountusd);
CREATE INDEX AllFilteredTxs_network ON AllFilteredTxs(network);

-- create queries for points
CREATE materialized VIEW txCountUserPoints as
SELECT allfilteredtxs.useraddress,
       CASE
           WHEN count(*) > 10 THEN 1
           ELSE 0
       END AS txCountPoints
FROM allfilteredtxs,
     eligibleusers
WHERE allfilteredtxs.useraddress = eligibleusers.useraddress
GROUP BY allfilteredtxs.useraddress;

CREATE materialized VIEW maxTxValueUserPoints as 
SELECT allfilteredtxs.useraddress,
       CASE
            when max(srcamountusd) > 100000 then 4
            when max(srcamountusd) between 10000 and 100000 then 3
            when max(srcamountusd) between 1000 and 10000 then 2
            when max(srcamountusd) between 100 and 1000 then 1
            else 0
       END AS maxTxValuePoints
FROM allfilteredtxs,
     eligibleusers
WHERE allfilteredtxs.useraddress = eligibleusers.useraddress
GROUP BY allfilteredtxs.useraddress;

CREATE materialized VIEW userVolumeUserPoints as 
SELECT allfilteredtxs.useraddress,
       CASE
            when sum(srcamountusd) > 100000 then 4
            when sum(srcamountusd) between 10000 and 100000 then 3
            when sum(srcamountusd) between 1000 and 10000 then 2
            when sum(srcamountusd) between 100 and 1000 then 1
            else 0
       END AS userVolumePoints
FROM allfilteredtxs,
     eligibleusers
WHERE allfilteredtxs.useraddress = eligibleusers.useraddress
GROUP BY allfilteredtxs.useraddress;

CREATE materialized VIEW networkUserPoints as 
SELECT allfilteredtxs.useraddress,
       CASE
            when count(distinct network) > 1 then 1
            else 0
       END AS networkPoints
FROM allfilteredtxs,
     eligibleusers
WHERE allfilteredtxs.useraddress = eligibleusers.useraddress
GROUP BY allfilteredtxs.useraddress;

CREATE VIEW TotalPoints as
SELECT txCountUserPoints.useraddress,
       (txCountUserPoints.txCountPoints + maxTxValueUserPoints.maxTxValuePoints + userVolumeUserPoints.userVolumePoints + networkUserPoints.networkPoints) AS sumPoints
FROM txCountUserPoints,
     maxTxValueUserPoints,
     userVolumeUserPoints,
     networkUserPoints
WHERE 
    txCountUserPoints.useraddress = maxTxValueUserPoints.useraddress and 
    txCountUserPoints.useraddress = userVolumeUserPoints.useraddress and
    txCountUserPoints.useraddress = networkUserPoints.useraddress;
