import 'package:flutter/material.dart';

class Room {
  String id;
  String name;
  String status;

  Room({required this.id, required this.name, required this.status});
}

class StaffAddEditRoom extends StatefulWidget {
  final Room? room; // หากมีค่าแสดงว่าเป็นการแก้ไข

  const StaffAddEditRoom({Key? key, this.room}) : super(key: key);

  @override
  _StaffAddEditRoomState createState() => _StaffAddEditRoomState();
}

class _StaffAddEditRoomState extends State<StaffAddEditRoom> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _roomNameController = TextEditingController();
  String _status = 'free';

  @override
  void initState() {
    super.initState();
    if (widget.room != null) {
      _roomNameController.text = widget.room!.name;
      _status = widget.room!.status;
    }
  }

  // Function เพิ่มห้องใหม่
  void addRoom() {
    if (_formKey.currentState!.validate()) {
      // ทำการบันทึกข้อมูลในฐานข้อมูล
      // เช่น ใช้ service หรือ API เพื่อเพิ่มห้องใหม่
      print("Room added: ${_roomNameController.text}, Status: $_status");
      Navigator.pop(context, 'Room added successfully');
    }
  }

  // Function แก้ไขห้อง
  void editRoom() {
    if (_formKey.currentState!.validate()) {
      // ทำการอัปเดตข้อมูลในฐานข้อมูล
      print("Room edited: ${_roomNameController.text}, Status: $_status");
      Navigator.pop(context, 'Room edited successfully');
    }
  }

  // Function ปิดการใช้งานห้องที่มีสถานะว่างเท่านั้น
  void disableRoom() {
    if (_status == 'free') {
      setState(() {
        _status = 'disabled';
      });
      print("Room disabled: ${_roomNameController.text}");
      Navigator.pop(context, 'Room disabled successfully');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Only rooms with free status can be disabled.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.room == null ? 'Add Room' : 'Edit Room'),
        actions: [
          if (widget.room != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: disableRoom,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _roomNameController,
                decoration: const InputDecoration(labelText: 'Room Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a room name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _status,
                items: ['free', 'pending', 'reserved', 'disabled']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Room Status'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: widget.room == null ? addRoom : editRoom,
                child: Text(widget.room == null ? 'Add Room' : 'Edit Room'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
