// bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:pro_mobile/views/approver/approver_dashboard.dart';
import 'package:pro_mobile/views/approver/approver_history_page.dart';


class NavigationBarApprover extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavigationBarApprover({
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
          icon: Icon(Icons.approval),
          label: 'Approve Requests',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
      ],
    );
  }
}