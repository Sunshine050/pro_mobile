import 'package:flutter/material.dart';
import 'package:pro_mobile/views/staff/staff_history_page.dart';
import 'package:pro_mobile/views/staff/manage_rooms_page.dart';
import 'package:pro_mobile/components/room_card.dart';
import 'package:image_picker/image_picker.dart';

class ManageRooms extends StatefulWidget {
  const ManageRooms({super.key, required String roomId});

  @override
  State<ManageRooms> createState() => _ManageRoomsPageState();
}

class _ManageRoomsPageState extends State<ManageRooms> {
  bool slot1Available = true;
  bool slot2Available = false;
  bool slot3Available = true;
  bool slot4Available = false;

  // Controller for room name
  final TextEditingController _roomNameController =
      TextEditingController(text: "[room_name]");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
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
                  hintText: 'Room Name',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Room Image with Edit Icon
            Stack(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/rooms/room_1.jpg', // Path to image
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        // Function to choose image
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Time Slots with Disable/Open Toggle
            Expanded(
              child: ListView(
                children: [
                  timeSlotWidget("08:00 - 10:00", slot1Available, Colors.blue),
                  timeSlotWidget("10:00 - 12:00", slot2Available, Colors.red),
                  timeSlotWidget(
                      "13:00 - 15:00", slot3Available, Colors.yellow),
                  timeSlotWidget("15:00 - 17:00", slot4Available, Colors.grey),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Room Description Field
            TextFormField(
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
            const SizedBox(height: 20),

            // Confirm Button
            ElevatedButton(
              onPressed: () {
                // Function to confirm
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 20), // Adjust size
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.blueAccent.withOpacity(0.5),
                elevation: 20,
              ),
              child: const Text("Confirm",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
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
                Navigator.of(context).pop(); // Close the dialog
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
