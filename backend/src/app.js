import cors from 'cors';
import express from 'express';
import rateLimit from 'express-rate-limit';
import helmet from 'helmet';
import morgan from 'morgan';
import { analyticsRoutes } from './routes/analyticsRoutes.js';
import { authRoutes } from './routes/authRoutes.js';
import { complaintRoutes } from './routes/complaintRoutes.js';
import { leaveRoutes } from './routes/leaveRoutes.js';
import { messRoutes } from './routes/messRoutes.js';
import {
  feeRoutes,
  laundryRoutes,
  lostFoundRoutes,
  marketplaceRoutes,
  noticeRoutes,
  notificationRoutes,
  roomRoutes,
  userRoutes,
  visitorRoutes,
} from './routes/moduleRoutes.js';
import { errorHandler, notFound } from './middleware/errorMiddleware.js';

export const app = express();

app.use(helmet());
const allowedOrigins = process.env.CLIENT_ORIGIN?.split(',').map((origin) => origin.trim()).filter(Boolean);
app.use(cors({
  origin: allowedOrigins?.length ? allowedOrigins : true,
  credentials: true,
}));
app.use(express.json({ limit: '2mb' }));
app.use(morgan(process.env.NODE_ENV === 'production' ? 'combined' : 'dev'));
app.use(rateLimit({ windowMs: 15 * 60 * 1000, limit: 300 }));

app.get('/health', (_req, res) => res.json({ success: true, service: 'HostelSync API' }));

app.use('/api/auth', authRoutes);
app.use('/api/leaves', leaveRoutes);
app.use('/api/complaints', complaintRoutes);
app.use('/api/mess', messRoutes);
app.use('/api/notices', noticeRoutes);
app.use('/api/visitors', visitorRoutes);
app.use('/api/laundry', laundryRoutes);
app.use('/api/rooms', roomRoutes);
app.use('/api/marketplace', marketplaceRoutes);
app.use('/api/lost-found', lostFoundRoutes);
app.use('/api/notifications', notificationRoutes);
app.use('/api/fees', feeRoutes);
app.use('/api/users', userRoutes);
app.use('/api/analytics', analyticsRoutes);

app.use(notFound);
app.use(errorHandler);
