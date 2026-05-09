import { Complaint } from '../models/Complaint.js';
import { LeaveRequest } from '../models/LeaveRequest.js';
import { Room } from '../models/Room.js';
import { User } from '../models/User.js';
import { Visitor } from '../models/Visitor.js';
import { asyncHandler } from '../utils/asyncHandler.js';

export const getAnalytics = asyncHandler(async (_req, res) => {
  const [users, students, rooms, leavesPending, complaintsOpen, visitorsInside] = await Promise.all([
    User.countDocuments({ isActive: true }),
    User.countDocuments({ role: 'student', isActive: true }),
    Room.find(),
    LeaveRequest.countDocuments({ status: 'pending' }),
    Complaint.countDocuments({ status: { $nin: ['resolved', 'closed'] } }),
    Visitor.countDocuments({ status: 'inside' }),
  ]);

  const capacity = rooms.reduce((sum, room) => sum + room.capacity, 0);
  const occupied = rooms.reduce((sum, room) => sum + room.currentOccupancy, 0);

  res.json({
    success: true,
    data: {
      activeUsers: users,
      students,
      totalRooms: rooms.length,
      capacity,
      occupied,
      occupancyRate: capacity ? Math.round((occupied / capacity) * 100) : 0,
      pendingLeaves: leavesPending,
      openComplaints: complaintsOpen,
      activeVisitors: visitorsInside,
    },
  });
});
