// import 'package:flutter/material.dart';
// import 'booking_form_page.dart';
// import 'booking_status_page.dart';
// import 'home.dart';
// import 'room_list_page.dart';
// import 'student_history_page.dart';

// class User extends StatefulWidget {
//   @override
//   State<User> createState() => _UserState();
// }

// class _UserState extends State<User> {
//   int _currentIndex = 0;

//   // List of pages to display in each tab
//   final List<Widget> _pages = [
//     Homepage(), // Home Page
//     BookingStatus(), // Status Page
//     History(), // History Page
//     Browse(), // Profile Page (or whichever page you'd like here)
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _currentIndex,
//         children: _pages,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: const Color(0xFF1050B0),
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white70,
//         currentIndex: _currentIndex,
//         onTap: _onItemTapped,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.check_circle_outline_outlined),
//             label: 'Status',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history),
//             label: 'History',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_2_outlined),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }
