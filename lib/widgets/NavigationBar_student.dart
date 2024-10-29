// bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:pro_mobile/views/student/student_history_page.dart'; 
import 'package:pro_mobile/widgets/browse.dart';
class NavigationBarStudent extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavigationBarStudent({
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
          icon: Icon(Icons.book_online),
          label: 'Booking Form',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
      ],
    );
  }
}