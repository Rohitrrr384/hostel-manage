import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../utils/constants.dart';

class NoticeProvider extends ChangeNotifier {
  List<Notice> _notices = [];
  bool _isLoading = false;
 
  List<Notice> get notices => _notices;
  bool get isLoading => _isLoading;
  List<Notice> get pinnedNotices => _notices.where((n) => n.isPinned).toList();
 
  Future<void> fetchNotices() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 800));
    _notices = _getMockNotices();
    _isLoading = false;
    notifyListeners();
  }
 
  Future<bool> addNotice(Notice notice) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _notices.insert(0, notice);
    notifyListeners();
    return true;
  }
 
  Future<bool> deleteNotice(String id) async {
    _notices.removeWhere((n) => n.id == id);
    notifyListeners();
    return true;
  }
 
  List<Notice> _getMockNotices() => [
    Notice(
      id: 'n1', title: 'Hostel Fee Payment Deadline',
      content: 'All students are reminded to pay hostel fees by 30th of this month. Late payment will attract a fine of Rs. 50 per day. Contact the hostel office for any queries.',
      category: NoticeCategory.important, postedBy: 'Admin',
      isPinned: true, createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      expiresAt: DateTime.now().add(const Duration(days: 10)),
    ),
    Notice(
      id: 'n2', title: 'Annual Cultural Fest - Hostel Edition',
      content: 'We are organizing an annual cultural fest on 25th November. Students are encouraged to participate in various events like singing, dancing, and drama. Registration forms available at the hostel office.',
      category: NoticeCategory.events, postedBy: 'Student Council',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Notice(
      id: 'n3', title: 'Water Supply Interruption',
      content: 'Due to maintenance work, water supply will be interrupted on Sunday from 8 AM to 2 PM. Students are advised to store water in advance.',
      category: NoticeCategory.urgent, postedBy: 'Warden',
      isPinned: true, createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Notice(
      id: 'n4', title: 'End Semester Examination Schedule',
      content: 'End semester examinations will begin from December 1st. Hall tickets will be distributed from November 25th. Students must ensure no dues are pending.',
      category: NoticeCategory.exams, postedBy: 'Admin',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];
}