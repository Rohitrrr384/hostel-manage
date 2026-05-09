import mongoose from 'mongoose';
import { nanoid } from 'nanoid';

const roomSchema = new mongoose.Schema(
  {
    id: { type: String, default: () => nanoid(10), unique: true, index: true },
    number: { type: String, required: true },
    block: { type: String, required: true },
    hostel: { type: String, required: true },
    capacity: { type: Number, required: true },
    currentOccupancy: { type: Number, default: 0 },
    type: { type: String, enum: ['single', 'double', 'triple'], required: true },
    occupants: [{ type: String }],
    isAvailable: { type: Boolean, default: true },
  },
  { timestamps: true, id: false },
);

roomSchema.index({ number: 1, block: 1, hostel: 1 }, { unique: true });

export const Room = mongoose.model('Room', roomSchema);
