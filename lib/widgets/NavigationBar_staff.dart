import 'package:flutter/material.dart';
import 'package:pro_mobile/views/staff/staff_history_page.dart';
import 'package:pro_mobile/views/staff/staff_dashboard.dart';
import 'package:pro_mobile/components/filters.dart'; // ตรวจสอบให้แน่ใจว่ามีการนำเข้า Filters
import 'package:pro_mobile/components/room_card.dart'; // ตรวจสอบให้แน่ใจว่ามีการนำเข้า RoomCard
import 'package:pro_mobile/components/search_btn.dart'; // ตรวจสอบให้แน่ใจว่ามีการนำเข้า SearchButton
import 'package:flutter/material.dart';

class NavigationBarStaff extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavigationBarStaff({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.meeting_room),
          label: 'Browse Rooms',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.room_preferences),
          label: 'Manage Rooms',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
      ],
    );
  }
}
