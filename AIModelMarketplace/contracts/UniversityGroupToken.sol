// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract UniversityGroupToken is ERC20 {
    event TransactionInfo(string transactionDetails, uint256 timestamp);

    uint256 public latestTransactionTimestamp;
    string public latestTransactionDetails;

    constructor() ERC20("<University_name_your_Group_name>", "UGT") {
        _mint(msg.sender, 2000 * 10 ** decimals());
    }

    function logTransaction(address receiver, uint256 amount) public {
        _transfer(msg.sender, receiver, amount);
        latestTransactionTimestamp = block.timestamp;
        
        latestTransactionDetails = string(
            abi.encodePacked(
                "Sender: ", toAsciiString(msg.sender), 
                " Receiver: ", toAsciiString(receiver), 
                " Amount: ", uint2str(amount),
                " Timestamp: ", timestampToDateTime(block.timestamp)
            )
        );
        
        emit TransactionInfo(latestTransactionDetails, block.timestamp);
    }

    function getLastTransactionDetails() public view returns (string memory) {
        return latestTransactionDetails;
    }

    function timestampToDateTime(uint256 timestamp) internal pure returns (string memory) {
        uint256 daysSinceEpoch = timestamp / 86400;
        uint256 secondsInDay = timestamp % 86400;
        uint256 hour = (secondsInDay / 3600 + 5) % 24;
        uint256 minute = (secondsInDay % 3600) / 60;

        uint256 year = 1970;
        uint256[12] memory monthDays;
        
        monthDays[0] = 31;
        monthDays[1] = 28;
        monthDays[2] = 31;
        monthDays[3] = 30;
        monthDays[4] = 31;
        monthDays[5] = 30;
        monthDays[6] = 31;
        monthDays[7] = 31;
        monthDays[8] = 30;
        monthDays[9] = 31;
        monthDays[10] = 30;
        monthDays[11] = 31;

        while (daysSinceEpoch >= (isLeapYear(year) ? 366 : 365)) {
            daysSinceEpoch -= isLeapYear(year) ? 366 : 365;
            year++;
        }

        uint256 month;
        for (month = 0; month < 12; month++) {
            uint256 daysInMonth = monthDays[month];
            if (month == 1 && isLeapYear(year)) {
                daysInMonth = 29;
            }
            if (daysSinceEpoch < daysInMonth) {
                break;
            }
            daysSinceEpoch -= daysInMonth;
        }

        uint256 day = daysSinceEpoch + 1;
        return string(abi.encodePacked(uint2str(day), ".", uint2str(month + 1), ".", uint2str(year), " ", uint2str(hour), ":", uint2str(minute)));
    }

    function isLeapYear(uint256 year) internal pure returns (bool) {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    }

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

    function toAsciiString(address x) internal pure returns (string memory) {
        bytes32 value = bytes32(uint256(uint160(x)));
        bytes memory alphabet = "0123456789abcdef";
        bytes memory str = new bytes(42);
        str[0] = '0';
        str[1] = 'x';
        for (uint i = 0; i < 20; i++) {
            str[2+i*2] = alphabet[uint8(value[i + 12] >> 4)];
            str[3+i*2] = alphabet[uint8(value[i + 12] & 0x0f)];
        }
        return string(str);
    }
}
