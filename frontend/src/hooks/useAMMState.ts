import { useState, useEffect } from 'react';
import { AMMState } from '../types/contracts';
import ammService from '../services/api';

export const useAMMState = () => {
  const [state, setState] = useState<AMMState | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchState = async () => {
      try {
        const data = await ammService.getReserves();
        setState(data);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Failed to fetch AMM state');
      } finally {
        setLoading(false);
      }
    };

    fetchState();
  }, []);

  return { state, loading, error };
};
