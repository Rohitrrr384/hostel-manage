import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../utils/constants.dart';

class VisitorProvider extends ChangeNotifier {
  List<Visitor> _visitors = [];
  bool _isLoading = false;
 
  List<Visitor> get visitors => _visitors;
  bool get isLoading => _isLoading;
  List<Visitor> get activeVisitors =>
      _visitors.where((v) => v.status == VisitorStatus.inside).toList();
 
  Future<void> fetchVisitors() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    _visitors = _getMockVisitors();
    _isLoading = false;
    notifyListeners();
  }
 
  Future<bool> registerVisitor(Visitor visitor) async {
    await Future.delayed(const Duration(milliseconds: 800));
    _visitors.insert(0, visitor);
    notifyListeners();
    return true;
  }
 
  Future<bool> approveEntry(String id) async {
    final idx = _visitors.indexWhere((v) => v.id == id);
    if (idx == -1) return false;
    final old = _visitors[idx];
    _visitors[idx] = Visitor(
      id: old.id, studentId: old.studentId, studentName: old.studentName,
      roomNumber: old.roomNumber, visitorName: old.visitorName,
      visitorPhone: old.visitorPhone, relationship: old.relationship,
      purpose: old.purpose, status: VisitorStatus.inside,
      entryTime: DateTime.now(), createdAt: old.createdAt,
    );
    notifyListeners();
    return true;
  }
 
  Future<bool> recordExit(String id) async {
    final idx = _visitors.indexWhere((v) => v.id == id);
    if (idx == -1) return false;
    final old = _visitors[idx];
    _visitors[idx] = Visitor(
      id: old.id, studentId: old.studentId, studentName: old.studentName,
      roomNumber: old.roomNumber, visitorName: old.visitorName,
      visitorPhone: old.visitorPhone, relationship: old.relationship,
      purpose: old.purpose, status: VisitorStatus.exited,
      entryTime: old.entryTime, exitTime: DateTime.now(),
      createdAt: old.createdAt,
    );
    notifyListeners();
    return true;
  }
 
  List<Visitor> _getMockVisitors() => [
    Visitor(
      id: 'v1', studentId: 'st1', studentName: 'Arjun Sharma',
      roomNumber: 'A-205', visitorName: 'Ravi Sharma',
      visitorPhone: '9876500001', relationship: 'Father',
      purpose: 'Personal visit', status: VisitorStatus.inside,
      entryTime: DateTime.now().subtract(const Duration(hours: 1)),
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Visitor(
      id: 'v2', studentId: 'st2', studentName: 'Priya Patel',
      roomNumber: 'B-102', visitorName: 'Meera Patel',
      visitorPhone: '9876500002', relationship: 'Mother',
      purpose: 'Bringing food', status: VisitorStatus.pending,
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
  ];
}