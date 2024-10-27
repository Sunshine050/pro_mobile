import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:pro_mobile/services/staff_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageRoomsPage extends StatefulWidget {
  @override
  _ManageRoomsPageState createState() => _ManageRoomsPageState();
}

class _ManageRoomsPageState extends State<ManageRoomsPage> {
  List<dynamic> rooms = []; // ตัวแปรสำหรับเก็บข้อมูลห้อง
  File? _imageFile; // ตัวแปรสำหรับเก็บรูปภาพ
  bool isOpen1 = true;
  bool isOpen2 = true;
  bool isOpen3 = true;
  bool isOpen4 = false;

  @override
  void initState() {
    super.initState();
    _fetchRooms(); // เรียกฟังก์ชันเพื่อดึงข้อมูลห้องเมื่อหน้าโหลด
  }

  Future<void> _fetchRooms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // รับ token จาก SharedPreferences

    if (token != null) {
      StaffService staffService = StaffService();
      var response = await staffService.getAllRooms(token);

      setState(() {
        rooms = response; // เก็บข้อมูลห้องในตัวแปร rooms
      });
    }
  }

  void _editRoomName() {
    // ... รหัสเดิม สำหรับแก้ไขชื่อห้อง
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Rooms'),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: _editRoomName,
            ),
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Room Image Section
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Center(
                    child: _imageFile == null
                        ? Text('ไม่มีรูปภาพ',
                            style: TextStyle(color: Colors.grey))
                        : Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.edit, color: Colors.blue, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Room List
            if (rooms.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  var room = rooms[index];
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            room['name'] ?? 'Unnamed Room',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Description: ${room['description'] ?? 'No Description'}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Time Slot: ${room['time_slot'] ?? 'N/A'}',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            else
              Center(child: CircularProgressIndicator()), // Loading indicator

            SizedBox(height: 24),

            // Time Slots
            ..._buildTimeSlot(
                '08:00 - 10:00', isOpen1, Icons.calendar_today, Colors.blue),
            ..._buildTimeSlot(
                '10:00 - 12:00', isOpen2, Icons.person, Colors.red),
            ..._buildTimeSlot(
                '13:00 - 15:00', isOpen3, Icons.build, Colors.amber),
            ..._buildTimeSlot(
                '15:00 - 17:00', isOpen4, Icons.close, Colors.grey),

            SizedBox(height: 24),

            // Room Description
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Room Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '[room_desc]',
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.close_rounded),
                    ),
                  ),
                  Text(
                    'Required',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // เพิ่มการทำงานสำหรับปุ่ม Confirm ที่นี่
                },
                child: Text('Confirm'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTimeSlot(
      String time, bool isOpen, IconData icon, Color color) {
    return [
      Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            SizedBox(width: 12),
            Text(
              time,
              style: TextStyle(color: color),
            ),
            Spacer(),
            Text(
              'Disable',
              style: TextStyle(color: Colors.grey),
            ),
            Switch(
              value: isOpen,
              onChanged: (value) {
                setState(() {
                  if (time == '08:00 - 10:00') isOpen1 = value;
                  if (time == '10:00 - 12:00') isOpen2 = value;
                  if (time == '13:00 - 15:00') isOpen3 = value;
                  if (time == '15:00 - 17:00') isOpen4 = value;
                });
              },
              activeColor: Colors.blue,
            ),
            Text(
              'Open',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    ];
  }
}
