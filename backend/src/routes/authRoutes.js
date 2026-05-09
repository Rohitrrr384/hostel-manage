import { Router } from 'express';
import { login, me, updateProfile } from '../controllers/authController.js';
import { protect } from '../middleware/authMiddleware.js';

export const authRoutes = Router();

authRoutes.post('/login', login);
authRoutes.get('/me', protect, me);
authRoutes.patch('/profile', protect, updateProfile);
