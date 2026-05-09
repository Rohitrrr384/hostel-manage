import jwt from 'jsonwebtoken';

export function signToken(user) {
  return jwt.sign(
    { id: user._id.toString(), role: user.role },
    process.env.JWT_SECRET,
    { expiresIn: process.env.JWT_EXPIRES_IN || '7d' },
  );
}

export function userPayload(user) {
  return {
    id: user.id,
    name: user.name,
    email: user.email,
    phone: user.phone,
    role: user.role,
    studentId: user.studentId,
    roomNumber: user.roomNumber,
    block: user.block,
    hostelName: user.hostelName,
    profileImage: user.profileImage,
    isActive: user.isActive,
    createdAt: user.createdAt,
  };
}
