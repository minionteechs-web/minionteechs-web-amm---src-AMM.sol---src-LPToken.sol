import axios from 'axios';
import { AMMState, SwapParams } from '../types/contracts';

const API_URL = import.meta.env.REACT_APP_API_URL || 'http://localhost:3001/api';

const client = axios.create({
  baseURL: API_URL,
  timeout: 10000,
});

export const ammService = {
  getReserves: async (): Promise<AMMState> => {
    const { data } = await client.get('/amm/reserves');
    return data;
  },

  simulateSwap: async (params: SwapParams) => {
    const { data } = await client.post('/amm/simulate-swap', params);
    return data;
  },

  getLiquidityInfo: async (address: string) => {
    const { data } = await client.get(`/amm/liquidity-info/${address}`);
    return data;
  },
};

export default ammService;
