const Empty = artifacts.require("Empty");
const TDLYScript = artifacts.require("TDLYScript");

contract("Empty", async accounts => {
    it("call to eval does not fail", async () => {
        let instance = await Empty.deployed();

        const res = await instance.eval.call();

        console.log(res);
    });
});

contract("TDLYScript", async accounts => {
    it("call to eval does not fail", async () => {
        let instance = await TDLYScript.deployed();

        const res = await instance.eval.sendTransaction({from: accounts[0]});

        console.log(res);
    });
});
