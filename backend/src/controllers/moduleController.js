import { AppNotification } from '../models/AppNotification.js';
import { HostelFee } from '../models/HostelFee.js';
import { LaundrySlot } from '../models/LaundrySlot.js';
import { LostFoundItem } from '../models/LostFoundItem.js';
import { MarketplaceItem } from '../models/MarketplaceItem.js';
import { Notice } from '../models/Notice.js';
import { Room } from '../models/Room.js';
import { User } from '../models/User.js';
import { Visitor } from '../models/Visitor.js';
import { ApiError } from '../utils/apiError.js';
import { asyncHandler } from '../utils/asyncHandler.js';
import { createOne, deleteOne, list, updateOne } from './crudController.js';

export const listNotices = list(Notice);
export const createNotice = createOne(Notice, (req) => ({ ...req.body, postedBy: req.user.name }));
export const updateNotice = updateOne(Notice);
export const deleteNotice = deleteOne(Notice);

export const listVisitors = list(Visitor, (req) => (req.user.role === 'student' ? { studentId: req.user.id } : {}));
export const createVisitor = createOne(Visitor, (req) => ({
  ...req.body,
  studentId: req.user.id,
  studentName: req.user.name,
  roomNumber: req.user.roomNumber,
}));
export const updateVisitor = updateOne(Visitor, (req) => {
  const payload = { ...req.body };
  if (payload.status === 'inside') payload.entryTime = new Date();
  if (payload.status === 'exited') payload.exitTime = new Date();
  return payload;
});

export const listLaundry = list(LaundrySlot, (req) => (req.user.role === 'student' ? { studentId: req.user.id } : {}));
export const createLaundry = createOne(LaundrySlot, (req) => ({
  ...req.body,
  studentId: req.user.id,
  studentName: req.user.name,
  roomNumber: req.user.roomNumber,
}));
export const updateLaundry = updateOne(LaundrySlot);
export const deleteLaundry = deleteOne(LaundrySlot);

export const listRooms = list(Room);
export const createRoom = createOne(Room);
export const updateRoom = updateOne(Room);

export const listMarketplace = list(MarketplaceItem, (req) => (req.query.mine ? { sellerId: req.user.id } : {}));
export const createMarketplace = createOne(MarketplaceItem, (req) => ({
  ...req.body,
  sellerId: req.user.id,
  sellerName: req.user.name,
  roomNumber: req.user.roomNumber,
}));
export const updateMarketplace = updateOne(MarketplaceItem);

export const listLostFound = list(LostFoundItem);
export const createLostFound = createOne(LostFoundItem, (req) => ({
  ...req.body,
  reportedBy: req.user.id,
  reporterName: req.user.name,
}));
export const updateLostFound = updateOne(LostFoundItem);

export const listNotifications = list(AppNotification, (req) => ({ userId: req.user.id }));
export const markNotificationRead = updateOne(AppNotification, () => ({ isRead: true }));

export const listFees = list(HostelFee, (req) => (req.user.role === 'student' ? { studentId: req.user.id } : {}));
export const createFee = createOne(HostelFee);
export const updateFee = updateOne(HostelFee);

export const listUsers = list(User);
export const createUser = asyncHandler(async (req, res) => {
  const { name, email, phone, role, password, ...rest } = req.body;
  if (!name || !email || !phone || !role) {
    throw new ApiError(400, 'name, email, phone and role are required');
  }

  const existing = await User.findOne({ email: email.toLowerCase() });
  if (existing) {
    throw new ApiError(409, 'A user with this email already exists');
  }

  const temporaryPassword = password || 'password';
  const passwordHash = await User.hashPassword(temporaryPassword);
  const user = await User.create({ ...rest, name, email, phone, role, passwordHash });

  res.status(201).json({
    success: true,
    message: 'User registered successfully',
    data: {
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      role: user.role,
      studentId: user.studentId,
      roomNumber: user.roomNumber,
      block: user.block,
      hostelName: user.hostelName,
      isActive: user.isActive,
      createdAt: user.createdAt,
    },
    credentials: {
      email: user.email,
      temporaryPassword,
    },
  });
});

export const registerStudent = asyncHandler(async (req, res) => {
  const {
    name,
    email,
    phone,
    studentId,
    roomNumber,
    block,
    hostelName,
    password,
    roomType = 'double',
    roomCapacity = 2,
  } = req.body;

  if (!name || !email || !phone || !studentId || !roomNumber || !block || !hostelName) {
    throw new ApiError(400, 'name, email, phone, studentId, roomNumber, block and hostelName are required');
  }

  const existing = await User.findOne({
    $or: [{ email: email.toLowerCase() }, { studentId }],
  });

  if (existing) {
    throw new ApiError(409, 'A user with this email or student ID already exists');
  }

  const temporaryPassword = password || `${studentId}@123`;
  const passwordHash = await User.hashPassword(temporaryPassword);

  const user = await User.create({
    name,
    email,
    phone,
    role: 'student',
    passwordHash,
    studentId,
    roomNumber,
    block,
    hostelName,
  });

  const room = await Room.findOneAndUpdate(
    { number: roomNumber, block, hostel: hostelName },
    {
      $setOnInsert: {
        number: roomNumber,
        block,
        hostel: hostelName,
        capacity: roomCapacity,
        type: roomType,
      },
      $addToSet: { occupants: user.id },
      $inc: { currentOccupancy: 1 },
    },
    { upsert: true, new: true, setDefaultsOnInsert: true },
  );

  room.isAvailable = room.currentOccupancy < room.capacity;
  await room.save();

  await AppNotification.create({
    userId: user.id,
    title: 'Welcome to HostelSync',
    body: `Your student account is ready. Login with ${email}.`,
    type: 'account',
  });

  res.status(201).json({
    success: true,
    message: 'Student registered successfully',
    data: user,
    credentials: {
      email: user.email,
      temporaryPassword,
    },
    room,
  });
});
export const updateUser = updateOne(User);
