import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../models/room.dart';

class RoomList extends StatefulWidget {
  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  ApiService apiService = ApiService();
  List<Room> rooms = [];

  @override
  void initState() {
    super.initState();
    fetchRooms();
  }

  void fetchRooms() async {
    try {
      List roomData = await apiService.fetchRooms();
      setState(() {
        rooms = roomData.map((data) => Room.fromJson(data)).toList();
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Rooms'),
      ),
      body: rooms.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                final room = rooms[index];
                return ListTile(
                  title: Text(room.name),
                  subtitle: Text('Status: ${room.status}'),
                  onTap: () {
                    Navigator.pushNamed(context,
                        '/booking_status'); // นำทางไปหน้า BookingStatus
                  },
                );
              },
            ),
    );
  }
}
