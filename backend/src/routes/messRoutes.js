import { Router } from 'express';
import {
  createFeedback,
  createMenu,
  getTodayAttendance,
  listFeedback,
  listMenus,
  updateMenu,
  upsertAttendance,
} from '../controllers/messController.js';
import { authorize, protect } from '../middleware/authMiddleware.js';

export const messRoutes = Router();

messRoutes.use(protect);
messRoutes.route('/menus').get(listMenus).post(authorize('mess', 'admin'), createMenu);
messRoutes.patch('/menus/:id', authorize('mess', 'admin'), updateMenu);
messRoutes.route('/attendance/today').get(authorize('student'), getTodayAttendance).put(authorize('student'), upsertAttendance);
messRoutes.route('/feedback').get(authorize('mess', 'admin'), listFeedback).post(authorize('student'), createFeedback);
