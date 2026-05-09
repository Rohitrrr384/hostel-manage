import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';

class AppConstants {
  static const String appName = 'HostelSync';
  static const String appVersion = '1.0.0';
  static const String baseUrl = 'http://your-backend-url.com/api'; // Replace with actual URL

  // SharedPreferences Keys
  static const String keyAuthToken = 'auth_token';
  static const String keyUserData = 'user_data';
  static const String keyUserRole = 'user_role';
  static const String keyThemeMode = 'theme_mode';
  static const String keyNotifications = 'notifications';

  // Leave Types
  static const Map<LeaveType, String> leaveTypeNames = {
    LeaveType.home: 'Home Leave',
    LeaveType.medical: 'Medical Leave',
    LeaveType.emergency: 'Emergency Leave',
    LeaveType.outstation: 'Outstation Leave',
  };

  // Complaint Categories
  static const Map<ComplaintCategory, String> complaintCategoryNames = {
    ComplaintCategory.water: 'Water Issue',
    ComplaintCategory.electricity: 'Electricity',
    ComplaintCategory.wifi: 'WiFi Issue',
    ComplaintCategory.cleanliness: 'Cleanliness',
    ComplaintCategory.fan: 'Fan/Light',
    ComplaintCategory.furniture: 'Furniture',
    ComplaintCategory.harassment: 'Harassment',
    ComplaintCategory.other: 'Other',
  };

  // Laundry Time Slots
  static const List<String> laundrySlots = [
    '6:00 AM - 7:00 AM',
    '7:00 AM - 8:00 AM',
    '8:00 AM - 9:00 AM',
    '2:00 PM - 3:00 PM',
    '3:00 PM - 4:00 PM',
    '4:00 PM - 5:00 PM',
    '5:00 PM - 6:00 PM',
    '6:00 PM - 7:00 PM',
  ];

  // Blocks
  static const List<String> blocks = ['A', 'B', 'C', 'D', 'E'];
}

// ============================================================
// HELPER FUNCTIONS
// ============================================================

Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'pending': return AppTheme.warning;
    case 'approved': return AppTheme.success;
    case 'rejected': return AppTheme.error;
    case 'inprogress': case 'in_progress': return AppTheme.info;
    case 'resolved': return AppTheme.success;
    case 'cancelled': return AppTheme.textSecondary;
    default: return AppTheme.textSecondary;
  }
}

Color getPriorityColor(ComplaintPriority priority) {
  switch (priority) {
    case ComplaintPriority.low: return AppTheme.success;
    case ComplaintPriority.medium: return AppTheme.warning;
    case ComplaintPriority.high: return AppTheme.error;
    case ComplaintPriority.urgent: return const Color(0xFF7B0000);
  }
}

IconData getComplaintCategoryIcon(ComplaintCategory cat) {
  switch (cat) {
    case ComplaintCategory.water: return Icons.water_drop;
    case ComplaintCategory.electricity: return Icons.electric_bolt;
    case ComplaintCategory.wifi: return Icons.wifi;
    case ComplaintCategory.cleanliness: return Icons.cleaning_services;
    case ComplaintCategory.fan: return Icons.wind_power;
    case ComplaintCategory.furniture: return Icons.chair;
    case ComplaintCategory.harassment: return Icons.report;
    case ComplaintCategory.other: return Icons.more_horiz;
  }
}

IconData getNoticeCategoryIcon(NoticeCategory cat) {
  switch (cat) {
    case NoticeCategory.important: return Icons.priority_high;
    case NoticeCategory.urgent: return Icons.warning_amber;
    case NoticeCategory.events: return Icons.event;
    case NoticeCategory.exams: return Icons.school;
    case NoticeCategory.maintenance: return Icons.build;
    case NoticeCategory.general: return Icons.info;
  }
}

Color getNoticeCategoryColor(NoticeCategory cat) {
  switch (cat) {
    case NoticeCategory.important: return AppTheme.info;
    case NoticeCategory.urgent: return AppTheme.error;
    case NoticeCategory.events: return AppTheme.accent;
    case NoticeCategory.exams: return AppTheme.warning;
    case NoticeCategory.maintenance: return Colors.brown;
    case NoticeCategory.general: return AppTheme.textSecondary;
  }
}

Color getRoleColor(String role) {
  switch (role) {
    case 'student': return AppTheme.studentColor;
    case 'warden': return AppTheme.wardenColor;
    case 'security': return AppTheme.securityColor;
    case 'mess': return AppTheme.messColor;
    case 'admin': return AppTheme.adminColor;
    default: return AppTheme.primary;
  }
}

String formatDate(DateTime date) {
  final months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  return '${date.day} ${months[date.month - 1]}, ${date.year}';
}

String formatTime(DateTime time) {
  final h = time.hour > 12 ? time.hour - 12 : time.hour;
  final ampm = time.hour >= 12 ? 'PM' : 'AM';
  return '$h:${time.minute.toString().padLeft(2, '0')} $ampm';
}

String timeAgo(DateTime date) {
  final diff = DateTime.now().difference(date);
  if (diff.inMinutes < 1) return 'Just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  if (diff.inDays < 7) return '${diff.inDays}d ago';
  return formatDate(date);
}