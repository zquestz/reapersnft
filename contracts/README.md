# Reapers contract

## Prerequisites

- Node.js + Yarn

## Installation / setup

```
yarn
```

## Compiling contracts

```
yarn truffle compile
```

## Deploying

Note: `migrations/1_deploy_contracts.js` contains the initial base URL, so if you want to set that, make sure to change it in that file.

### Using the Truffle Dashboard + your MetaMask wallet (easiest)

In a separate terminal window:

```
yarn truffle dashboard
```

This should open a Truffle Dashboard page in your browser. Connect your MetaMask wallet on that page. Make sure your MM is connected to the right network.

Back in your main terminal window:

```
yarn truffle migrate --network dashboard
```

You should now see a transaction on your Truffle Dashboard page

### Using the Truffle console

Make sure you have your `.env` file set up with the correct mnemonic and Infura API key.

```
yarn truffle migrate --network goerli
yarn truffle migrate --network mainnet
```

For more networks, you'll need to extend the `truffle-config.js` file.

## Verifying on Etherscan + Sourcify

Make sure you have your `.env` file set up with the correct Etherscan API key.

Depending on which network you deployed to, run:

```
yarn truffle run verify ReapersRevengeNFT --network dashboard
yarn truffle run verify ReapersRevengeNFT --network goerli
yarn truffle run verify ReapersRevengeNFT --network mainnet
```
