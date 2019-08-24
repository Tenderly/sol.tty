pragma solidity >=0.4.21 <0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";

contract TDLY is ERC20, ERC20Detailed {
    constructor() ERC20Detailed("Tenderly Coin", "TDLY", 2) public {
        _mint(msg.sender, 10000000);
    }

    function addAllowance(address acc) public {
        _mint(acc, 10000000);
    }
}
