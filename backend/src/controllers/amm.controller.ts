import { Request, Response } from 'express';
import { getAMMReserves, simulateAMMSwap } from '../services/amm.service';

export const getReserves = async (req: Request, res: Response) => {
  try {
    const reserves = await getAMMReserves();
    res.json(reserves);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch reserves' });
  }
};

export const simulateSwap = async (req: Request, res: Response) => {
  try {
    const { amountIn, tokenIn } = req.body;
    const result = await simulateAMMSwap(amountIn, tokenIn);
    res.json(result);
  } catch (error) {
    res.status(400).json({ error: 'Swap simulation failed' });
  }
};

export const getLiquidityInfo = async (req: Request, res: Response) => {
  try {
    const { address } = req.params;
    res.json({ address, lpBalance: '0' });
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch liquidity info' });
  }
};
