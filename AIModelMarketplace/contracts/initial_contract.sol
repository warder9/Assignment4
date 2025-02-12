// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract UniversityGroupToken is ERC20 {
    // Events for logging transactions
    event TransactionInfo(address indexed sender, address indexed receiver, uint256 value, uint256 timestamp);

    uint256 public latestTransactionTimestamp; // Last transaction timestamp
    address public owner;

    // Constructor to initialize token and mint to the contract deployer
    constructor() ERC20("UniversityGroupToken", "UGT") {
        owner = msg.sender; // The owner is automatically the contract deployer
        _mint(owner, 2000 * 10 ** decimals()); // Initial supply of 2000 tokens to the deployer
    }

    // Function to log transaction information and update timestamp
    function logTransaction(address receiver, uint256 amount) public {
        _transfer(msg.sender, receiver, amount);
        latestTransactionTimestamp = block.timestamp;
        emit TransactionInfo(msg.sender, receiver, amount, block.timestamp);
    }

    // Function to retrieve the latest transaction timestamp
    function getLatestTransactionTimestamp() public view returns (uint256) {
        return latestTransactionTimestamp;
    }

    // Function to retrieve the address of the transaction sender
    function getTransactionSender() public view returns (address) {
        return msg.sender; // Use msg.sender instead of tx.origin
    }

    // Internal utility to convert uint256 to string
    function uint2str(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - (_i / 10) * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
}
