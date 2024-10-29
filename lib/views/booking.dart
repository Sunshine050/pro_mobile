// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:pro_mobile/components/time_slot_radio.dart';
import 'package:pro_mobile/views/student/booking_status_page.dart';
import 'package:pro_mobile/views/home.dart';
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

  // mock up rooms data
  Map<int, Map<String, dynamic>> roomsSample = {
    1: {
      "role": 'student',
      "roomId": '1',
      "roomName": 'Room Name 1',
      "desc": 'Description for room 1.',
      "img": 'room_1.jpg',
      "slot_1": "free",
      "slot_2": "free",
      "slot_3": "free",
      "slot_4": "free",
    },
    // Add other room data...
  };

  @override
  void initState() {
    super.initState();
    getRoom();
  }

  void getRoom() {
    roomData = roomsSample[int.parse(widget.roomId)]!;
  }

  // Check if a slot is available
  bool isAvailable(String slotValue) {
    return slotValue == "free";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 45, 116, 221)),
        useMaterial3: true,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text("Room Reservation"),
          centerTitle: true,
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
                      backgroundColor: const Color.fromRGBO(16, 80, 176, 1.0)),
                  onPressed: _reasonController.text.isEmpty
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
