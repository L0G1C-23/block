// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DelegateFunds {
    address public owner;
    uint256 public totalFunds;
    mapping(address => uint256) public delegatedAmount;
    mapping(address => bool) public verifiedDelegates;

    event FundsDelegated(address indexed from, address indexed to, uint256 amount);
    event FundsWithdrawn(address indexed by, uint256 amount);
    event DelegateVerified(address indexed delegate, bool status);
    event OwnershipTransferred(address indexed oldOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    constructor(address _owner) {
        owner = _owner;
    }

    // ✅ Transfer ownership
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

    function deposit() external payable {
        require(msg.value > 0, "Must send ETH");
        totalFunds += msg.value;
    }

    function verifyDelegate(address _delegate, bool _status) external onlyOwner {
        verifiedDelegates[_delegate] = _status;
        emit DelegateVerified(_delegate, _status);
    }

    function delegateFunds(address payable _delegate, uint256 _amount) external onlyOwner {
        require(verifiedDelegates[_delegate], "Delegate not verified");
        require(_amount <= address(this).balance, "Insufficient balance");
        delegatedAmount[_delegate] += _amount;
        _delegate.transfer(_amount);
        emit FundsDelegated(msg.sender, _delegate, _amount);
    }

    function withdrawFunds(uint256 _amount) external {
        require(delegatedAmount[msg.sender] >= _amount, "Not enough funds");
        delegatedAmount[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        emit FundsWithdrawn(msg.sender, _amount);
    }

    receive() external payable {
        totalFunds += msg.value;
    }
}
