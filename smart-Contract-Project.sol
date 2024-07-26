// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleWallet {
    // Mapping to store the balance of each address
    mapping(address => uint256) private balances;

    // Event to log deposits
    event Deposit(address indexed account, uint256 amount);

    // Event to log withdrawals
    event Withdraw(address indexed account, uint256 amount);

    // Function to deposit Ether into the wallet
    function deposit() public payable {
        require(msg.value > 0, "Deposit value must be greater than 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Function to withdraw Ether from the wallet
    function withdraw(uint256 amount) public {
        require(amount > 0, "Withdraw amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // Before making the transfer, ensure no overflow
        uint256 initialBalance = address(this).balance;
        
        // Transfer the amount
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        balances[msg.sender] -= amount;
        emit Withdraw(msg.sender, amount);

        // Check the contract balance to ensure no unexpected changes
        assert(address(this).balance == initialBalance - amount);
    }

    // Function to check the balance of the caller
    function checkBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    // Function to reset the balance of the caller to zero
    function resetBalance() public {
        if (balances[msg.sender] == 0) {
            revert("Balance is already zero");
        }
        balances[msg.sender] = 0;
    }


    // Function to get the balance of the contract (total deposits - total withdrawals)
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
