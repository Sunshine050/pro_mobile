import 'package:flutter/material.dart';
import 'package:pro_mobile/views/student/student_history_page.dart'; 
import 'package:pro_mobile/views/browse.dart';

class Student extends StatefulWidget {
  const Student({Key? key}) : super(key: key);

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  int _currentIndex = 0;

  final Map<int, Map<String, dynamic>> roomsSample = {
    1: {
      "role": 'student',
      "roomId": '1',
      "roomName": 'Room 1',
      "desc": 'Lorem ipsum dolor sit amet...',
      "img": 'assets/rooms/room_1.jpg',
      "slot_1": "free",
      "slot_2": "free",
      "slot_3": "free",
      "slot_4": "free",
    },
    2: {
      "role": 'student',
      "roomId": '2',
      "roomName": 'Room 2',
      "desc": 'Lorem ipsum dolor sit amet...',
      "img": 'assets/rooms/room_1.jpg',
      "slot_1": "reserved",
      "slot_2": "reserved",
      "slot_3": "reserved",
      "slot_4": "reserved",
    },
    3: {
      "role": 'student',
      "roomId": '3',
      "roomName": 'Room 3',
      "desc": 'Lorem ipsum dolor sit amet...',
      "img": 'assets/rooms/room_1.jpg',
      "slot_1": "disable",
      "slot_2": "disable",
      "slot_3": "disable",
      "slot_4": "disable",
    },
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
          Browse(role : "Student"), // หน้า Home
          Center(
              child: Text('Status Page')), // อาจจะเพิ่มฟังก์ชันการทำงานที่นี่
          const History(), // คลาส History
          Center(child: Text('Profile Page')), // อาจจะเพิ่มข้อมูลโปรไฟล์ที่นี่
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1050B0),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline_outlined),
            label: 'Status',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
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
