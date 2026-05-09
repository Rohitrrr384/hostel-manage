import mongoose from 'mongoose';
import { nanoid } from 'nanoid';

const visitorSchema = new mongoose.Schema(
  {
    id: { type: String, default: () => nanoid(10), unique: true, index: true },
    studentId: { type: String, required: true, index: true },
    studentName: { type: String, required: true },
    roomNumber: { type: String, required: true },
    visitorName: { type: String, required: true },
    visitorPhone: { type: String, required: true },
    relationship: { type: String, required: true },
    purpose: { type: String, required: true },
    numberOfVisitors: { type: Number, default: 1 },
    status: { type: String, enum: ['pending', 'approved', 'inside', 'exited', 'rejected'], default: 'pending' },
    qrCode: String,
    otp: String,
    entryTime: Date,
    exitTime: Date,
  },
  { timestamps: true, id: false },
);

export const Visitor = mongoose.model('Visitor', visitorSchema);
