import { MealAttendance, MessFeedback, MessMenu } from '../models/Mess.js';
import { asyncHandler } from '../utils/asyncHandler.js';
import { createOne, list, updateOne } from './crudController.js';

export const listMenus = list(MessMenu);
export const createMenu = createOne(MessMenu);
export const updateMenu = updateOne(MessMenu);

export const getTodayAttendance = asyncHandler(async (req, res) => {
  const start = new Date();
  start.setHours(0, 0, 0, 0);
  const end = new Date(start);
  end.setDate(end.getDate() + 1);

  const attendance = await MealAttendance.findOne({
    studentId: req.user.id,
    date: { $gte: start, $lt: end },
  });

  res.json({ success: true, data: attendance });
});

export const upsertAttendance = asyncHandler(async (req, res) => {
  const start = new Date(req.body.date || Date.now());
  start.setHours(0, 0, 0, 0);

  const attendance = await MealAttendance.findOneAndUpdate(
    { studentId: req.user.id, date: start },
    { ...req.body, studentId: req.user.id, date: start },
    { upsert: true, new: true, runValidators: true },
  );

  res.json({ success: true, data: attendance });
});

export const listFeedback = list(MessFeedback);
export const createFeedback = createOne(MessFeedback, (req) => ({ ...req.body, studentId: req.user.id }));
