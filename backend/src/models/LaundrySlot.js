import mongoose from 'mongoose';
import { nanoid } from 'nanoid';

const laundrySlotSchema = new mongoose.Schema(
  {
    id: { type: String, default: () => nanoid(10), unique: true, index: true },
    studentId: { type: String, required: true, index: true },
    studentName: { type: String, required: true },
    roomNumber: { type: String, required: true },
    date: { type: Date, required: true },
    timeSlot: { type: String, required: true },
    itemCount: { type: Number, required: true, min: 1 },
    status: { type: String, enum: ['booked', 'collected', 'washing', 'drying', 'ready', 'delivered'], default: 'booked' },
  },
  { timestamps: true, id: false },
);

laundrySlotSchema.index({ date: 1, timeSlot: 1 }, { unique: true });

export const LaundrySlot = mongoose.model('LaundrySlot', laundrySlotSchema);
