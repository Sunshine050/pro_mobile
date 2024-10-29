import 'package:flutter/material.dart';
import 'package:pro_mobile/components/time_slot_radio.dart';
import 'package:pro_mobile/views/student/booking_status_page.dart';
import 'package:pro_mobile/views/student/student_history_page.dart';
import '../components/message_dialog.dart';
import 'package:pro_mobile/widgets/browse.dart';
import 'package:pro_mobile/widgets/NavigationBar_student.dart';

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
  static const String SLOT_FREE = "free";
  static const String SLOT_RESERVED = "reserved";
  static const String SLOT_PENDING = "pending";
  static const String SLOT_DISABLED = "disable";

  Map<int, Map<String, dynamic>> roomsSample = {
    1: {
      "role": 'student',
      "roomId": '1',
      "roomName": 'Room 1',
      "desc": 'A spacious room perfect for group study.',
      "img": 'room_1.jpg',
      "slot_1": SLOT_FREE,
      "slot_2": SLOT_FREE,
      "slot_3": SLOT_FREE,
      "slot_4": SLOT_FREE,
    },
    2: {
      "role": 'student',
      "roomId": '2',
      "roomName": 'Room 2',
      "desc": 'A quiet room for focused studying.',
      "img": 'room_2.jpg',
      "slot_1": SLOT_RESERVED,
      "slot_2": SLOT_RESERVED,
      "slot_3": SLOT_RESERVED,
      "slot_4": SLOT_RESERVED,
    },
    3: {
      "role": 'student',
      "roomId": '3',
      "roomName": 'Room 3',
      "desc": 'A comfortable room for meetings.',
      "img": 'room_3.jpg',
      "slot_1": SLOT_DISABLED,
      "slot_2": SLOT_DISABLED,
      "slot_3": SLOT_DISABLED,
      "slot_4": SLOT_DISABLED,
    },
    4: {
      "role": 'student',
      "roomId": '4',
      "roomName": 'Room 4',
      "desc": 'A bright room with natural light.',
      "img": 'room_4.jpg',
      "slot_1": SLOT_FREE,
      "slot_2": SLOT_PENDING,
      "slot_3": SLOT_RESERVED,
      "slot_4": SLOT_DISABLED,
    },
    5: {
      "role": 'student',
      "roomId": '5',
      "roomName": 'Room 5',
      "desc": 'A versatile room for all types of activities.',
      "img": 'room_5.jpg',
      "slot_1": SLOT_FREE,
      "slot_2": SLOT_FREE,
      "slot_3": SLOT_FREE,
      "slot_4": SLOT_FREE,
    },
  };

  @override
  void initState() {
    super.initState();
    getRoom();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void getRoom() {
    if (roomsSample.containsKey(int.parse(widget.roomId))) {
      roomData = roomsSample[int.parse(widget.roomId)]!;
    } else {
      roomData = {
        "roomName": "Room Not Found",
        "desc": "The requested room does not exist.",
        "img": 'default_room.jpg',
      };
    }
  }

  bool isAvailable(String slotValue) {
    return slotValue == SLOT_FREE;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ListView(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  "assets/rooms/${roomData['img']}",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.image_not_supported),
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
                  backgroundColor: const Color.fromRGBO(16, 80, 176, 1.0),
                ),
                onPressed:
                    (_reasonController.text.isEmpty || _selectedSlot == null)
                        ? null
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
