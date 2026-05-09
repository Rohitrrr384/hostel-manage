import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../utils/constants.dart';

class ComplaintProvider extends ChangeNotifier {
  List<Complaint> _complaints = [];
  bool _isLoading = false;
 
  List<Complaint> get complaints => _complaints;
  bool get isLoading => _isLoading;
 
  List<Complaint> getStudentComplaints(String studentId) =>
      _complaints.where((c) => c.studentId == studentId).toList();
 
  Future<void> fetchComplaints() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    _complaints = _getMockComplaints();
    _isLoading = false;
    notifyListeners();
  }
 
  Future<bool> submitComplaint(Complaint complaint) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 800));
    _complaints.insert(0, complaint);
    _isLoading = false;
    notifyListeners();
    return true;
  }
 
  Future<bool> updateStatus(String id, ComplaintStatus status, {String? assignedTo}) async {
    final idx = _complaints.indexWhere((c) => c.id == id);
    if (idx == -1) return false;
    final old = _complaints[idx];
    _complaints[idx] = Complaint(
      id: old.id, studentId: old.studentId, studentName: old.studentName,
      roomNumber: old.roomNumber, category: old.category, title: old.title,
      description: old.description, priority: old.priority, status: status,
      images: old.images, assignedTo: assignedTo ?? old.assignedTo,
      createdAt: old.createdAt,
      resolvedAt: status == ComplaintStatus.resolved ? DateTime.now() : null,
    );
    notifyListeners();
    return true;
  }
 
  Future<bool> rateComplaint(String id, double rating, String? comment) async {
    final idx = _complaints.indexWhere((c) => c.id == id);
    if (idx == -1) return false;
    final old = _complaints[idx];
    _complaints[idx] = Complaint(
      id: old.id, studentId: old.studentId, studentName: old.studentName,
      roomNumber: old.roomNumber, category: old.category, title: old.title,
      description: old.description, priority: old.priority, status: old.status,
      images: old.images, assignedTo: old.assignedTo, resolution: old.resolution,
      rating: rating, ratingComment: comment, createdAt: old.createdAt,
    );
    notifyListeners();
    return true;
  }
 
  List<Complaint> _getMockComplaints() => [
    Complaint(
      id: 'c1', studentId: 'st1', studentName: 'Arjun Sharma',
      roomNumber: 'A-205', category: ComplaintCategory.water,
      title: 'Water leakage in bathroom',
      description: 'There is a leakage near the shower pipe causing flooding.',
      priority: ComplaintPriority.high, status: ComplaintStatus.inProgress,
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      assignedTo: 'Plumber Team',
    ),
    Complaint(
      id: 'c2', studentId: 'st1', studentName: 'Arjun Sharma',
      roomNumber: 'A-205', category: ComplaintCategory.wifi,
      title: 'WiFi not working in room',
      description: 'Internet connectivity issues since 2 days.',
      priority: ComplaintPriority.medium, status: ComplaintStatus.pending,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Complaint(
      id: 'c3', studentId: 'st2', studentName: 'Priya Patel',
      roomNumber: 'B-102', category: ComplaintCategory.electricity,
      title: 'Tube light not working',
      description: 'The tube light in the study area has stopped working.',
      priority: ComplaintPriority.low, status: ComplaintStatus.resolved,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      resolvedAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];
}