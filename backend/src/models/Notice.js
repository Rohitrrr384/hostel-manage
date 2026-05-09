import mongoose from 'mongoose';
import { nanoid } from 'nanoid';

const noticeSchema = new mongoose.Schema(
  {
    id: { type: String, default: () => nanoid(10), unique: true, index: true },
    title: { type: String, required: true },
    content: { type: String, required: true },
    category: { type: String, enum: ['important', 'urgent', 'events', 'exams', 'maintenance', 'general'], default: 'general' },
    postedBy: { type: String, required: true },
    attachments: [{ type: String }],
    isPinned: { type: Boolean, default: false },
    expiresAt: Date,
  },
  { timestamps: true, id: false },
);

export const Notice = mongoose.model('Notice', noticeSchema);
