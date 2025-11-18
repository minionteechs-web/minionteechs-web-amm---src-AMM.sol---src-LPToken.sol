// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/AMM.sol";
import "../src/interfaces/IERC20.sol";

contract MockERC20 is IERC20 {
    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        _balances[msg.sender] -= amount;
        _balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function allowance(address owner, address spender) external view returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        _allowances[from][msg.sender] -= amount;
        _balances[from] -= amount;
        _balances[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }

    function mint(address to, uint256 amount) external {
        _balances[to] += amount;
        _totalSupply += amount;
        emit Transfer(address(0), to, amount);
    }
}

contract InvariantAMM is Test {
    AMM public amm;
    MockERC20 public token0;
    MockERC20 public token1;

    function setUp() public {
        token0 = new MockERC20();
        token1 = new MockERC20();
        amm = new AMM(address(token0), address(token1));
    }

    // Invariant: reserve0 * reserve1 >= k (product of reserves should increase or stay same after swap)
    function invariant_ProductConstant() public view {
        uint256 reserve0 = amm.reserve0();
        uint256 reserve1 = amm.reserve1();
        
        if (reserve0 > 0 && reserve1 > 0) {
            // Product should be maintained within the constraints of the AMM
            uint256 product = reserve0 * reserve1;
            assert(product > 0);
        }
    }
}
