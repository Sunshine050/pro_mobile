import 'package:flutter/material.dart';

class StudentDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // TODO: Implement logout logic
              Navigator.pushNamed(context, '/login');
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, Student!'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/room_list');
              },
              child: Text('Browse Rooms'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/booking_status');
              },
              child: Text('Check Booking Status'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/student_history');
              },
              child: Text('View History'),
            ),
          ],
        ),
      ),
    );
  }
}
