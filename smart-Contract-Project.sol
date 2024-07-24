// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FunctionsErrors {
    uint256 private result;

    // Event to log when the result is updated
    event ResultUpdated(uint256 newResult);

    // Function to add a value to the result
    function add(uint256 value) public {
        require(value > 0, "Value must be positive");
        result += value;
        emit ResultUpdated(result);
    }

    // Function to get the current result
    function getResult() public view returns (uint256) {
        assert(result >= 0); // Ensuring the result is non-negative (though this is generally unnecessary as uint256 is always non-negative)
        return result;
    }

    // Function to reset the result to zero
    function resetResult() public {
        if (result == 0) {
            revert("Result is already zero");
        }
        result = 0;
        emit ResultUpdated(result);
    }

    // Function to subtract a value from the result
    function subtract(uint256 value) public {
        require(value > 0, "Value must be positive");
        require(result >= value, "Result cannot be negative");
        result -= value;
        emit ResultUpdated(result);
    }
}
