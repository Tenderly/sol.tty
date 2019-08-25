var TDLY = artifacts.require("./TDLY.sol");
var TDLYScript = artifacts.require("./TDLYScript.sol");
var EvalFactory = artifacts.require("./EvalFactory.sol");
var Eval = artifacts.require("./Eval.sol");
var Empty = artifacts.require("./Empty.sol");
var Transfer = artifacts.require("./Transfer.sol");

module.exports = async (deployer) => {
    await deployer.deploy(TDLY);
    await deployer.deploy(TDLYScript);
    await deployer.deploy(EvalFactory);
    await deployer.deploy(Eval);
    await deployer.deploy(Empty);
    await deployer.deploy(Transfer);
};
