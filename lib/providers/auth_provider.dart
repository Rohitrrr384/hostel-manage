import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../utils/constants.dart';
class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String? _error;
 
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;
  String? get error => _error;
 
  AuthProvider() {
    _loadUser();
  }
 
  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(AppConstants.keyUserData);
    if (userData != null) {
      _user = UserModel.fromJson(json.decode(userData));
      notifyListeners();
    }
  }
 
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
 
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
 
      // Mock login - replace with real API
      _user = _getMockUser(email);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.keyUserData, json.encode(_user!.toJson()));
      await prefs.setString(AppConstants.keyAuthToken, 'mock_token_12345');
 
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
 
  UserModel _getMockUser(String email) {
    if (email.contains('warden')) {
      return UserModel(
        id: 'w1', name: 'Dr. Ramesh Kumar', email: email,
        phone: '9876543210', role: 'warden',
        hostelName: 'Boys Hostel A', createdAt: DateTime.now(),
      );
    } else if (email.contains('security')) {
      return UserModel(
        id: 's1', name: 'Shyam Singh', email: email,
        phone: '9876543211', role: 'security',
        createdAt: DateTime.now(),
      );
    } else if (email.contains('mess')) {
      return UserModel(
        id: 'm1', name: 'Suresh Babu', email: email,
        phone: '9876543212', role: 'mess',
        createdAt: DateTime.now(),
      );
    } else if (email.contains('admin')) {
      return UserModel(
        id: 'a1', name: 'Principal Admin', email: email,
        phone: '9876543213', role: 'admin',
        createdAt: DateTime.now(),
      );
    } else {
      return UserModel(
        id: 'st1', name: 'Arjun Sharma', email: email,
        phone: '9876543214', role: 'student',
        studentId: 'CS21B001', roomNumber: 'A-205',
        block: 'A', hostelName: 'Boys Hostel A',
        createdAt: DateTime.now(),
      );
    }
  }
 
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.keyUserData);
    await prefs.remove(AppConstants.keyAuthToken);
    _user = null;
    notifyListeners();
  }
 
  Future<bool> updateProfile(UserModel updatedUser) async {
    _isLoading = true;
    notifyListeners();
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _user = updatedUser;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.keyUserData, json.encode(_user!.toJson()));
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}