const EvalFactory = artifacts.require("EvalFactory");

module.exports = function (deployer) {
  deployer.deploy(EvalFactory);
};
