import 'package:flutter/material.dart';
import 'package:pro_mobile/views/approver/approve_request_page.dart';
import 'package:pro_mobile/views/approver/approver_history_page.dart';
import 'package:pro_mobile/views/browse.dart';
import 'package:pro_mobile/widgets/profile.dart';
import 'package:pro_mobile/views/staff/staff_dashboard.dart';
import 'package:pro_mobile/views/staff/staff_history_page.dart';
import 'package:pro_mobile/views/student/booking_status_page.dart';
import 'package:pro_mobile/views/student/student_history_page.dart';

class TabsbarNavigator extends StatefulWidget {
  final String role;
  const TabsbarNavigator({super.key, required this.role});

  @override
  State<TabsbarNavigator> createState() => _TabsbarNavigatorState();
}

class _TabsbarNavigatorState extends State<TabsbarNavigator> {
  Widget tabBuilder(String label, IconData icon, Widget toPage) {
    return Expanded(
      child: TextButton.icon(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => toPage),
        ),
        label: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          color: const Color.fromRGBO(16, 80, 176, 1.0),
          child: Builder(builder: (BuildContext context) {
            if (widget.role == "student") {
              return Row(
                children: [
                  tabBuilder("Home", Icons.home, Browse(role: widget.role)),
                  tabBuilder(
                      "Status", Icons.check_circle_outline, BookingStatus()),
                  tabBuilder("History", Icons.history, History()),
                  tabBuilder(
                      "Profile",
                      Icons.person,
                      Profile(
                        userId: "1",
                        role: widget.role,
                      )),
                ],
              );
            } else if (widget.role == "staff") {
              return Row(
                children: [
                  tabBuilder("Home", Icons.home, Browse(role: widget.role)),
                  tabBuilder("History", Icons.history, HistoryStaff()),
                  tabBuilder("Dashboard", Icons.insert_chart_outlined_outlined,
                      DashboardStaff()),
                  tabBuilder(
                      "Profile",
                      Icons.person,
                      Profile(
                        userId: "1",
                        role: widget.role,
                      )),
                ],
              );
            } else {
              return Row(
                children: [
                  tabBuilder("Home", Icons.home, Browse(role: widget.role)),
                  tabBuilder("Status", Icons.check_circle_outline,
                      ApproveRequestPage()),
                  tabBuilder("History", Icons.history, HistoryLec()),
                  tabBuilder("Dashboard", Icons.insert_chart_outlined_outlined,
                      DashboardStaff()),
                  tabBuilder(
                      "Profile",
                      Icons.person,
                      Profile(
                        userId: "1",
                        role: widget.role,
                      )),
                ],
              );
            }
          })),
    );
  }
}
