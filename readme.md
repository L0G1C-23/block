# 🪙 DelegateFunds – Transparent Fund Delegation System

### 💡 One-liner
A blockchain-based smart contract that enables transparent, verifiable, and secure delegation of funds to trusted members.

---

## 📘 Overview

**DelegateFunds** is a decentralized smart contract system that allows an **owner** to delegate certain permissions to other accounts (called **delegates**).  
It ensures that all actions — fund transfers, ownership changes, and delegations — are **recorded on-chain**, guaranteeing **transparency, traceability, and trust**.

This project uses **Scaffold-ETH 2** as the framework and can be easily extended for real-world use cases like:
- Transparent fund management for startups or NGOs.
- Role-based access to treasury operations.
- Decentralized decision-making systems.

---

## 🚀 Features

- 👑 **Owner-controlled access:** The deployer of the contract is the default owner.
- 👥 **Delegate management:** Owner can assign or remove delegates.
- 💰 **Fund transfers:** Owner and delegates can send Ether from the contract safely.
- 🧾 **On-chain logs:** Every delegate action and fund transfer is permanently recorded.
- 🔒 **Secure execution:** Only authorized roles can execute sensitive actions.

---

## 🧩 Smart Contract Explanation

### `DelegateFunds.sol`
Located in:  
`packages/hardhat/contracts/DelegateFunds.sol`

#### Key Functions:
- `addDelegate(address _delegate)`  
  Adds a new delegate who can help manage funds.

- `removeDelegate(address _delegate)`  
  Removes delegate access.

- `deposit()`  
  Anyone can deposit Ether into the contract.

- `transferFunds(address payable _to, uint256 _amount)`  
  Allows the **owner** or a **delegate** to transfer funds from the contract balance.

- `getContractBalance()`  
  Returns the total ETH currently held in the contract.

- `isDelegate(address _user)`  
  Checks if a given address is currently a delegate.

#### Events:
- `DelegateAdded(address indexed delegate)`
- `DelegateRemoved(address indexed delegate)`
- `FundsTransferred(address indexed by, address indexed to, uint256 amount)`
- `Deposited(address indexed from, uint256 amount)`

---

## ⚙️ Deployment

### Deployment Script
File:  
`packages/hardhat/deploy/00_deploy_your_contract.ts`

This script:
1. Deploys the `DelegateFunds` contract using Hardhat.
2. Automatically logs the deployed address.
3. Saves deployment info for the frontend to use.

#### Example:
```typescript
const contract = await deploy("DelegateFunds", {
  from: deployer,
  args: [],
  log: true,
});
