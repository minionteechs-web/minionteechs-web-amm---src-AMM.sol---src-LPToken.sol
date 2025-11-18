// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/AMM.sol";
import "../src/interfaces/IERC20.sol";

contract MockERC20 is IERC20 {
    string public name;
    string public symbol;
    uint8 public decimals = 18;
    
    uint256 private _totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

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

contract AMMTest is Test {
    AMM public amm;
    MockERC20 public token0;
    MockERC20 public token1;
    address public user = address(0x1);

    function setUp() public {
        token0 = new MockERC20("Token0", "TKN0");
        token1 = new MockERC20("Token1", "TKN1");
        amm = new AMM(address(token0), address(token1));

        // Mint tokens to user
        token0.mint(user, 1000 ether);
        token1.mint(user, 1000 ether);
    }

    function test_AddLiquidity() public {
        vm.startPrank(user);
        token0.approve(address(amm), 100 ether);
        token1.approve(address(amm), 100 ether);

        uint256 lpAmount = amm.addLiquidity(100 ether, 100 ether);
        
        assert(lpAmount > 0);
        assert(amm.reserve0() == 100 ether);
        assert(amm.reserve1() == 100 ether);
        vm.stopPrank();
    }

    function test_Swap() public {
        vm.startPrank(user);
        token0.approve(address(amm), 200 ether);
        token1.approve(address(amm), 100 ether);

        amm.addLiquidity(100 ether, 100 ether);
        
        uint256 amountOut = amm.swap(50 ether, address(token0));
        assert(amountOut > 0);
        vm.stopPrank();
    }

    function test_RemoveLiquidity() public {
        vm.startPrank(user);
        token0.approve(address(amm), 100 ether);
        token1.approve(address(amm), 100 ether);

        uint256 lpAmount = amm.addLiquidity(100 ether, 100 ether);
        
        (uint256 amount0, uint256 amount1) = amm.removeLiquidity(lpAmount);
        assert(amount0 > 0);
        assert(amount1 > 0);
        vm.stopPrank();
    }
}
