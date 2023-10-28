// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WONDToken {
    string public name = "wonderful digital capitals and assets";
    string public symbol = "WOND";
    uint8 public decimals = 4;
    string public version = "1.0";
    uint256 public totalSupply = 10000000000 * 10**uint(decimals); // 10,000,000,000 WOND tokens
    //uint256 public nominalPriceInETH = 1 ether; // 1 ETH 
    uint256 public assessedValueInMATIC = 3000 ether; // 3000 MATIC
    string public theIssuers = "ITN 110200374556, ITN 7704277940";
    string public ensuringTheValueOfTokens = "human, social, natural capitals and assets of Russia";
    string public goalsOfImplementingOfTokens = "wonderful and charitable investments in the growth of human, social, natural capitals and assets for the Glory of God";

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event TokensMinted(address indexed to, uint256 value);
    event TokensBurned(address indexed from, uint256 value);


    address public owner = 0xF986372a9D7cb37315835Da5CcCb76ECCC84EF3b;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        balanceOf[owner] = totalSupply;
    }

    function transfer(address to, uint256 value) public returns (bool) {
        require(to != address(0), "Invalid address");
        require(balanceOf[msg.sender] >= value, "Insufficient balance");
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(from != address(0), "Invalid address");
        require(to != address(0), "Invalid address");
        require(balanceOf[from] >= value, "Insufficient balance");
        require(allowance[from][msg.sender] >= value, "Allowance exceeded");
        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }

    function mintTokens(address to, uint256 value) public onlyOwner {
        require(to != address(0), "Invalid address");
        require(value > 0, "Value must be greater than 0");
        require(balanceOf[to] + value >= balanceOf[to], "Recipient balance overflow");
        
        totalSupply += value;
        balanceOf[to] += value;
        emit Transfer(address(0), to, value);
        emit TokensMinted(to, value);
    }

    function burnTokens(uint256 value) public {
        require(balanceOf[msg.sender] >= value, "Insufficient balance");
        balanceOf[msg.sender] -= value;
        totalSupply -= value;
        emit Transfer(msg.sender, address(0), value);
        emit TokensBurned(msg.sender, value);
    }
}
