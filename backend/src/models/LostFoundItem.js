import mongoose from 'mongoose';
import { nanoid } from 'nanoid';

const lostFoundItemSchema = new mongoose.Schema(
  {
    id: { type: String, default: () => nanoid(10), unique: true, index: true },
    reportedBy: { type: String, required: true, index: true },
    reporterName: { type: String, required: true },
    type: { type: String, enum: ['lost', 'found'], required: true },
    title: { type: String, required: true },
    description: { type: String, required: true },
    location: { type: String, required: true },
    images: [{ type: String }],
    isResolved: { type: Boolean, default: false },
  },
  { timestamps: true, id: false },
);

export const LostFoundItem = mongoose.model('LostFoundItem', lostFoundItemSchema);
