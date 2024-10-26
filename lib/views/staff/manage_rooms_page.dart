// lib/views/student/room_list_page.dart
import 'package:flutter/material.dart';
import '../../models/room.dart';
import '../../services/api_service.dart';

class RoomList extends StatefulWidget {
  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  final ApiService apiService = ApiService();
  List<Room> rooms = [];

  @override
  void initState() {
    super.initState();
    fetchRooms();
  }

  Future<void> fetchRooms() async {
    try {
      rooms = await apiService.fetchRooms();
      setState(() {});
    } catch (e) {
      print('Error fetching rooms: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room List'),
      ),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(rooms[index].name),
          );
        },
      ),
    );
  }
}
