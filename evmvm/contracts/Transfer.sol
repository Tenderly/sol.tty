pragma solidity ^0.5.11;

contract Transfer {
    function evaluate() public payable {
        address payable[2] memory addresses = [
        0x06480C93a7Acc5769f63f2AF20A82069eDc2312d,
        0xC4dFd227848Fbe6640ab14c9C339845BEd350665
        ];

        for (uint i = 0; i < addresses.length; i++) {
            addresses[i].transfer(1000);
        }
    }
}
