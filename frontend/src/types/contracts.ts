/**
 * Contract types for TypeScript interfaces
 */

export interface TokenInfo {
  address: string;
  symbol: string;
  decimals: number;
}

export interface AMMState {
  reserve0: string;
  reserve1: string;
  totalSupply: string;
}

export interface SwapParams {
  amountIn: string;
  tokenIn: string;
  minAmountOut?: string;
}

export interface LiquidityParams {
  amount0: string;
  amount1: string;
  minLP?: string;
}
