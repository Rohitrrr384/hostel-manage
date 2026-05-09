import { User } from '../models/User.js';
import { ApiError } from '../utils/apiError.js';
import { asyncHandler } from '../utils/asyncHandler.js';
import { signToken, userPayload } from '../utils/sendToken.js';

export const login = asyncHandler(async (req, res) => {
  const { email, password } = req.body;
  if (!email || !password) {
    throw new ApiError(400, 'Email and password are required');
  }

  const user = await User.findOne({ email: email.toLowerCase() }).select('+passwordHash');
  if (!user || !(await user.comparePassword(password))) {
    throw new ApiError(401, 'Invalid email or password');
  }

  res.json({
    success: true,
    token: signToken(user),
    user: userPayload(user),
  });
});

export const me = asyncHandler(async (req, res) => {
  res.json({ success: true, user: userPayload(req.user) });
});

export const updateProfile = asyncHandler(async (req, res) => {
  const allowed = ['name', 'phone', 'roomNumber', 'profileImage'];
  for (const key of allowed) {
    if (req.body[key] !== undefined) req.user[key] = req.body[key];
  }
  await req.user.save();
  res.json({ success: true, user: userPayload(req.user) });
});
