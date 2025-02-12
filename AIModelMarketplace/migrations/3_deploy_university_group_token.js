const UniversityGroupToken = artifacts.require("UniversityGroupToken");

module.exports = function (deployer) {
  deployer.deploy(UniversityGroupToken);
};