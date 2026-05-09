import mongoose from 'mongoose';
import { nanoid } from 'nanoid';

const hostelFeeSchema = new mongoose.Schema(
  {
    id: { type: String, default: () => nanoid(10), unique: true, index: true },
    studentId: { type: String, required: true, index: true },
    amount: { type: Number, required: true },
    dueDate: { type: Date, required: true },
    paidAt: Date,
    status: { type: String, enum: ['pending', 'paid', 'overdue'], default: 'pending' },
  },
  { timestamps: true, id: false },
);

export const HostelFee = mongoose.model('HostelFee', hostelFeeSchema);
