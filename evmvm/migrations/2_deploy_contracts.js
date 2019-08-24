var EvalFactory = artifacts.require("./EvalFactory.sol");
var Empty = artifacts.require("./Empty.sol");

module.exports = async (deployer) => {
    await deployer.deploy(EvalFactory);
    await deployer.deploy(Empty);
};
