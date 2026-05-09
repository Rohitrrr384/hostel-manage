import mongoose from 'mongoose';
import { nanoid } from 'nanoid';

const complaintSchema = new mongoose.Schema(
  {
    id: { type: String, default: () => nanoid(10), unique: true, index: true },
    studentId: { type: String, required: true, index: true },
    studentName: { type: String, required: true },
    roomNumber: { type: String, required: true },
    category: {
      type: String,
      enum: ['water', 'electricity', 'wifi', 'cleanliness', 'fan', 'furniture', 'harassment', 'other'],
      required: true,
    },
    title: { type: String, required: true },
    description: { type: String, required: true },
    priority: { type: String, enum: ['low', 'medium', 'high', 'urgent'], default: 'medium' },
    status: { type: String, enum: ['pending', 'assigned', 'inProgress', 'resolved', 'closed'], default: 'pending' },
    images: [{ type: String }],
    assignedTo: String,
    resolution: String,
    rating: Number,
    ratingComment: String,
    resolvedAt: Date,
  },
  { timestamps: true, id: false },
);

export const Complaint = mongoose.model('Complaint', complaintSchema);
