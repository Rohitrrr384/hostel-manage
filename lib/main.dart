import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';
import 'screens/admin/admin_dashboard.dart';
import 'screens/admin/analytics_screen.dart';
import 'screens/admin/hostel_management_screen.dart';
import 'screens/admin/user_management_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/role_selection_screen.dart';
import 'screens/mess/feedback_screen.dart';
import 'screens/mess/meal_attendance_screen.dart';
import 'screens/mess/menu_management_screen.dart';
import 'screens/mess/mess_dashboard.dart';
import 'screens/security/gate_entry_logs_screen.dart';
import 'screens/security/qr_scanner_screen.dart';
import 'screens/security/security_dashboard.dart';
import 'screens/security/visitor_verification_screen.dart';
import 'screens/student/complaint_history_screen.dart';
import 'screens/student/complaint_screen.dart';
import 'screens/student/laundry_booking_screen.dart';
import 'screens/student/leave_history_screen.dart';
import 'screens/student/leave_request_screen.dart';
import 'screens/student/lost_found_screen.dart';
import 'screens/student/marketplace_screen.dart';
import 'screens/student/mess_menu_screen.dart';
import 'screens/student/notices_screen.dart';
import 'screens/student/profile_screen.dart';
import 'screens/student/student_dashboard.dart';
import 'screens/student/visitor_request_screen.dart';
import 'screens/warden/complaint_management_screen.dart';
import 'screens/warden/hostel_students_screen.dart';
import 'screens/warden/leave_approval_screen.dart';
import 'screens/warden/notices_management_screen.dart';
import 'screens/warden/warden_dashboard.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LeaveProvider()),
        ChangeNotifierProvider(create: (_) => ComplaintProvider()),
        ChangeNotifierProvider(create: (_) => MessProvider()),
        ChangeNotifierProvider(create: (_) => NoticeProvider()),
        ChangeNotifierProvider(create: (_) => VisitorProvider()),
        ChangeNotifierProvider(create: (_) => LaundryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Hostel',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
      routes: {
        '/login': (_) => const LoginScreen(),
        '/roles': (_) => const RoleSelectionScreen(),
        '/forgot-password': (_) => const ForgotPasswordScreen(),
        '/student': (_) => const StudentDashboard(),
        '/student/leave': (_) => const LeaveRequestScreen(),
        '/student/leave-history': (_) => const LeaveHistoryScreen(),
        '/student/complaints': (_) => const ComplaintScreen(),
        '/student/complaint-history': (_) => const ComplaintHistoryScreen(),
        '/student/mess': (_) => const MessMenuScreen(),
        '/student/laundry': (_) => const LaundryBookingScreen(),
        '/student/visitors': (_) => const VisitorRequestScreen(),
        '/student/notices': (_) => const NoticesScreen(),
        '/student/profile': (_) => const ProfileScreen(),
        '/student/marketplace': (_) => const MarketplaceScreen(),
        '/student/lost-found': (_) => const LostFoundScreen(),
        '/warden': (_) => const WardenDashboard(),
        '/warden/leaves': (_) => const LeaveApprovalScreen(),
        '/warden/complaints': (_) => const ComplaintManagementScreen(),
        '/warden/students': (_) => const HostelStudentsScreen(),
        '/warden/notices': (_) => const NoticesManagementScreen(),
        '/security': (_) => const SecurityDashboard(),
        '/security/visitors': (_) => const VisitorVerificationScreen(),
        '/security/logs': (_) => const GateEntryLogsScreen(),
        '/security/qr': (_) => const QrScannerScreen(),
        '/mess': (_) => const MessDashboard(),
        '/mess/menu': (_) => const MenuManagementScreen(),
        '/mess/attendance': (_) => const MealAttendanceScreen(),
        '/mess/feedback': (_) => const FeedbackScreen(),
        '/admin': (_) => const AdminDashboard(),
        '/admin/users': (_) => const UserManagementScreen(),
        '/admin/analytics': (_) => const AnalyticsScreen(),
        '/admin/hostels': (_) => const HostelManagementScreen(),
      },
    );
  }
}
