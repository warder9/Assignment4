const UniversityGroupToken = artifacts.require("UniversityGroupToken");
const AIModelMarketplace = artifacts.require("AIModelMarketplace");

module.exports = function (deployer) {
  deployer.deploy(UniversityGroupToken).then(() => {
    return deployer.deploy(AIModelMarketplace, UniversityGroupToken.address);
  });
};