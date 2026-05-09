import { Router } from 'express';
import { getAnalytics } from '../controllers/analyticsController.js';
import { authorize, protect } from '../middleware/authMiddleware.js';

export const analyticsRoutes = Router();

analyticsRoutes.get('/', protect, authorize('admin', 'warden'), getAnalytics);
