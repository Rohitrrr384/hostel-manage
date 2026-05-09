import { Router } from 'express';
import { createLeave, getLeave, listLeaves, updateLeaveStatus } from '../controllers/leaveController.js';
import { authorize, protect } from '../middleware/authMiddleware.js';

export const leaveRoutes = Router();

leaveRoutes.use(protect);
leaveRoutes.route('/').get(listLeaves).post(authorize('student'), createLeave);
leaveRoutes.get('/:id', getLeave);
leaveRoutes.patch('/:id/status', authorize('warden', 'admin'), updateLeaveStatus);
