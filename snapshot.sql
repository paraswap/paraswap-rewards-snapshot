-- Create view for top tokens
create view topEthereumTokens as 
select tokenAddress, sum(txVolume) as tokenVolume from (
    select srctoken as tokenAddress, srcamountusd as txVolume from ethereum_v4 union
    select srctoken as tokenAddress, srcamountusd as txVolume from ethereum_v5 union
    select desttoken as tokenAddress, destamountusd as txVolume from ethereum_v4 union
    select desttoken as tokenAddress, destamountusd as txVolume from ethereum_v5
) as tokenTable group by tokenAddress having sum(txVolume) > 1000000 order by tokenVolume desc;

create view topPolygonTokens as 
select tokenAddress, sum(txVolume) as tokenVolume from (
    select srctoken as tokenAddress, srcamountusd as txVolume from polygon_v4 union
    select srctoken as tokenAddress, srcamountusd as txVolume from polygon_v5 union
    select desttoken as tokenAddress, destamountusd as txVolume from polygon_v4 union
    select desttoken as tokenAddress, destamountusd as txVolume from polygon_v5
) as tokenTable group by tokenAddress having sum(txVolume) > 1000000 order by tokenVolume desc;

create view topBSCTokens as 
select tokenAddress, sum(txVolume) as tokenVolume from (
    select srctoken as tokenAddress, srcamountusd as txVolume from bsc_v4 union
    select srctoken as tokenAddress, srcamountusd as txVolume from bsc_v5 union
    select desttoken as tokenAddress, destamountusd as txVolume from bsc_v4 union
    select desttoken as tokenAddress, destamountusd as txVolume from bsc_v5
) as tokenTable group by tokenAddress having sum(txVolume) > 1000000 order by tokenVolume desc;

create view topAvalancheTokens as 
select tokenAddress, sum(txVolume) as tokenVolume from (
    select srctoken as tokenAddress, srcamountusd as txVolume from avalanche_v5 union
    select desttoken as tokenAddress, destamountusd as txVolume from avalanche_v5
) as tokenTable group by tokenAddress having sum(txVolume) > 1000000 order by tokenVolume desc;

-- Create view for filtered txs
create or replace view FilteredEthereumTXs as
select *, 1 as network from (select
    id,
    augustus,
    augustusversion,
    side,
    method,
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
    null as uuid,
    case  
        when referrer in ('argents', '3') then initiator
        else txorigin 
    end as userAddress
from ethereum_v4 union
select
    id,
    augustus,
    augustusversion,
    side,
    method,
    initiator,
    beneficiary,
    blocknumber,
    blockhash,
    txtimestamp,
    null as referrer,
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
    uuid,
    txorigin as userAddress
from ethereum_v5) as allTXs 
    where 
    srctoken in (select tokenaddress from topethereumtokens) and 
    desttoken in (select tokenaddress from topethereumtokens) and 
    not (srctoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee' and desttoken = '0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2') and
    not (desttoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee' and srctoken = '0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2');


create or replace view FilteredPolygonTXs as 
select *, 137 as network from (select
    id,
    augustus,
    augustusversion,
    side,
    method,
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
    null as uuid,
    txorigin as userAddress
from polygon_v4 union
select
    id,
    augustus,
    augustusversion,
    side,
    method,
    initiator,
    beneficiary,
    blocknumber,
    blockhash,
    txtimestamp,
    null as referrer,
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
    uuid,
    txorigin as userAddress
from polygon_v5) as allTXs 
    where 
    srctoken in (select tokenaddress from toppolygontokens) and 
    desttoken in (select tokenaddress from toppolygontokens) and 
    not (srctoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee' and desttoken = '0x0d500b1d8e8ef31e21c99d1db9a6444d3adf1270') and
    not (desttoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee' and srctoken = '0x0d500b1d8e8ef31e21c99d1db9a6444d3adf1270');

create or replace view FilteredBSCTXs as 
select *, 56 as network from (select
    id,
    augustus,
    augustusversion,
    side,
    method,
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
    null as uuid,
    txorigin as userAddress
from bsc_v4 union
select
    id,
    augustus,
    augustusversion,
    side,
    method,
    initiator,
    beneficiary,
    blocknumber,
    blockhash,
    txtimestamp,
    null as referrer,
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
    uuid,
    txorigin as userAddress
from bsc_v5) as allTXs 
    where 
    srctoken in (select tokenaddress from topbsctokens) and 
    desttoken in (select tokenaddress from topbsctokens) and 
    not (srctoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee' and desttoken = '0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c') and
    not (desttoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee' and srctoken = '0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c');

create or replace view FilteredAvalancheTXs as 
select *, 43114 as network from (
select
    id,
    augustus,
    augustusversion,
    side,
    method,
    initiator,
    beneficiary,
    blocknumber,
    blockhash,
    txtimestamp,
    null as referrer,
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
    uuid,
    txorigin as userAddress
from avalanche_v5) as allTXs 
    where 
    srctoken in (select tokenaddress from topavalanchetokens) and 
    desttoken in (select tokenaddress from topavalanchetokens) and 
    not (srctoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee' and desttoken = '0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7') and
    not (desttoken = '0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee' and srctoken = '0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7');

create materialized view AllFilteredTxs as (
    Select * from FilteredEthereumTXs union 
    Select * from FilteredPolygonTXs union 
    Select * from FilteredBSCTXs union 
    Select * from FilteredAvalancheTXs
);

-- create table for points