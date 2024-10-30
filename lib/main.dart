import 'package:flutter/material.dart';
import 'package:pro_mobile/views/browse.dart';
import 'package:pro_mobile/views/homepage.dart';
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
      title: 'Room Reservation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          // ManageRooms(
          //   roomId: "1",
          // ),
          // Browse(role: "staff"),
          const Homepage(), // ใช้คลาส Homepage เป็นหน้าแรก
      debugShowCheckedModeBanner: false, // ปิดแบนเนอร์โหมดตรวจสอบ
    );
  }
}
