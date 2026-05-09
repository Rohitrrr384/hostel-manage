import mongoose from 'mongoose';
import { nanoid } from 'nanoid';

const appNotificationSchema = new mongoose.Schema(
  {
    id: { type: String, default: () => nanoid(10), unique: true, index: true },
    userId: { type: String, required: true, index: true },
    title: { type: String, required: true },
    body: { type: String, required: true },
    type: { type: String, required: true },
    data: mongoose.Schema.Types.Mixed,
    isRead: { type: Boolean, default: false },
  },
  { timestamps: true, id: false },
);

export const AppNotification = mongoose.model('AppNotification', appNotificationSchema);
