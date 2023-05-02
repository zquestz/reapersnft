const ReapersRevengeNFT = artifacts.require('ReapersRevengeNFT');

module.exports = function (deployer) {
  deployer.deploy(ReapersRevengeNFT, "ipfs://unrevealed/");
};
