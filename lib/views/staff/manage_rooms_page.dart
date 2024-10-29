import 'package:flutter/material.dart';
import 'package:pro_mobile/views/staff/staff_history_page.dart';
import 'package:pro_mobile/views/staff/manage_rooms_page.dart';
import 'package:pro_mobile/components/room_card.dart';

class ManageRooms extends StatefulWidget {
  const ManageRooms({super.key, required String roomId});

  @override
  State<ManageRooms> createState() => _ManageRoomsPageState();
}

class _ManageRoomsPageState extends State<ManageRooms> {
  int _currentIndex = 0; // Default to Home tab

  // ตัวอย่างข้อมูลห้อง
  final Map<int, Map<String, dynamic>> roomsSample = {
    1: {
      'role': 'admin',
      'roomId': '101',
      'roomName': 'Room A',
      'desc': 'Description A',
      'img': 'room_1.png',
      'slot_1': 'Available',
      'slot_2': 'Not Available',
      'slot_3': 'Available',
      'slot_4': 'Available',
    },
    2: {
      'role': 'student',
      'roomId': '102',
      'roomName': 'Room B',
      'desc': 'Description B',
      'img': 'room_1.png',
      'slot_1': 'Not Available',
      'slot_2': 'Available',
      'slot_3': 'Available',
      'slot_4': 'Not Available',
    },
    // เพิ่มข้อมูลห้องได้ตามต้องการ
  };

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // หน้า Home ใช้ RoomCard แทน ManageRoomsPage
          ListView.builder(
            itemCount: roomsSample.length,
            itemBuilder: (context, index) {
              final room = roomsSample[
                  index + 1]; // index + 1 because our keys start from 1
              return RoomCard(
                role: room!['role'],
                roomId: room['roomId'],
                roomName: room['roomName'],
                desc: room['desc'],
                img: room['img'],
                slot_1: room['slot_1'],
                slot_2: room['slot_2'],
                slot_3: room['slot_3'],
                slot_4: room['slot_4'],
              );
            },
          ),
          // หน้า History
          const Center(child: Text("History Page")),
          // หน้า Dashboard
          const Center(child: Text("Dashboard Page")),
          // หน้า Profile
          const Center(child: Text("Profile Page")),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1050B0),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart_outlined_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
