// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IERC20.sol";
import "./LPToken.sol";

contract AMM {
    IERC20 public token0;
    IERC20 public token1;
    LPToken public lpToken;

    uint256 public reserve0;
    uint256 public reserve1;

    event Swap(address indexed user, uint256 amount0, uint256 amount1, uint256 reserve0, uint256 reserve1);
    event Liquidity(address indexed user, uint256 amount0, uint256 amount1, uint256 lpAmount);

    constructor(address _token0, address _token1) {
        token0 = IERC20(_token0);
        token1 = IERC20(_token1);
        lpToken = new LPToken(address(this));
    }

    function addLiquidity(uint256 amount0, uint256 amount1) external returns (uint256 lpAmount) {
        require(amount0 > 0 && amount1 > 0, "Amounts must be > 0");

        // Transfer tokens from user to contract
        token0.transferFrom(msg.sender, address(this), amount0);
        token1.transferFrom(msg.sender, address(this), amount1);

        // Calculate LP tokens to mint
        if (reserve0 == 0 && reserve1 == 0) {
            lpAmount = amount0 + amount1; // Initial liquidity
        } else {
            lpAmount = (amount0 * lpToken.totalSupply()) / reserve0;
        }

        // Update reserves
        reserve0 += amount0;
        reserve1 += amount1;

        // Mint LP tokens
        lpToken.mint(msg.sender, lpAmount);

        emit Liquidity(msg.sender, amount0, amount1, lpAmount);
    }

    function removeLiquidity(uint256 lpAmount) external returns (uint256 amount0, uint256 amount1) {
        require(lpAmount > 0, "LP amount must be > 0");

        uint256 totalLP = lpToken.totalSupply();
        amount0 = (lpAmount * reserve0) / totalLP;
        amount1 = (lpAmount * reserve1) / totalLP;

        // Burn LP tokens
        lpToken.burn(msg.sender, lpAmount);

        // Update reserves
        reserve0 -= amount0;
        reserve1 -= amount1;

        // Transfer tokens back to user
        token0.transfer(msg.sender, amount0);
        token1.transfer(msg.sender, amount1);

        emit Liquidity(msg.sender, amount0, amount1, lpAmount);
    }

    function swap(uint256 amountIn, address tokenIn) external returns (uint256 amountOut) {
        require(amountIn > 0, "Amount must be > 0");
        require(tokenIn == address(token0) || tokenIn == address(token1), "Invalid token");

        bool isToken0 = tokenIn == address(token0);
        IERC20 inToken = isToken0 ? token0 : token1;
        IERC20 outToken = isToken0 ? token1 : token0;

        // Transfer in token
        inToken.transferFrom(msg.sender, address(this), amountIn);

        // Calculate output using x*y=k
        uint256 k = reserve0 * reserve1;
        uint256 newReserveIn = isToken0 ? reserve0 + amountIn : reserve1 + amountIn;
        uint256 newReserveOut = k / newReserveIn;
        uint256 oldReserveOut = isToken0 ? reserve1 : reserve0;

        amountOut = oldReserveOut - newReserveOut;

        // Update reserves
        if (isToken0) {
            reserve0 += amountIn;
            reserve1 -= amountOut;
        } else {
            reserve1 += amountIn;
            reserve0 -= amountOut;
        }

        // Transfer out token
        outToken.transfer(msg.sender, amountOut);

        emit Swap(msg.sender, amountIn, amountOut, reserve0, reserve1);
    }
}
