
# Simple Wallet

This Solidity program is a simple wallet contract that demonstrates the use of `require()`, `assert()`, and `revert()` statements. The purpose of this program is to illustrate error handling in Solidity while providing basic wallet functionalities such as depositing, withdrawing, and checking balances.

## Description

This program is a smart contract written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain. The contract allows users to deposit Ether, withdraw Ether, check their balance, and reset their balance to zero. It incorporates error handling mechanisms (`require()`, `assert()`, and `revert()`) to ensure safe and expected execution of contract functions.

## Getting Started

### Executing Program

You can use Remix, an online Solidity IDE to run this program. To get started, visit the Remix website at [https://remix.ethereum.org](https://remix.ethereum.org/).

1. **Create a New File:**
    - Once on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar.
    - Save the file with a `.sol` extension (e.g., `SimpleWallet.sol`).
    - Copy and paste the following code into the file:

```solidity
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
```

### Compile the Code:

- Click on the "Solidity Compiler" tab in the left-hand sidebar.
- Make sure the "Compiler" option is set to `0.8.18` (or another compatible version), and then click on the "Compile SimpleWallet.sol" button.

### Deploy the Contract:

- Once the code is compiled, click on the "Deploy & Run Transactions" tab in the left-hand sidebar.
- Select the `SimpleWallet` contract from the dropdown menu, and then click on the "Deploy" button.

### Interact with the Contract:

Once the contract is deployed, you can interact with it using the available functions:
- **Deposit Ether:** Send Ether along with the transaction when calling the `deposit()` function.
- **Withdraw Ether:** Call the `withdraw(uint256 amount)` function with the amount you want to withdraw.
- **Check Balance:** Call the `checkBalance()` function to view your balance.
- **Reset Balance:** Call the `resetBalance()` function to reset your balance to zero.
- **Get Contract Balance:** Call the `getContractBalance()` function to view the total balance held by the contract.

## Authors

Nikhil Tripathi
@nikhil-tripathi


## License

This project is licensed under the MIT License - see the LICENSE.md file for details.
