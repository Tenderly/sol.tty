const Empty = artifacts.require("Empty");

contract("Empty", async accounts => {
    it("call to eval does not fail", async () => {
        let instance = await Empty.deployed();

        const res = await instance.eval.call();

        console.log(res);
    });
});
