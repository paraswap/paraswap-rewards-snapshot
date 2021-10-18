const dotenv = require('dotenv');
dotenv.config();

const providers = require('@ethersproject/providers');
const fs = require('fs'); 
const csv = require('csv-parser');
const _ = require('lodash');

const ProviderURLs = {
    1: process.env.HTTP_PROVIDER_1,
    56: process.env.HTTP_PROVIDER_56,
    137: process.env.HTTP_PROVIDER_137,
    43114: process.env.HTTP_PROVIDER_43114,
};

const SnapshotBlockNumber = {
    1: 13380733,
    56: 11605446,
    137: 19999042,
    43114: 5389470,
};

const networks = [1, 56, 137, 43114];
const parallelLimit = 20;

async function getNetworkBalanceNonce(network, users, fetchedUsers) {
    console.log(network, users.length, Object.keys(fetchedUsers).length);
    const provider = new providers.JsonRpcProvider(ProviderURLs[network]);
    const batchedUsers = _.chunk(users, parallelLimit);
    for (let batchIndex in batchedUsers) {
        try {
            const batch = batchedUsers[batchIndex];
            const _balanceNonce = await Promise.all(batch.map(async _userAddress => {
                if(fetchedUsers[`${_userAddress}_${network}`])
                    return;
                return {
                    balance: (await provider.getBalance(_userAddress, SnapshotBlockNumber[network])).toString(),
                    txCount: await provider.getTransactionCount(_userAddress, SnapshotBlockNumber[network]) 
                };
            }));
            batch.map(
                (_userAddress, i) => {
                    if(fetchedUsers[`${_userAddress}_${network}`])
                        return;
                    fetchedUsers[`${_userAddress}_${network}`] = true;
                    fs.appendFileSync('./data/balance.csv', `${_userAddress},${network},${_balanceNonce[i].balance},${_balanceNonce[i].txCount}\n`);
                }
            );
            console.log(`(network: ${network}) Fetched ${batchIndex} out of ${batchedUsers.length}`);
        } catch(e) {
            // We can simply run the script again if some batch was skipped and we want to retry
            console.error(`(network: ${network}) Skipped ${batchIndex}`, e);
        }
    }
}

async function main() {
    const getUsersPromise = new Promise((resolve, reject) => {
        let _users = {};
        fs.createReadStream('./data/paraswap-distinct-users.csv').pipe(csv())
            .on('data', function(data){
                if (!_users[data.network])
                    _users[data.network] = [];
                _users[data.network].push(data.useraddress);
            })
            .on('end',function(){
                resolve(_users);
            });
    });
    const fetchedUsersPromise = new Promise((resolve, reject) => {
        let _users = {};
        fs.createReadStream('./data/balance.csv').pipe(csv())
            .on('data', function(data){
                _users[`${data.userAddress}_${data.network}`] = true;
            })
            .on('end',function(){
                resolve(_users);
            });
    });
    const usersMap = await getUsersPromise;
    const fetchedUsers = await fetchedUsersPromise;
    await Promise.all(networks.map(n => getNetworkBalanceNonce(n, usersMap[n.toString()], fetchedUsers)));
} 

main();