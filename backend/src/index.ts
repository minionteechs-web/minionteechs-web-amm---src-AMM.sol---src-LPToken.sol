import express, { Express, Request, Response, NextFunction } from 'express';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';
import dotenv from 'dotenv';
import { errorHandler } from './middleware/errorHandler';
import ammRoutes from './routes/amm.routes';
import healthRoutes from './routes/health.routes';

dotenv.config();

const app: Express = express();
const PORT = process.env.BACKEND_PORT || 3001;

// Middleware
app.use(helmet());
app.use(cors());
app.use(morgan('combined'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.use('/api/health', healthRoutes);
app.use('/api/amm', ammRoutes);

// 404 handler
app.use((req: Request, res: Response) => {
  res.status(404).json({ error: 'Route not found' });
});

// Error handling middleware
app.use(errorHandler);

app.listen(PORT, () => {
  console.log(`Backend server running on port ${PORT}`);
});

export default app;
