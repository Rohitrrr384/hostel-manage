import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../utils/constants.dart';

class LaundryProvider extends ChangeNotifier {
  List<LaundrySlot> _slots = [];
  bool _isLoading = false;
 
  List<LaundrySlot> get slots => _slots;
  bool get isLoading => _isLoading;
 
  List<LaundrySlot> getStudentSlots(String studentId) =>
      _slots.where((s) => s.studentId == studentId).toList();
 
  List<String> getBookedSlots(DateTime date) =>
      _slots.where((s) =>
        s.date.day == date.day &&
        s.date.month == date.month &&
        s.date.year == date.year
      ).map((s) => s.timeSlot).toList();
 
  Future<void> fetchSlots() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 800));
    _slots = _getMockSlots();
    _isLoading = false;
    notifyListeners();
  }
 
  Future<bool> bookSlot(LaundrySlot slot) async {
    await Future.delayed(const Duration(milliseconds: 800));
    _slots.insert(0, slot);
    notifyListeners();
    return true;
  }
 
  Future<bool> cancelSlot(String id) async {
    _slots.removeWhere((s) => s.id == id);
    notifyListeners();
    return true;
  }
 
  List<LaundrySlot> _getMockSlots() => [
    LaundrySlot(
      id: 'ls1', studentId: 'st1', studentName: 'Arjun Sharma',
      roomNumber: 'A-205', date: DateTime.now().add(const Duration(days: 1)),
      timeSlot: '6:00 AM - 7:00 AM', itemCount: 8,
      status: LaundryStatus.booked, createdAt: DateTime.now(),
    ),
  ];
}