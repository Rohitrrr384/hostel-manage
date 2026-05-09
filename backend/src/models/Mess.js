import mongoose from 'mongoose';
import { nanoid } from 'nanoid';

const messMenuSchema = new mongoose.Schema(
  {
    id: { type: String, default: () => nanoid(10), unique: true, index: true },
    date: { type: Date, required: true, index: true },
    breakfast: { type: String, required: true },
    lunch: { type: String, required: true },
    snacks: { type: String, required: true },
    dinner: { type: String, required: true },
    breakfastItems: [{ type: String }],
    lunchItems: [{ type: String }],
    snacksItems: [{ type: String }],
    dinnerItems: [{ type: String }],
  },
  { timestamps: true, id: false },
);

const mealAttendanceSchema = new mongoose.Schema(
  {
    id: { type: String, default: () => nanoid(10), unique: true, index: true },
    studentId: { type: String, required: true, index: true },
    date: { type: Date, required: true },
    breakfast: { type: Boolean, default: true },
    lunch: { type: Boolean, default: true },
    snacks: { type: Boolean, default: true },
    dinner: { type: Boolean, default: true },
  },
  { timestamps: true, id: false },
);

const messFeedbackSchema = new mongoose.Schema(
  {
    id: { type: String, default: () => nanoid(10), unique: true, index: true },
    studentId: { type: String, required: true, index: true },
    date: { type: Date, required: true },
    meal: { type: String, enum: ['breakfast', 'lunch', 'snacks', 'dinner'], required: true },
    rating: { type: Number, min: 1, max: 5, required: true },
    comment: String,
  },
  { timestamps: true, id: false },
);

export const MessMenu = mongoose.model('MessMenu', messMenuSchema);
export const MealAttendance = mongoose.model('MealAttendance', mealAttendanceSchema);
export const MessFeedback = mongoose.model('MessFeedback', messFeedbackSchema);
