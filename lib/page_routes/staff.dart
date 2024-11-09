import 'package:flutter/material.dart';
import 'package:pro_mobile/views/browse.dart';
import 'package:pro_mobile/views/profile.dart';
import 'package:pro_mobile/views/staff/staff_dashboard.dart';
import 'package:pro_mobile/views/staff/staff_history_page.dart';

class StaffRoute extends StatefulWidget {
  final String userId;
  const StaffRoute({super.key, required this.userId});

  @override
  State<StaffRoute> createState() => _StaffRouteState();
}

class _StaffRouteState extends State<StaffRoute> {
  int _currentPageIndex = 0;
  late final List<Widget> _pagesOptions;

  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pagesOptions = <Widget>[
      const Browse(role: "staff"),
      const HistoryStaff(), // need to add userid
      const DashboardStaff(),
      Profile(userId: widget.userId, role: "staff")
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pagesOptions.elementAt(_currentPageIndex),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: const Color.fromRGBO(16, 80, 176, 1.0),
          height: 70,
          iconTheme: WidgetStateProperty.resolveWith(
              (Set<MaterialState> states) => states
                      .contains(MaterialState.selected)
                  ? const IconThemeData(color: Color.fromRGBO(16, 80, 176, 1.0))
                  : const IconThemeData(color: Colors.white)),
          labelTextStyle: MaterialStateProperty.resolveWith(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.selected)
                      ? const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)
                      : const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
          // labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          indicatorColor: Colors.white,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: NavigationBar(
          onDestinationSelected: _onItemTapped,
          indicatorColor: Colors.white,
          selectedIndex: _currentPageIndex,
          backgroundColor: const Color.fromRGBO(16, 80, 176, 1.0),
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home_rounded),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.history_rounded),
              icon: Icon(Icons.history_rounded),
              label: 'History',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.insert_chart_rounded),
              icon: Icon(Icons.insert_chart_outlined_rounded),
              label: 'Dashboard',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outline_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
