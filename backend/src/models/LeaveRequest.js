import mongoose from 'mongoose';
import { nanoid } from 'nanoid';

const leaveRequestSchema = new mongoose.Schema(
  {
    id: { type: String, default: () => nanoid(10), unique: true, index: true },
    studentId: { type: String, required: true, index: true },
    studentName: { type: String, required: true },
    roomNumber: { type: String, required: true },
    type: { type: String, enum: ['home', 'medical', 'emergency', 'outstation'], required: true },
    reason: { type: String, required: true },
    departureDate: { type: Date, required: true },
    returnDate: { type: Date, required: true },
    parentName: { type: String, required: true },
    parentContact: { type: String, required: true },
    status: { type: String, enum: ['pending', 'approved', 'rejected', 'cancelled'], default: 'pending', index: true },
    wardenComment: String,
    qrCode: String,
  },
  { timestamps: true, id: false },
);

export const LeaveRequest = mongoose.model('LeaveRequest', leaveRequestSchema);
