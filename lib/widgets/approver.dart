import 'package:flutter/material.dart';
import 'package:pro_mobile/views/approver/approver_dashboard.dart';
import 'package:pro_mobile/views/approver/approver_history_page.dart';



class Approver extends StatefulWidget {
  const Approver({super.key});

  @override
  State<Approver> createState() => _LecState();
}

class _LecState extends State<Approver> {
  int _currentIndex = 0; // Default to History tab

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
          // หน้า Home (สามารถเพิ่มได้)
          Center(child: Text('Home Page')),
          // หน้า Status (สามารถเพิ่มได้)
          Center(child: Text('Status Page')),
          // หน้า History
          const HistoryLec(),
          // หน้า Dashboard (สามารถเพิ่มได้)
          const DashboardLec(),
          // หน้า Profile (สามารถเพิ่มได้)
          Center(child: Text('Profile Page')),
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
            icon: Icon(Icons.check_circle_outline_outlined),
            label: 'Status',
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
