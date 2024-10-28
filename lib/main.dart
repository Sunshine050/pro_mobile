import 'package:flutter/material.dart';
import 'package:pro_mobile/views/auth/login_page.dart';
import 'package:pro_mobile/views/auth/register_page.dart';
import 'package:pro_mobile/views/staff/manage_rooms_page.dart';
import 'package:pro_mobile/views/approver/approver_dashboard.dart';
import 'package:pro_mobile/views/approver/approver_history_page.dart';
import 'package:pro_mobile/views/staff/manage_rooms_page.dart';
import 'package:pro_mobile/views/staff/staff_history_page.dart';
import 'package:pro_mobile/views/staff/staff_dashboard.dart';
import 'package:pro_mobile/views/student/booking_form_page.dart';
import 'package:pro_mobile/views/student/booking_status_page.dart';
import 'package:pro_mobile/views/student/room_list_page.dart';
import 'package:pro_mobile/views/student/student_history_page.dart';
import 'package:pro_mobile/views/student/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookingStatus(),
      debugShowCheckedModeBanner: false,
    );
  }
}
