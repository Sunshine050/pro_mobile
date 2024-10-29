import 'package:flutter/material.dart';
import 'package:pro_mobile/components/time_slot_radio.dart';
import 'package:pro_mobile/views/student/booking_status_page.dart';
import 'package:pro_mobile/views/student/student_history_page.dart';
import '../components/message_dialog.dart';

class Booking extends StatefulWidget {
  final String roomId;

  const Booking({super.key, required this.roomId});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String? _selectedSlot;
  final TextEditingController _reasonController = TextEditingController();
  late Map<String, dynamic> roomData;

  // Mock up rooms data
  Map<int, Map<String, dynamic>> roomsSample = {
    1: {
      "role": 'student',
      "roomId": '1',
      "roomName": 'Room 1',
      "desc": 'A spacious room perfect for group study.',
      "img": 'room_1.jpg',
      "slot_1": "free",
      "slot_2": "free",
      "slot_3": "free",
      "slot_4": "free",
    },
    2: {
      "role": 'student',
      "roomId": '2',
      "roomName": 'Room 2',
      "desc": 'A quiet room for focused studying.',
      "img": 'room_2.jpg',
      "slot_1": "reserved",
      "slot_2": "reserved",
      "slot_3": "reserved",
      "slot_4": "reserved",
    },
    3: {
      "role": 'student',
      "roomId": '3',
      "roomName": 'Room 3',
      "desc": 'A comfortable room for meetings.',
      "img": 'room_3.jpg',
      "slot_1": "disable",
      "slot_2": "disable",
      "slot_3": "disable",
      "slot_4": "disable",
    },
    4: {
      "role": 'student',
      "roomId": '4',
      "roomName": 'Room 4',
      "desc": 'A bright room with natural light.',
      "img": 'room_4.jpg',
      "slot_1": "free",
      "slot_2": "pending",
      "slot_3": "reserved",
      "slot_4": "disable",
    },
    5: {
      "role": 'student',
      "roomId": '5',
      "roomName": 'Room 5',
      "desc": 'A versatile room for all types of activities.',
      "img": 'room_5.jpg',
      "slot_1": "free",
      "slot_2": "free",
      "slot_3": "free",
      "slot_4": "free",
    },
  };

  int _currentIndex =
      0; // Track the current index for the bottom navigation bar

  @override
  void initState() {
    super.initState();
    getRoom();
  }

  void getRoom() {
    if (roomsSample.containsKey(int.parse(widget.roomId))) {
      roomData = roomsSample[int.parse(widget.roomId)]!;
    } else {
      // Handle invalid room ID, show a message or set default roomData
      roomData = {
        "roomName": "Room Not Found",
        "desc": "The requested room does not exist.",
        "img": 'default_room.jpg', // Use a default image
      };
    }
  }

  // Check if a slot is available
  bool isAvailable(String slotValue) {
    return slotValue == "free";
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // กลับไปยังหน้าก่อนหน้า
          },
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: ListView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      "assets/rooms/${roomData['img']}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    roomData["roomName"],
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    roomData["desc"],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  // Slot radio
                  Wrap(
                    spacing: 4.0,
                    children: <Widget>[
                      for (int i = 1; i <= 4; i++)
                        RadioListTile(
                          title: TimeSlotRadio(
                            time: getTimeSlot(i),
                            status: roomData["slot_$i"],
                          ),
                          value: "slot_$i",
                          groupValue: _selectedSlot,
                          onChanged: isAvailable(roomData["slot_$i"])
                              ? (value) => setState(() {
                                    _selectedSlot = value as String?;
                                  })
                              : null,
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _reasonController,
                    maxLines: null,
                    minLines: 1,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _reasonController.clear();
                        },
                      ),
                      labelText: 'Reason',
                      hintText: 'Please enter your reason',
                      helperText: 'required',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(16, 80, 176, 1.0)),
                    onPressed: (_reasonController.text.isEmpty ||
                            _selectedSlot == null)
                        ? null // Disable the button if fields are empty or no slot selected
                        : () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return MessageDialog(
                                  content:
                                      'Your Reservation for ${roomData["roomName"]}\nhas been confirmed',
                                  onConfirm: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => BookingStatus(),
                                      ),
                                    );
                                  },
                                  onCancel: null,
                                  messageType: 'ok',
                                );
                              },
                            );
                          },
                    child: const Text(
                      "Reserve this room",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Status Page
          Center(child: Text('Status Page')),
          // History Page
          const History(),
          // Profile Page
          Center(child: Text('Profile Page')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1050B0),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline_outlined),
            label: 'Status',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  String getTimeSlot(int slotIndex) {
    switch (slotIndex) {
      case 1:
        return "08:00 - 10:00";
      case 2:
        return "10:00 - 12:00";
      case 3:
        return "13:00 - 15:00";
      case 4:
        return "15:00 - 17:00";
      default:
        return "";
    }
  }
}
