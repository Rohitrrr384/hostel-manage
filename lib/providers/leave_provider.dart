import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../utils/constants.dart';

class LeaveProvider extends ChangeNotifier {
  List<LeaveRequest> _requests = [];
  bool _isLoading = false;
 
  List<LeaveRequest> get requests => _requests;
  bool get isLoading => _isLoading;
 
  List<LeaveRequest> getStudentRequests(String studentId) =>
      _requests.where((r) => r.studentId == studentId).toList();
 
  List<LeaveRequest> getPendingRequests() =>
      _requests.where((r) => r.status == LeaveStatus.pending).toList();
 
  Future<void> fetchLeaveRequests({String? studentId}) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    _requests = _getMockLeaveRequests();
    _isLoading = false;
    notifyListeners();
  }
 
  Future<bool> submitLeaveRequest(LeaveRequest request) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 800));
    _requests.insert(0, request);
    _isLoading = false;
    notifyListeners();
    return true;
  }
 
  Future<bool> updateStatus(String id, LeaveStatus status, {String? comment}) async {
    final idx = _requests.indexWhere((r) => r.id == id);
    if (idx == -1) return false;
    final old = _requests[idx];
    _requests[idx] = LeaveRequest(
      id: old.id, studentId: old.studentId, studentName: old.studentName,
      roomNumber: old.roomNumber, type: old.type, reason: old.reason,
      departureDate: old.departureDate, returnDate: old.returnDate,
      parentName: old.parentName, parentContact: old.parentContact,
      status: status, wardenComment: comment, createdAt: old.createdAt,
      updatedAt: DateTime.now(),
    );
    notifyListeners();
    return true;
  }
 
  List<LeaveRequest> _getMockLeaveRequests() => [
    LeaveRequest(
      id: 'lr1', studentId: 'st1', studentName: 'Arjun Sharma',
      roomNumber: 'A-205', type: LeaveType.home, reason: 'Festival celebrations at home',
      departureDate: DateTime.now().add(const Duration(days: 2)),
      returnDate: DateTime.now().add(const Duration(days: 5)),
      parentName: 'Ravi Sharma', parentContact: '9876500001',
      status: LeaveStatus.pending, createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    LeaveRequest(
      id: 'lr2', studentId: 'st2', studentName: 'Priya Patel',
      roomNumber: 'B-102', type: LeaveType.medical, reason: 'Doctor appointment',
      departureDate: DateTime.now().subtract(const Duration(days: 1)),
      returnDate: DateTime.now().add(const Duration(days: 1)),
      parentName: 'Suresh Patel', parentContact: '9876500002',
      status: LeaveStatus.approved, createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    LeaveRequest(
      id: 'lr3', studentId: 'st3', studentName: 'Rahul Singh',
      roomNumber: 'C-301', type: LeaveType.emergency, reason: 'Family emergency',
      departureDate: DateTime.now().subtract(const Duration(hours: 5)),
      returnDate: DateTime.now().add(const Duration(days: 2)),
      parentName: 'Mohan Singh', parentContact: '9876500003',
      status: LeaveStatus.approved, createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
  ];
}