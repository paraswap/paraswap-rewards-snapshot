const dotenv = require('dotenv');
dotenv.config();

const _ = require('lodash');
const axios = require('axios');
const bn = require('bignumber.js');
const parallelLimit = require('async/parallelLimit');
const blobs = require('./data/userBlobs.json');
const fs = require('fs');
let userBalances = require('./data/userBlobBalances.json');

const CovalentKey = process.env.COVALENT_API_KEY;
const parallelLimitCount = 20;

function waitforme(milisec) {
  return new Promise(resolve => {
      setTimeout(() => { resolve("") }, milisec);
  })
}

const networks = [1, 137, 56, 43114];

const covalentNativeTokenAddress = {
    1: "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
    137: "0x0000000000000000000000000000000000001010",
    56: "0xb8c77482e45f1f44de1745f52c74426c631bdd52",
    43114: "0x9debca6ea3af87bf422cea9ac955618ceb56efb4",
};

async function fetchUserBalances() {
    const keys = blobs.flat().filter(k => !(k in userBalances));

    let networkTokenPrices = {};
    for(let n of networks) {
        const r = await axios.get(`${process.env.FIATFETCHER_URL}/prices/${n}`)
        networkTokenPrices[n] = r.data.prices;
    }

    let i = 0;
    const fetchBalance = async (key) => {
        try {
            ++i;
            if(!key)
                return;
            if (key in userBalances)
                return;
            console.log(`Fetching for ${key} (${i} out of ${keys.length})`);
            const address = key.split('_')[0];
            const network = key.split('_')[1];
            const data = await axios.get(
                `https://api.covalenthq.com/v1/${network}/address/${address}/balances_v2/?key=${CovalentKey}`
            );
            if(!(data.data && data.data.data)) {
                console.error(`Failed to fetch for ${key}`);
                return;
            }
            const balance = data.data.data.items.reduce((sum, i) => {
                if (i.contract_address.toLowerCase() ===
                        covalentNativeTokenAddress[network]
                    || i.contract_address.toLowerCase() in 
                        networkTokenPrices[network]) {
                    return sum.plus(i.quote)
                } else {
                    return sum;
                }
            }, new bn(0));
            userBalances[key] = balance.toString();
            fs.writeFileSync('./data/userBlobBalances.json', JSON.stringify(userBalances, null, 2));
        } catch(e) {
            console.error(`Failed to fetch for ${key}`, e);
        }
    }

    await parallelLimit(
        keys.map(k => async () => await fetchBalance(k)),
        parallelLimitCount,
    );
}

fetchUserBalances();
