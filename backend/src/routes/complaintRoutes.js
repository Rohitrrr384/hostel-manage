import { Router } from 'express';
import { createComplaint, getComplaint, listComplaints, updateComplaint } from '../controllers/complaintController.js';
import { authorize, protect } from '../middleware/authMiddleware.js';

export const complaintRoutes = Router();

complaintRoutes.use(protect);
complaintRoutes.route('/').get(listComplaints).post(authorize('student'), createComplaint);
complaintRoutes.get('/:id', getComplaint);
complaintRoutes.patch('/:id', authorize('warden', 'admin'), updateComplaint);
complaintRoutes.patch('/:id/rating', authorize('student'), updateComplaint);
