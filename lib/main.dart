import 'package:flutter/material.dart';
import 'package:pro_mobile/views/auth/login_page.dart';
import 'package:pro_mobile/views/auth/register_page.dart';
import 'package:pro_mobile/views/staff/manage_rooms_page.dart';
// import 'package:pro_mobile/views/homepage.dart';
// import 'package:pro_mobile/views/staff/manage_rooms_page.dart';
// import 'package:pro_mobile/views/approver/approver_dashboard.dart';
// import 'package:pro_mobile/views/approver/approver_history_page.dart';
// import 'package:pro_mobile/views/staff/staff_history_page.dart';
// import 'package:pro_mobile/views/staff/staff_dashboard.dart';
// import 'package:pro_mobile/views/student/booking_form_page.dart';
// import 'package:pro_mobile/views/student/booking_status_page.dart';
// import 'package:pro_mobile/views/student/student_history_page.dart';
// import 'package:pro_mobile/views/approver/approve_request_page.dart';
// import 'package:pro_mobile/widgets/NavigationBar_student.dart';
// import 'package:pro_mobile/widgets/browse.dart';
// import 'package:pro_mobile/views/profile.dart';
// import 'package:pro_mobile/widgets/NavigationBar_staff.dart';
// import 'package:pro_mobile/widgets/NavigationBar_approver.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Room Management App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Login() // หน้าหลักเป็น Login
        );
  }
}

class MainScreen extends StatefulWidget {
  final String role;

  const MainScreen({Key? key, required this.role}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late final List<Widget> _pages;
  late final Widget _bottomNavBar;

  @override
  void initState() {
    super.initState();
    // กำหนดหน้าตาม role
    _pages = _getPagesForRole(widget.role);
    _bottomNavBar = _getNavBarForRole(widget.role);
  }

  // กำหนดหน้าแสดงตาม role
  List<Widget> _getPagesForRole(String role) {
    if (role == 'student') {
      return [
        History(), // หน้า History
        Profile(
          userId: '1',
          role: '1',
        ), // หน้า Profile
      ];
    } else if (role == 'staff') {
      return [
        DashboardStaff(), // หน้า Dashboard ของ Staff
        HistoryStaff(), // หน้า History
        Profile(
          userId: '2',
          role: '1',
        ), // หน้า Profile
      ];
    } else if (role == 'approver') {
      return [
        DashboardStaff(), // หน้า Dashboard ของ Approver
        HistoryLec(), // หน้า History
        Profile(
          userId: '3',
          role: '1',
        ), // หน้า Profile
      ];
    } else {
      return [Login()]; // ถ้า role ไม่ถูกต้อง ให้แสดงหน้า Login
    }
  }

  // กำหนด NavigationBar ตาม role
  Widget _getNavBarForRole(String role) {
    switch (role) {
      case 'student':
        return NavigationBarStudent(
          currentIndex: _currentIndex,
          onTap: _onTap,
        );
      case 'staff':
        return NavigationBarStaff(
          currentIndex: _currentIndex,
          onTap: _onTap,
        );
      case 'approver':
        return NavigationBarApprover(
          currentIndex: _currentIndex,
          onTap: _onTap,
        );
      default:
        return SizedBox.shrink(); // ถ้า role ไม่ถูกต้อง ไม่แสดง NavigationBar
    }
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _bottomNavBar,
    );
  }
}
