import bcrypt from 'bcryptjs';
import mongoose from 'mongoose';
import { nanoid } from 'nanoid';

const userSchema = new mongoose.Schema(
  {
    id: { type: String, default: () => nanoid(10), unique: true, index: true },
    name: { type: String, required: true, trim: true },
    email: { type: String, required: true, unique: true, lowercase: true, trim: true },
    phone: { type: String, required: true, trim: true },
    role: {
      type: String,
      enum: ['student', 'warden', 'security', 'mess', 'admin'],
      required: true,
      index: true,
    },
    passwordHash: { type: String, required: true, select: false },
    studentId: String,
    roomNumber: String,
    block: String,
    hostelName: String,
    profileImage: String,
    isActive: { type: Boolean, default: true },
  },
  { timestamps: true, id: false },
);

userSchema.virtual('createdAtIso').get(function createdAtIso() {
  return this.createdAt?.toISOString();
});

userSchema.methods.comparePassword = function comparePassword(password) {
  return bcrypt.compare(password, this.passwordHash);
};

userSchema.statics.hashPassword = function hashPassword(password) {
  return bcrypt.hash(password, 10);
};

export const User = mongoose.model('User', userSchema);
