import { LeaveRequest } from '../models/LeaveRequest.js';
import { createOne, getOne, list, updateOne } from './crudController.js';

export const listLeaves = list(LeaveRequest, (req) => {
  if (req.user.role === 'student') return { studentId: req.user.id };
  if (req.query.status) return { status: req.query.status };
  return {};
});

export const getLeave = getOne(LeaveRequest);

export const createLeave = createOne(LeaveRequest, (req) => ({
  ...req.body,
  studentId: req.user.id,
  studentName: req.user.name,
  roomNumber: req.user.roomNumber,
}));

export const updateLeaveStatus = updateOne(LeaveRequest, (req) => ({
  status: req.body.status,
  wardenComment: req.body.wardenComment,
  qrCode: req.body.status === 'approved' ? `LEAVE-${req.params.id}` : undefined,
}));
