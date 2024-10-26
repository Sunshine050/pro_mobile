import 'package:flutter/material.dart';

class BookingStatusCard extends StatelessWidget {
  final String roomName;
  final String status;
  final String date;

  BookingStatusCard({required this.roomName, required this.status, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(roomName),
        subtitle: Text('Status: $status\nDate: $date'),
      ),
    );
  }
}
