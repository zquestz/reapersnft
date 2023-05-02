const HDWalletProvider = require('@truffle/hdwallet-provider');
require('dotenv').config();

module.exports = {
  compilers: {
    solc: {
      version: '0.8.19',
    },
  },
  plugins: ['truffle-plugin-verify'],
  api_keys: {
    etherscan: process.env.ETHERSCAN_API_KEY,
  },
  networks: {
    mainnet: {
      provider: () => {
        return new HDWalletProvider(process.env.MNEMONIC, `https://mainnet.infura.io/v3/${process.env.INFURA_ID}`);
      },
      gas: 0x7a1200,
      network_id: 1,
      skipDryRun: true,
    },
    goerli: {
      provider: () => {
        return new HDWalletProvider(process.env.MNEMONIC, `https://goerli.infura.io/v3/${process.env.INFURA_ID}`);
      },
      gas: 0x7a1200,
      network_id: 5,
      skipDryRun: true,
    },
  },
};
