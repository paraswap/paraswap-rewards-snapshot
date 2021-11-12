const userBlobBalances = require('./data/userBlobBalances.json');
const fs = require('fs');

function main() {
    // const sortedBalance = Object.entries(userBlobBalances).sort((a, b) => b[1] -  a[1]);
    // fs.writeFileSync('./data/tmp.json', JSON.stringify(sortedBalance, null, 2));
    // console.log(Object.values(userBlobBalances).reduce((cnt, v) => cnt + (parseFloat(v) < 200 ? 1 : 0), 0));
    const filteredAddress = {};
    Object.entries(userBlobBalances).forEach((e) => {
        if (parseFloat(e[1]) > 200)
            return;
        const address = e[0].split('_')[0];
        filteredAddress[address] = true;
    });

    Object.keys(filteredAddress).forEach(
        (addr) => {
            fs.appendFileSync(
                './data/userBlobsBlacklist.csv',
                `${addr}\n`
            );
        }
    );
}

main()