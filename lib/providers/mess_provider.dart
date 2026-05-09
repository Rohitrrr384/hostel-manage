import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../utils/constants.dart';

class MessProvider extends ChangeNotifier {
  List<MessMenu> _menus = [];
  MealAttendance? _todayAttendance;
  List<MessFeedback> _feedbacks = [];
  bool _isLoading = false;
 
  List<MessMenu> get menus => _menus;
  MealAttendance? get todayAttendance => _todayAttendance;
  bool get isLoading => _isLoading;
 
  MessMenu? get todayMenu {
    final today = DateTime.now();
    try {
      return _menus.firstWhere((m) =>
        m.date.day == today.day &&
        m.date.month == today.month &&
        m.date.year == today.year,
      );
    } catch (_) { return null; }
  }
 
  Future<void> fetchMenu() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 800));
    _menus = _getMockMenus();
    _todayAttendance = MealAttendance(
      id: 'att1', studentId: 'st1', date: DateTime.now(),
      breakfast: true, lunch: true, snacks: true, dinner: true,
    );
    _isLoading = false;
    notifyListeners();
  }
 
  Future<void> updateMealAttendance(MealAttendance attendance) async {
    _todayAttendance = attendance;
    notifyListeners();
  }
 
  Future<bool> submitFeedback(MessFeedback feedback) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _feedbacks.insert(0, feedback);
    notifyListeners();
    return true;
  }
 
  List<MessMenu> _getMockMenus() {
    final today = DateTime.now();
    return List.generate(7, (i) {
      final date = today.add(Duration(days: i - 3));
      return MessMenu(
        id: 'menu$i', date: date,
        breakfast: 'Idli & Sambar', lunch: 'Rice, Dal, Sabzi, Roti',
        snacks: 'Tea & Biscuits', dinner: 'Chapati, Paneer Curry, Rice',
        breakfastItems: ['Idli (4 pcs)', 'Sambar', 'Coconut Chutney', 'Tea/Coffee'],
        lunchItems: ['Steamed Rice', 'Yellow Dal', 'Mix Veg', 'Roti (2)', 'Salad', 'Buttermilk'],
        snacksItems: ['Tea/Coffee', 'Biscuits', 'Seasonal Fruit'],
        dinnerItems: ['Chapati (3)', 'Paneer Butter Masala', 'Steamed Rice', 'Dal', 'Papad', 'Sweet'],
      );
    });
  }
}
 