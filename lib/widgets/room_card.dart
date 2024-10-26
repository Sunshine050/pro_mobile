import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  final String roomName;
  final String status;

  RoomCard({required this.roomName, required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(roomName),
        subtitle: Text('Status: $status'),
      ),
    );
  }
}
