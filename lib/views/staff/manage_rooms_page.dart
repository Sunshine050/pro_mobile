import 'package:flutter/material.dart';
import 'package:pro_mobile/components/message_dialog.dart';
import 'package:pro_mobile/components/tabsBar.dart';
import 'package:pro_mobile/views/browse.dart';
import 'package:pro_mobile/views/staff/staff_history_page.dart';
import 'package:pro_mobile/views/staff/manage_rooms_page.dart';
import 'package:pro_mobile/components/room_card.dart';
import 'package:image_picker/image_picker.dart';

class ManageRooms extends StatefulWidget {
  final bool isAdd;
  final String roomId;
  const ManageRooms({super.key, required this.roomId, required this.isAdd});

  @override
  State<ManageRooms> createState() => _ManageRoomsPageState();
}

class _ManageRoomsPageState extends State<ManageRooms> {
  late bool slot1Available, slot2Available, slot3Available, slot4Available;
  String roomImg = "blank.png";

  final TextEditingController _roomNameController = TextEditingController();

  Map<int, Map<String, dynamic>> roomsSample = {
    1: {
      "role": 'student',
      "roomId": '1',
      "roomName": 'room_name',
      "desc":
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus non purus a erat tempor pretium varius quis dolor. Lorem ipsum. ',
      "img": 'room_1.jpg',
      "slot_1": "free",
      "slot_2": "free",
      "slot_3": "free",
      "slot_4": "free",
    },
    2: {
      "role": 'student',
      "roomId": '2',
      "roomName": 'room_name',
      "desc":
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus non purus a erat tempor pretium varius quis dolor. Lorem ipsum. ',
      "img": 'room_1.jpg',
      "slot_1": "reserved",
      "slot_2": "reserved",
      "slot_3": "reserved",
      "slot_4": "reserved",
    },
    3: {
      "role": 'student',
      "roomId": '3',
      "roomName": 'room_name',
      "desc":
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus non purus a erat tempor pretium varius quis dolor. Lorem ipsum. ',
      "img": 'room_1.jpg',
      "slot_1": "disable",
      "slot_2": "disable",
      "slot_3": "disable",
      "slot_4": "disable",
    },
    4: {
      "role": 'student',
      "roomId": '4',
      "roomName": 'room_name',
      "desc":
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus non purus a erat tempor pretium varius quis dolor. Lorem ipsum. ',
      "img": 'room_1.jpg',
      "slot_1": "free",
      "slot_2": "pending",
      "slot_3": "reserved",
      "slot_4": "disable",
    },
    5: {
      "role": 'student',
      "roomId": '5',
      "roomName": 'room_name',
      "desc":
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus non purus a erat tempor pretium varius quis dolor. Lorem ipsum. ',
      "img": 'room_1.jpg',
      "slot_1": "free",
      "slot_2": "free",
      "slot_3": "free",
      "slot_4": "free",
    },
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (!widget.isAdd) {
      _roomNameController.text =
          roomsSample[int.parse(widget.roomId)]?["roomName"];
      slot1Available =
          (roomsSample[int.parse(widget.roomId)]?["slot_1"] == "free")
              ? true
              : false;
      slot2Available =
          (roomsSample[int.parse(widget.roomId)]?["slot_2"] == "free")
              ? true
              : false;
      slot3Available =
          (roomsSample[int.parse(widget.roomId)]?["slot_3"] == "free")
              ? true
              : false;
      slot4Available =
          (roomsSample[int.parse(widget.roomId)]?["slot_4"] == "free")
              ? true
              : false;
      roomImg = roomsSample[int.parse(widget.roomId)]?["img"];
    } else {
      slot1Available = true;
      slot2Available = true;
      slot3Available = true;
      slot4Available = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // เพิ่มการย้อนกลับเมื่อกดปุ่ม
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TextField for room name
            Expanded(
              child: TextField(
                controller: _roomNameController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter room name',
                ),
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            // Edit icon button
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                // Function to show dialog for editing room name
                _showEditRoomNameDialog(context);
              },
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Room Image with Edit Icon
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/rooms/${roomImg}', // เส้นทางไปยังรูปภาพ
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 250,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 24,
                right: 24,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      // ฟังก์ชันเลือกภาพ
                    },
                  ),
                ),
              ),
            ],
          ),
          // const SizedBox(height: 20),

          // Time Slots with Disable/Open Toggle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Expanded(
              child: Column(
                children: [
                  timeSlotWidget("08:00 - 10:00", slot1Available, Colors.blue),
                  timeSlotWidget("10:00 - 12:00", slot2Available, Colors.blue),
                  timeSlotWidget("13:00 - 15:00", slot3Available, Colors.blue),
                  timeSlotWidget("15:00 - 17:00", slot4Available, Colors.blue),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Room Description Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Room Description",
                hintText: "[room_desc]",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              maxLines: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Description is required';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 24),

          // Confirm Button
          ElevatedButton(
            onPressed: () {
              // ฟังก์ชันยืนยัน
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MessageDialog(
                    content: 'Confirmed',
                    onConfirm: () {
                      // change to status page
                      Navigator.pushReplacement<void, void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => Browse(
                            role: "staff",
                          ),
                        ),
                      );
                    },
                    // no cancel button
                    onCancel: null,
                    messageType: 'ok',
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(16, 80, 176, 1.0),
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 20), // ปรับขนาดให้เล็กลง
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadowColor: Colors.blueAccent.withOpacity(0.5),
              elevation: 20,
            ),
            child: const Text("Confirm",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
          Spacer(),
          TabsbarNavigator(role: "staff")
        ],
      ),
    );
  }

  // Function to show a dialog for editing room name
  void _showEditRoomNameDialog(BuildContext context) {
    TextEditingController _editController =
        TextEditingController(text: _roomNameController.text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Room Name"),
          content: TextField(
            controller: _editController,
            decoration: const InputDecoration(hintText: "Enter new room name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _roomNameController.text =
                      _editController.text; // Update room name
                });
                Navigator.pop(context);
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  // Widget for each time slot with a cleaner appearance
  Widget timeSlotWidget(String time, bool available, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Time slot button with solid background and shadow
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: available ? color : Colors.grey[400],
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  offset: const Offset(2, 4),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Text(
              time,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              const Text("Disable", style: TextStyle(fontSize: 12)),
              Switch(
                value: available,
                onChanged: (value) {
                  setState(() {
                    if (time == "08:00 - 10:00") slot1Available = value;
                    if (time == "10:00 - 12:00") slot2Available = value;
                    if (time == "13:00 - 15:00") slot3Available = value;
                    if (time == "15:00 - 17:00") slot4Available = value;
                  });
                },
              ),
              const Text("Open", style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
