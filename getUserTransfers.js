const dotenv = require('dotenv');
dotenv.config();

const axios = require('axios'); 
const _ = require('lodash');
const eligibleUsers = require('./data/eligible-users.json');
const fs = require('fs');
let userTransfers = require('./data/userTransfers.json');

const EtherscanKeys = {
    1: process.env.ETHERSCAN_API_KEY,
    56: process.env.BSCSCAN_API_KEY,
    137: process.env.POLYGONSCAN_API_KEY,
    43114: process.env.SNOWTRACE
};

const EtherscanURLs = {
    1: 'https://api.etherscan.io',
    56: 'https://api.bscscan.com',
    137: 'https://api.polygonscan.com',
    43114: 'https://api.snowtrace.io'
}

function waitforme(milisec) {
  return new Promise(resolve => {
      setTimeout(() => { resolve("") }, milisec);
  })
}

const eligibleUsersMap = eligibleUsers.reduce((acc, u) => { acc[u.useraddress.toLowerCase()] = true; return acc}, {});

async function fetchUserTransfers(useraddress, network, dept, result) {
    if (dept < 0)
        return;

    const key = `${useraddress.toLowerCase()}_${network}`;
    if (!userTransfers[key] && !result[key]) {
        const data = await axios.get(`${EtherscanURLs[network]}/api?module=account&action=txlist&address=${useraddress}&apikey=${EtherscanKeys[network]}`);
        // await waitforme(100);
        if(!(data && data.data && data.data.status == '1')) {
           console.log(`Error fetching txs for ${useraddress} and ${network}`, data.data);
           return;
        }
        const txs = data.data.result;
        let ins = [];
        let outs = [];
        for (let tx of txs) {
            if (tx.input !== '0x') 
                continue;
            
            if (tx.from.toLowerCase() == useraddress.toLowerCase()) {
                outs.push(tx.to);
            } 
            else if(tx.to.toLowerCase() == useraddress.toLowerCase()) {
                ins.push(tx.from);
            } 
            else {
                console.log(`Unrecognised Tx: ${tx}`);
            }
        }
        result[key] = {
            ins,
            outs,
            useraddress,
            network,
            eligibleUser: eligibleUsersMap[useraddress.toLowerCase()] || false
        };
    }
    const { ins, outs } = result[key] || userTransfers[key];

    for(let _in of ins.slice(0, 150)) {
        await fetchUserTransfers(_in, network, dept - 1, result);
    }

    for(let _out of outs.slice(0, 150)) {
        await fetchUserTransfers(_out, network, dept - 1, result);
    }
}

async function fetchAllTransfersNetwork(_eligibleUsers) {
    let x = 1;
    for(let user of _eligibleUsers) {
        console.log(`Fetching for ${user.useraddress}_${user.network}: ${x++} out of ${_eligibleUsers.length}`)
        const res = {};
        try {
            await fetchUserTransfers(user.useraddress, user.network, 0, res);
            for (let [key, value] of Object.entries(res)) {
                userTransfers[key] = value;
            }
            if(Object.keys(res).length && (x % 50 == 0 || x === _eligibleUsers.length)) {
                fs.writeFileSync('./data/userTransfers.json', JSON.stringify(userTransfers, null, 2));
            }
        } catch(e) {
            console.error(`Error Fetching ${user.useraddress} ${user.network}`);
        }
    }
}

async function fetchAllTransfers() {
    await Promise.all([
        fetchAllTransfersNetwork(eligibleUsers.filter(u => u.network === 1)),
        fetchAllTransfersNetwork(eligibleUsers.filter(u => u.network === 56)),
        fetchAllTransfersNetwork(eligibleUsers.filter(u => u.network === 137)),
        fetchAllTransfersNetwork(eligibleUsers.filter(u => u.network === 43114)),
    ])
}

fetchAllTransfers();