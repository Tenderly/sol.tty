const Eval = artifacts.require("Eval");

contract("Eval", async accounts => {
    // it("adds two numbers correctly", async () => {
    //     let instance = await Eval.deployed();
    //
    //     const res = await instance.eval.call("0x611234600220");
    // const res = await instance.eval.call("0x60ff60020160020300");
    //
    // console.log(res);
    // });

    it("processes an empty contract correctly", async () => {
        const code = "0x608060405260043610603f576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063c66478d5146044575b600080fd5b348015604f57600080fd5b5060566058565b005b5600a165627a7a72305820b1541a06a51fd17e270291a458f0688105feae44b3f810c2e914659ba887688d0029";
        const signature = "0xc66478d5";

        let instance = await Eval.deployed();

        // const res = await instance.eval.call(code, signature);
        const res = await instance.eval.sendTransaction(code, signature, {from: accounts[0]});

        console.log(res);
    })
});
