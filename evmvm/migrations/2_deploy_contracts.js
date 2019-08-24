var Eval = artifacts.require("./Eval.sol");
var Empty = artifacts.require("./Empty.sol");

module.exports = async (deployer) => {
    await deployer.deploy(Eval);
    await deployer.deploy(Empty);
};
