import 'package:flutter/material.dart';

class RoomDetails extends StatelessWidget {
  final Map<String, dynamic> roomData;

  const RoomDetails({Key? key, required this.roomData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roomData['roomName'] ?? 'Room Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // แสดงรูปห้อง
            Image.asset(
              'assets/images/${roomData['img']}', // แก้ไขเส้นทางตามที่เก็บรูปภาพ
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            const SizedBox(height: 16),
            // แสดงข้อมูลห้อง
            Text(
              roomData['roomName'] ?? 'Unknown Room',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              roomData['desc'] ?? 'No description available.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            // แสดงสถานะของ slot
            Text('Available Slots:', style: Theme.of(context).textTheme.titleMedium),
            for (int i = 1; i <= 4; i++)
              Text('Slot $i: ${roomData['slot_$i']}'),
          ],
        ),
      ),
    );
  }
}
