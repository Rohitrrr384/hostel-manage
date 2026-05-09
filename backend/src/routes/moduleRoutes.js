import { Router } from 'express';
import {
  createFee,
  createLaundry,
  createLostFound,
  createMarketplace,
  createNotice,
  createRoom,
  createUser,
  createVisitor,
  deleteLaundry,
  deleteNotice,
  listFees,
  listLaundry,
  listLostFound,
  listMarketplace,
  listNotices,
  listNotifications,
  listRooms,
  listUsers,
  listVisitors,
  markNotificationRead,
  registerStudent,
  updateFee,
  updateLaundry,
  updateLostFound,
  updateMarketplace,
  updateNotice,
  updateRoom,
  updateUser,
  updateVisitor,
} from '../controllers/moduleController.js';
import { authorize, protect } from '../middleware/authMiddleware.js';

export const noticeRoutes = Router();
noticeRoutes.use(protect);
noticeRoutes.route('/').get(listNotices).post(authorize('warden', 'admin'), createNotice);
noticeRoutes.route('/:id').patch(authorize('warden', 'admin'), updateNotice).delete(authorize('warden', 'admin'), deleteNotice);

export const visitorRoutes = Router();
visitorRoutes.use(protect);
visitorRoutes.route('/').get(listVisitors).post(authorize('student'), createVisitor);
visitorRoutes.patch('/:id', authorize('security', 'warden', 'admin'), updateVisitor);

export const laundryRoutes = Router();
laundryRoutes.use(protect);
laundryRoutes.route('/').get(listLaundry).post(authorize('student'), createLaundry);
laundryRoutes.route('/:id').patch(authorize('mess', 'warden', 'admin'), updateLaundry).delete(authorize('student', 'admin'), deleteLaundry);

export const roomRoutes = Router();
roomRoutes.use(protect, authorize('warden', 'admin'));
roomRoutes.route('/').get(listRooms).post(createRoom);
roomRoutes.patch('/:id', updateRoom);

export const marketplaceRoutes = Router();
marketplaceRoutes.use(protect);
marketplaceRoutes.route('/').get(listMarketplace).post(authorize('student'), createMarketplace);
marketplaceRoutes.patch('/:id', authorize('student', 'admin'), updateMarketplace);

export const lostFoundRoutes = Router();
lostFoundRoutes.use(protect);
lostFoundRoutes.route('/').get(listLostFound).post(authorize('student'), createLostFound);
lostFoundRoutes.patch('/:id', authorize('student', 'warden', 'admin'), updateLostFound);

export const notificationRoutes = Router();
notificationRoutes.use(protect);
notificationRoutes.get('/', listNotifications);
notificationRoutes.patch('/:id/read', markNotificationRead);

export const feeRoutes = Router();
feeRoutes.use(protect);
feeRoutes.route('/').get(listFees).post(authorize('admin'), createFee);
feeRoutes.patch('/:id', authorize('admin'), updateFee);

export const userRoutes = Router();
userRoutes.use(protect, authorize('admin'));
userRoutes.post('/students', registerStudent);
userRoutes.route('/').get(listUsers).post(createUser);
userRoutes.patch('/:id', updateUser);
