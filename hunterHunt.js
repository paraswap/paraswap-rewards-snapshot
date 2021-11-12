const userTransfers = require('./data/userTransfers.json');
const fs = require('fs');

let foundBlobs = {};
let blobsMaps = {};
let i = 0;

function findBlobs(key) {
    if (!(key in blobsMaps)) {
        foundBlobs[i] = [key];
        blobsMaps[key] = i;
        i++;
    }
    let index = blobsMaps[key];
    let adjAddr = userTransfers[key].ins.concat(userTransfers[key].outs);
    for (let addr of adjAddr) {
        const keyChild = `${addr.toLowerCase()}_${userTransfers[key].network}`;
        
        if (!(keyChild in userTransfers) || !userTransfers[keyChild].eligibleUser)
            continue;
        
        if(!(keyChild in blobsMaps)) {
            foundBlobs[index].push(keyChild);
            blobsMaps[keyChild] = index;
            findBlobs(keyChild);
        } else if(blobsMaps[keyChild] === index) {
            continue;
        } else {
            // My initial guess was that this case would never occur but as the graph is not
            // complete this case happens as well!
            // Merge Blobs
            const indexChild = blobsMaps[keyChild];
            for(let key of foundBlobs[indexChild]) {
                blobsMaps[key] = index; 
            }
            foundBlobs[index] = foundBlobs[index].concat(foundBlobs[indexChild]);
            delete foundBlobs[indexChild]; 
        }
    }
}

// function chunkSave(blobs) {
//     const networks = ['1', '56', '137'];
//     for(let network of networks) {
//         const blobsNetwork = blobs.filter(b => b[0].split('_')[1] === network);
//         const chunks = Math.floor(blobsNetwork.length / 50);
//         for (let i  = 0; i <= chunks; i++) {
//             fs.writeFileSync(`./data/blobs/userBlobs_${network}_${i}.json`, JSON.stringify(blobsNetwork.slice(i * 50, (i + 1) * 50), null, 2));
//         }
//     }
// }

function main() {
    for(let [key, value] of Object.entries(userTransfers)) {
        if(!value.eligibleUser)
            continue;
        findBlobs(key);
    }
    const interestingBlobs = Object.values(foundBlobs).filter(b => b.length > 5);
    console.log(interestingBlobs.length);
    console.log(interestingBlobs.reduce((acc, b) => acc + b.length, 0));
    console.log(interestingBlobs.reduce((acc, b) => acc + (b[0].split('_')[1] === '137' ? 1 : 0), 0));
    console.log(interestingBlobs.reduce((acc, b) => acc + (b[0].split('_')[1] === '43114' ? 1 : 0), 0));
    console.log(interestingBlobs.reduce((acc, b) => acc + (b[0].split('_')[1] === '56' ? 1 : 0), 0));
    console.log(interestingBlobs.reduce((acc, b) => acc + (b[0].split('_')[1] === '1' ? 1 : 0), 0));
    const uniqueAddress = Object.keys(
        interestingBlobs.flat().reduce(
            (acc, a) => {
                if(!a)
                    return acc;
                acc[a.split('_')[0]] = true; 
                return acc;
            }, {}));
    console.log(uniqueAddress.length);

    // chunkSave(interestingBlobs)
    fs.writeFileSync(`./data/userBlobs.json`, JSON.stringify(interestingBlobs, null, 2));
    const blobCount = interestingBlobs.map(b => b.length);
} 

main();
