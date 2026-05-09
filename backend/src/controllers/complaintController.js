import { Complaint } from '../models/Complaint.js';
import { createOne, getOne, list, updateOne } from './crudController.js';

export const listComplaints = list(Complaint, (req) => {
  if (req.user.role === 'student') return { studentId: req.user.id };
  if (req.query.status) return { status: req.query.status };
  return {};
});

export const getComplaint = getOne(Complaint);

export const createComplaint = createOne(Complaint, (req) => ({
  ...req.body,
  studentId: req.user.id,
  studentName: req.user.name,
  roomNumber: req.user.roomNumber,
}));

export const updateComplaint = updateOne(Complaint, (req) => {
  const payload = { ...req.body };
  if (payload.status === 'resolved') payload.resolvedAt = new Date();
  return payload;
});
