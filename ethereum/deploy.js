// deploy code will go here
const HDWalletProvider = require('@truffle/hdwallet-provider');
const Web3 = require('web3');
const compiledFactory = require('./build/CampaignFactory.json');

const provider = new HDWalletProvider(
    '12 words',
    'infura endpoint' //infura endpoint
);

const web3= new Web3(provider);

const deploy = async () => {
    const accounts = await web3.eth.getAccounts();

    console.log('attempting to deploy from the account', accounts[0]);

    const result = await new web3.eth.Contract(JSON.parse(compiledFactory.interface))
        .deploy( {data: compiledFactory.bytecode } )
        .send( { from: accounts[0], gas: 1000000  } )

    console.log('Contract deployed to', result.options.address);
    provider.engine.stop();     //to prevent a hanging deployment
    
};

deploy();

// command - node deploy.js
// Contract deployed to 0x27d81BcFF791AAdc5d9eAD757f3612943Fc2709b