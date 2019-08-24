pragma solidity ^0.5.11;

contract Eval {

    function evaluate() external view returns(uint256) {
        address a = 0xC4dFd227848Fbe6640ab14c9C339845BEd350665;
        address b = 0xc9E094Deb826b00D10af0aB3D2A62d712e89F67A;

        return a.balance + b.balance;
    }

}
