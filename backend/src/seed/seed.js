import dotenv from 'dotenv';
import mongoose from 'mongoose';
import { connectDb } from '../config/db.js';
import { AppNotification } from '../models/AppNotification.js';
import { Complaint } from '../models/Complaint.js';
import { HostelFee } from '../models/HostelFee.js';
import { LaundrySlot } from '../models/LaundrySlot.js';
import { LeaveRequest } from '../models/LeaveRequest.js';
import { LostFoundItem } from '../models/LostFoundItem.js';
import { MarketplaceItem } from '../models/MarketplaceItem.js';
import { MealAttendance, MessFeedback, MessMenu } from '../models/Mess.js';
import { Notice } from '../models/Notice.js';
import { Room } from '../models/Room.js';
import { User } from '../models/User.js';
import { Visitor } from '../models/Visitor.js';

dotenv.config();

const today = new Date();
const addDays = (days) => new Date(today.getTime() + days * 24 * 60 * 60 * 1000);

async function seed() {
  await connectDb();

  await Promise.all([
    User.deleteMany({}),
    LeaveRequest.deleteMany({}),
    Complaint.deleteMany({}),
    MessMenu.deleteMany({}),
    MealAttendance.deleteMany({}),
    MessFeedback.deleteMany({}),
    Notice.deleteMany({}),
    Visitor.deleteMany({}),
    LaundrySlot.deleteMany({}),
    Room.deleteMany({}),
    MarketplaceItem.deleteMany({}),
    LostFoundItem.deleteMany({}),
    AppNotification.deleteMany({}),
    HostelFee.deleteMany({}),
  ]);

  const passwordHash = await User.hashPassword('password');
  const users = await User.insertMany([
    {
      id: 'st1',
      name: 'Arjun Sharma',
      email: 'student@hostelsync.app',
      phone: '9876543214',
      role: 'student',
      passwordHash,
      studentId: 'CS21B001',
      roomNumber: 'A-205',
      block: 'A',
      hostelName: 'Boys Hostel A',
    },
    {
      id: 'w1',
      name: 'Dr. Ramesh Kumar',
      email: 'warden@hostelsync.app',
      phone: '9876543210',
      role: 'warden',
      passwordHash,
      hostelName: 'Boys Hostel A',
    },
    { id: 's1', name: 'Shyam Singh', email: 'security@hostelsync.app', phone: '9876543211', role: 'security', passwordHash },
    { id: 'm1', name: 'Suresh Babu', email: 'mess@hostelsync.app', phone: '9876543212', role: 'mess', passwordHash },
    { id: 'a1', name: 'Principal Admin', email: 'admin@hostelsync.app', phone: '9876543213', role: 'admin', passwordHash },
  ]);

  await LeaveRequest.insertMany([
    {
      id: 'lr1',
      studentId: 'st1',
      studentName: 'Arjun Sharma',
      roomNumber: 'A-205',
      type: 'home',
      reason: 'Festival celebrations at home',
      departureDate: addDays(2),
      returnDate: addDays(5),
      parentName: 'Ravi Sharma',
      parentContact: '9876500001',
      status: 'pending',
    },
    {
      id: 'lr2',
      studentId: 'st2',
      studentName: 'Priya Patel',
      roomNumber: 'B-102',
      type: 'medical',
      reason: 'Doctor appointment',
      departureDate: addDays(-1),
      returnDate: addDays(1),
      parentName: 'Suresh Patel',
      parentContact: '9876500002',
      status: 'approved',
      qrCode: 'LEAVE-lr2',
    },
  ]);

  await Complaint.insertMany([
    {
      id: 'c1',
      studentId: 'st1',
      studentName: 'Arjun Sharma',
      roomNumber: 'A-205',
      category: 'water',
      title: 'Water leakage in bathroom',
      description: 'Leakage near shower pipe causing flooding.',
      priority: 'high',
      status: 'inProgress',
      assignedTo: 'Plumber Team',
    },
    {
      id: 'c2',
      studentId: 'st1',
      studentName: 'Arjun Sharma',
      roomNumber: 'A-205',
      category: 'wifi',
      title: 'WiFi not working in room',
      description: 'Internet connectivity issues since two days.',
      priority: 'medium',
      status: 'pending',
    },
  ]);

  await MessMenu.insertMany(
    Array.from({ length: 7 }, (_, index) => ({
      id: `menu${index + 1}`,
      date: addDays(index - 3),
      breakfast: 'Idli & Sambar',
      lunch: 'Rice, Dal, Sabzi, Roti',
      snacks: 'Tea & Biscuits',
      dinner: 'Chapati, Paneer Curry, Rice',
      breakfastItems: ['Idli (4 pcs)', 'Sambar', 'Coconut Chutney', 'Tea/Coffee'],
      lunchItems: ['Steamed Rice', 'Yellow Dal', 'Mix Veg', 'Roti', 'Salad'],
      snacksItems: ['Tea/Coffee', 'Biscuits', 'Seasonal Fruit'],
      dinnerItems: ['Chapati', 'Paneer Butter Masala', 'Rice', 'Dal', 'Sweet'],
    })),
  );

  await MealAttendance.create({
    id: 'att1',
    studentId: 'st1',
    date: today,
    breakfast: true,
    lunch: true,
    snacks: true,
    dinner: true,
  });

  await MessFeedback.insertMany([
    { id: 'mf1', studentId: 'st1', date: today, meal: 'lunch', rating: 4.3, comment: 'Good dal and roti.' },
    { id: 'mf2', studentId: 'st1', date: today, meal: 'dinner', rating: 3.8, comment: 'Rice ran out early.' },
  ]);

  await Notice.insertMany([
    {
      id: 'n1',
      title: 'Hostel Fee Payment Deadline',
      content: 'All students are reminded to pay hostel fees by the 30th of this month.',
      category: 'important',
      postedBy: 'Admin',
      isPinned: true,
      expiresAt: addDays(10),
    },
    {
      id: 'n2',
      title: 'Water Supply Interruption',
      content: 'Water supply will be interrupted on Sunday from 8 AM to 2 PM.',
      category: 'urgent',
      postedBy: 'Warden',
      isPinned: true,
    },
  ]);

  await Visitor.insertMany([
    {
      id: 'v1',
      studentId: 'st1',
      studentName: 'Arjun Sharma',
      roomNumber: 'A-205',
      visitorName: 'Ravi Sharma',
      visitorPhone: '9876500001',
      relationship: 'Father',
      purpose: 'Personal visit',
      status: 'inside',
      entryTime: new Date(today.getTime() - 60 * 60 * 1000),
    },
    {
      id: 'v2',
      studentId: 'st1',
      studentName: 'Arjun Sharma',
      roomNumber: 'A-205',
      visitorName: 'Meera Sharma',
      visitorPhone: '9876500002',
      relationship: 'Mother',
      purpose: 'Bringing food',
      status: 'pending',
    },
  ]);

  await LaundrySlot.create({
    id: 'ls1',
    studentId: 'st1',
    studentName: 'Arjun Sharma',
    roomNumber: 'A-205',
    date: addDays(1),
    timeSlot: '6:00 AM - 7:00 AM',
    itemCount: 8,
    status: 'booked',
  });

  await Room.insertMany([
    { id: 'r1', number: 'A-205', block: 'A', hostel: 'Boys Hostel A', capacity: 2, currentOccupancy: 2, type: 'double', occupants: ['st1'], isAvailable: false },
    { id: 'r2', number: 'B-102', block: 'B', hostel: 'Girls Hostel B', capacity: 2, currentOccupancy: 1, type: 'double', occupants: ['st2'], isAvailable: true },
    { id: 'r3', number: 'C-301', block: 'C', hostel: 'Boys Hostel C', capacity: 3, currentOccupancy: 2, type: 'triple', occupants: ['st3'], isAvailable: true },
  ]);

  await MarketplaceItem.create({
    id: 'mp1',
    sellerId: 'st1',
    sellerName: 'Arjun Sharma',
    roomNumber: 'A-205',
    title: 'Engineering Graphics Kit',
    description: 'Mini drafter and drawing tools in good condition.',
    price: 650,
    category: 'books',
  });

  await LostFoundItem.create({
    id: 'lf1',
    reportedBy: 'st1',
    reporterName: 'Arjun Sharma',
    type: 'lost',
    title: 'Black wallet',
    description: 'Contains college ID and library card.',
    location: 'Mess hall',
  });

  await HostelFee.create({
    id: 'hf1',
    studentId: 'st1',
    amount: 45000,
    dueDate: addDays(20),
    status: 'pending',
  });

  await AppNotification.create({
    id: 'an1',
    userId: 'st1',
    title: 'Leave request received',
    body: 'Your leave request is pending warden approval.',
    type: 'leave',
    data: { leaveId: 'lr1' },
  });

  console.log(`Seeded HostelSync with ${users.length} demo users.`);
  await mongoose.disconnect();
}

seed().catch(async (error) => {
  console.error(error);
  await mongoose.disconnect();
  process.exit(1);
});
