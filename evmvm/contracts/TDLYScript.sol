pragma solidity >=0.4.21 <0.6.0;

import "./TDLY.sol";

contract TDLYScript {
    function eval() public {
        TDLY tdly = TDLY(0xc97C0D39cA20366E2C01069F2ABfDD50EF0394ca);

        tdly.addAllowance(address(this));
        tdly.transfer(0xFB38cb88D96276d9fB4Fed67c1C9839B3d822B1b, 1);
        tdly.transfer(0x4787CE2DCde562DdE2F9B1B14c691765eE9453d5, 1);
        tdly.transfer(0xAf387e63D09dc44511241716043711c6a90C825b, 1);
        tdly.transfer(0x081B0273cD285B7699194c346b76d5a558777B04, 1);
        tdly.transfer(0x3d8CfeD1Cab3864d89193317076A6fE019767215, 1);
    }
}
