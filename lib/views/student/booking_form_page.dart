import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pro_mobile/components/message_dialog.dart';
import 'package:pro_mobile/components/time_slot_radio.dart';
import 'package:http/http.dart' as http;

class Booking extends StatefulWidget {
  final int roomId;
  final String token; // เพิ่ม token ที่ได้รับจากการล็อกอิน
  const Booking({super.key, required this.roomId, required this.token});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String? _selectedSlot;
  final TextEditingController _reasonController = TextEditingController();
  late Map<String, dynamic> roomData;

  // mock uo rooms data
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
    super.initState();
    getRoom();
  }

  void getRoom() {
    // api get room

    // mock up data
    roomData = roomsSample[widget.roomId]!;
  }

  void submit() {
    if (_selectedSlot == null || _reasonController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MessageDialog(
            content: 'Please select a time slot and provide a reason.',
            onConfirm: () {
              Navigator.of(context).pop();
            },
            messageType: 'error',
          );
        },
      );
      return;
    }

    // แสดงค่าในคอนโซลเพื่อให้แน่ใจว่าค่าถูกต้อง
    print('Room ID: ${widget.roomId}');
    print('Slot: $_selectedSlot');
    print('Reason: ${_reasonController.text}');

    // ส่งข้อมูลการจองไปยัง API
    http
        .post(
      Uri.parse('http://192.168.206.1:3000/student/book'),
      headers: {
        'Authorization': 'Bearer ${widget.token}',
        'Content-Type':
            'application/json', // เพิ่ม Content-Type ให้เป็น application/json
      },
      body: jsonEncode({
        'room_id': widget.roomId,
        'slot': _selectedSlot,
        'reason': _reasonController.text,
      }),
    )
        .then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      // ตรวจสอบว่า status code เป็น 200 หรือ 201
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        print(
            "Booking created with ID: ${responseBody['bookingId']}"); // แสดง ID ของการจองที่ถูกสร้าง

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return MessageDialog(
              content: 'Room reserved successfully!',
              onConfirm: () {
                // ไปที่หน้า Home ทันทีเมื่อสำเร็จ
                Navigator.pop(context); // ปิด dialog
                Navigator.pop(context); // กลับไปยังหน้า Home
              },
              messageType: 'success',
            );
          },
        );
      } else {
        // แจ้งเตือนเมื่อการจองไม่สำเร็จ
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return MessageDialog(
              content:
                  'Failed to reserve the room. Response status: ${response.statusCode}, Body: ${response.body}',
              onConfirm: () {
                Navigator.of(context).pop();
              },
              messageType: 'error',
            );
          },
        );
      }
    }).catchError((error) {
      print("Error: $error");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MessageDialog(
            content: 'An error occurred. Please try again later.',
            onConfirm: () {
              Navigator.of(context).pop();
            },
            messageType: 'error',
          );
        },
      );
    });
  }

  // disable radio slot
  bool isAvailable(String slotValue) {
    return slotValue == "free";
  }

  // slot value
  void slotRadio(dynamic value) {
    setState(() {
      _selectedSlot = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Room Reservation"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  child: Image.asset(
                    "assets/rooms/${roomData['img']}", // mock up
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            roomData["roomName"],
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              roomData["desc"],
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // slot radio
                      Wrap(
                        spacing: 4.0,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: isAvailable(roomData["slot_1"])
                                    ? () {
                                        setState(() {
                                          _selectedSlot = "slot_1";
                                        });
                                      }
                                    : null,
                                child: Row(
                                  children: [
                                    Radio(
                                      value: "slot_1",
                                      groupValue: _selectedSlot,
                                      onChanged: isAvailable(roomData["slot_1"])
                                          ? (value) => setState(() {
                                                _selectedSlot =
                                                    value as String?;
                                              })
                                          : null,
                                    ),
                                    TimeSlotRadio(
                                      time: "08:00 - 10:00",
                                      status: roomData["slot_1"],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                onTap: isAvailable(roomData["slot_2"])
                                    ? () {
                                        setState(() {
                                          _selectedSlot = "slot_2";
                                        });
                                      }
                                    : null,
                                child: Row(
                                  children: [
                                    Radio(
                                      value: "slot_2",
                                      groupValue: _selectedSlot,
                                      onChanged: isAvailable(roomData["slot_2"])
                                          ? (value) => setState(() {
                                                _selectedSlot =
                                                    value as String?;
                                              })
                                          : null,
                                    ),
                                    TimeSlotRadio(
                                      time: "10:00 - 12:00",
                                      status: roomData["slot_2"],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: isAvailable(roomData["slot_3"])
                                    ? () {
                                        setState(() {
                                          _selectedSlot = "slot_3";
                                        });
                                      }
                                    : null,
                                child: Row(
                                  children: [
                                    Radio(
                                      value: "slot_3",
                                      groupValue: _selectedSlot,
                                      onChanged: isAvailable(roomData["slot_3"])
                                          ? (value) => setState(() {
                                                _selectedSlot =
                                                    value as String?;
                                              })
                                          : null,
                                    ),
                                    TimeSlotRadio(
                                      time: "13:00 - 15:00",
                                      status: roomData["slot_3"],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                onTap: isAvailable(roomData["slot_4"])
                                    ? () {
                                        setState(() {
                                          _selectedSlot = "slot_4";
                                        });
                                      }
                                    : null,
                                child: Row(
                                  children: [
                                    Radio(
                                      value: "slot_4",
                                      groupValue: _selectedSlot,
                                      onChanged: isAvailable(roomData["slot_4"])
                                          ? (value) => setState(() {
                                                _selectedSlot =
                                                    value as String?;
                                              })
                                          : null,
                                    ),
                                    TimeSlotRadio(
                                      time: "15:00 - 17:00",
                                      status: roomData["slot_4"],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      // reason input
                      TextFormField(
                        controller: _reasonController,
                        decoration: const InputDecoration(
                          hintText: 'Reason for booking',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        onPressed: submit,
                        child: const Text("Submit"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
