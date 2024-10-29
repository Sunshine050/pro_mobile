// import 'package:flutter/material.dart';
// import 'package:pro_mobile/views/staff/staff_history_page.dart';
// import 'package:pro_mobile/views/staff/staff_dashboard.dart';
// import 'package:pro_mobile/components/filters.dart'; // ตรวจสอบให้แน่ใจว่ามีการนำเข้า Filters
// import 'package:pro_mobile/components/room_card.dart'; // ตรวจสอบให้แน่ใจว่ามีการนำเข้า RoomCard
// import 'package:pro_mobile/components/search_btn.dart'; // ตรวจสอบให้แน่ใจว่ามีการนำเข้า SearchButton

// class Staff extends StatefulWidget {
//   const Staff({super.key});

//   @override
//   State<Staff> createState() => _StaffState();
// }

// class _StaffState extends State<Staff> {
//   int _currentIndex = 0; // Default to Home tab
//   List<Map<String, dynamic>> filteredRooms = []; // สำหรับเก็บห้องที่กรองแล้ว

//   // ตัวอย่างข้อมูลห้อง
//   final Map<int, Map<String, dynamic>> roomsSample = {
//     1: {
//       'role': 'staff',
//       'roomId': '001',
//       'roomName': 'Room A',
//       'desc': 'Description for Room A',
//       'img': 'path/to/image_a.jpg',
//       'slot_1': '9 AM - 10 AM',
//       'slot_2': '10 AM - 11 AM',
//       'slot_3': '11 AM - 12 PM',
//       'slot_4': '1 PM - 2 PM',
//     },
//     2: {
//       'role': 'staff',
//       'roomId': '002',
//       'roomName': 'Room B',
//       'desc': 'Description for Room B',
//       'img': 'path/to/image_b.jpg',
//       'slot_1': '10 AM - 11 AM',
//       'slot_2': '11 AM - 12 PM',
//       'slot_3': '1 PM - 2 PM',
//       'slot_4': '2 PM - 3 PM',
//     },
//   };

//   @override
//   void initState() {
//     super.initState();
//     filteredRooms = roomsSample.values.toList(); // กำหนดค่าเริ่มต้นให้กับห้องที่กรองแล้ว
//   }

//   void _filterRooms(String searchQuery) {
//     setState(() {
//       if (searchQuery.isEmpty) {
//         // ถ้าไม่มีการค้นหา ให้แสดงห้องทั้งหมด
//         filteredRooms = roomsSample.values.toList();
//       } else {
//         // กรองห้องตามคำค้นหา
//         filteredRooms = roomsSample.values.where((room) {
//           return room['roomName'].toLowerCase().contains(searchQuery.toLowerCase());
//         }).toList();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _currentIndex,
//         children: [
//           // Home Page
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       const Expanded(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(vertical: 8),
//                           child: Filters(),
//                         ),
//                       ),
//                       SearchButton(onSearch: (searchQuery) {
//                         _filterRooms(searchQuery); // เรียกใช้ฟังก์ชันกรองห้อง
//                       }),
//                     ],
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       padding: const EdgeInsets.only(bottom: 24),
//                       itemCount: filteredRooms.length,
//                       itemBuilder: (context, index) {
//                         final itemData = filteredRooms[index];
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8),
//                           child: RoomCard(
//                             role: itemData['role'] ?? 'student',
//                             roomId: itemData['roomId'] ?? '',
//                             roomName: itemData['roomName'] ?? 'Room Name',
//                             desc: itemData['desc'] ?? '',
//                             img: itemData['img'] ?? '',
//                             slot_1: itemData['slot_1'] ?? 'N/A',
//                             slot_2: itemData['slot_2'] ?? 'N/A',
//                             slot_3: itemData['slot_3'] ?? 'N/A',
//                             slot_4: itemData['slot_4'] ?? 'N/A',
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Center(child: Text('Status Page')), // อาจจะเพิ่มฟังก์ชันการทำงานที่นี่
//           const HistoryStaff(), // คลาส History
//           Center(child: Text('Profile Page')), // อาจจะเพิ่มข้อมูลโปรไฟล์ที่นี่
//         ],
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

//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }
// }
