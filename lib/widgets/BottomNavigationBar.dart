// import 'package:flutter/material.dart';

// class RoleBasedNavBar extends StatefulWidget {
//   final String role; // รับค่า role เป็น 'Student', 'Staff', หรือ 'Approver'

//   const RoleBasedNavBar({Key? key, required this.role}) : super(key: key);

//   @override
//   _RoleBasedNavBarState createState() => _RoleBasedNavBarState();
// }

// class _RoleBasedNavBarState extends State<RoleBasedNavBar> {
//   int _currentIndex = 0;

//   // ฟังก์ชันอัพเดต index เมื่อผู้ใช้แตะที่ไอเท็มใน BottomNavigationBar
//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // กำหนดรายการของ BottomNavigationBar ตาม role ของผู้ใช้
//     List<BottomNavigationBarItem> navItems;
//     if (widget.role == 'Student') {
//       navItems = [
//         BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
//         BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline_outlined), label: 'Status'),
//         BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
//         BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: 'Profile'),
//       ];
//     } else if (widget.role == 'Staff') {
//       navItems = [
//         BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
//         BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
//         BottomNavigationBarItem(icon: Icon(Icons.insert_chart_outlined_outlined), label: 'Dashboard'),
//         BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: 'Profile'),
//       ];
//     } else if (widget.role == 'Approver') {
//       navItems = [
//         BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
//         BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline_outlined), label: 'Status'),
//         BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
//         BottomNavigationBarItem(icon: Icon(Icons.insert_chart_outlined_outlined), label: 'Dashboard'),
//         BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: 'Profile'),
//       ];
//     } else {
//       navItems = []; // กรณีไม่มี role ที่ตรง
//     }

//     return Scaffold(
//       body: Center(
//         child: Text("Current Page: ${navItems[_currentIndex].label}"), // แสดงหน้าปัจจุบัน
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: const Color(0xFF1050B0),
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white70,
//         currentIndex: _currentIndex,
//         onTap: _onItemTapped,
//         items: navItems,
//       ),
//     );
//   }
// }
