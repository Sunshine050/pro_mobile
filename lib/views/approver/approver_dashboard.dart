import 'package:flutter/material.dart';

class ApproverDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approver Dashboard'),
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
            Text('Welcome, Approver!'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/approve_requests');
              },
              child: Text('Approve Booking Requests'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/approver_history');
              },
              child: Text('View History'),
            ),
          ],
        ),
      ),
    );
  }
}
