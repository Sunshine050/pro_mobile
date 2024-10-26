import 'package:flutter/material.dart';
import 'views/auth/login_page.dart';
import 'views/auth/register_page.dart';
import 'views/student/student_dashboard.dart';
import 'views/student/room_list_page.dart';
import 'views/student/booking_status_page.dart';
import 'views/student/student_history_page.dart';
import 'views/staff/staff_dashboard.dart';
import 'views/staff/manage_rooms_page.dart';
import 'views/staff/staff_history_page.dart';
import 'views/approver/approver_dashboard.dart';
import 'views/approver/approver_history_page.dart';
import 'views/student/booking_form_page.dart';

Map<String, WidgetBuilder> routes = {
  '/login': (context) => LoginPage(),
  '/register': (context) => RegisterPage(),
  '/student/dashboard': (context) => StudentDashboard(),
  '/student/room-list': (context) => RoomList(),
  '/student/booking-status': (context) => BookingStatus(),
  '/student/history': (context) => StudentHistoryPage(),
  '/staff/dashboard': (context) => StaffDashboard(),
  '/staff/manage-rooms': (context) => ManageRooms(),
  '/staff/history': (context) => StaffHistoryPage(),
  '/approver/dashboard': (context) => ApproverDashboard(),
  '/approver/history': (context) => ApproverHistoryPage(),
  '/booking-form': (context) => BookingFormPage(),
};

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      initialRoute: '/login', // ตั้งค่าเส้นทางเริ่มต้นที่หน้าเข้าสู่ระบบ
      routes: routes,
    );
  }
}
