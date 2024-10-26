import 'package:flutter/material.dart';

class StaffDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, Staff!'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/manage_rooms');
              },
              child: Text('Manage Rooms'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/staff_history');
              },
              child: Text('View History'),
            ),
          ],
        ),
      ),
    );
  }
}
