const ReapersRevengeNFT = artifacts.require('ReapersRevengeNFT');

module.exports = function (deployer) {
  deployer.deploy(ReapersRevengeNFT, "<INSERT_BASE_URI_HERE>");
};
