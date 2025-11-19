import { Router, Request, Response } from 'express';
import { getReserves, simulateSwap, getLiquidityInfo } from '../controllers/amm.controller';

const router = Router();

router.get('/reserves', getReserves);
router.post('/simulate-swap', simulateSwap);
router.get('/liquidity-info/:address', getLiquidityInfo);

export default router;
