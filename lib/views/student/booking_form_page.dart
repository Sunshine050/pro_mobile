// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:pro_mobile/components/message_dialog.dart';
import 'package:pro_mobile/components/time_slot_radio.dart';

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
    roomData = roomsSample[int.parse(widget.roomId)]!;
  }

  void submit() {}

  // disable radio slot
  bool isAvailable(String slotValue) {
    if (slotValue == "free") {
      return true;
    } else {
      return false;
    }
  }

  // slot value
  void slotRadio(dynamic value) {
    setState(() {
      _selectedSlot = value;
    });
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
                  )),
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Column(
                      children: [
                        Row(children: [
                          Text(
                            roomData["roomName"],
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ]),
                        Row(children: [
                          Flexible(
                            child: Text(
                              roomData["desc"],
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 16,
                        ),
                        // slot radio
                        Wrap(spacing: 4.0, children: <Widget>[
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
                                        onChanged:
                                            isAvailable(roomData["slot_1"])
                                                ? (value) => setState(() {
                                                      _selectedSlot =
                                                          value as String?;
                                                    })
                                                : null),
                                    TimeSlotRadio(
                                        time: "08:00 - 10:00",
                                        status: roomData["slot_1"]),
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
                                        onChanged:
                                            isAvailable(roomData["slot_2"])
                                                ? (value) => setState(() {
                                                      _selectedSlot =
                                                          value as String?;
                                                    })
                                                : null),
                                    TimeSlotRadio(
                                        time: "10:00 - 12:00",
                                        status: roomData["slot_2"]),
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
                                        onChanged:
                                            isAvailable(roomData["slot_3"])
                                                ? (value) => setState(() {
                                                      _selectedSlot =
                                                          value as String?;
                                                    })
                                                : null),
                                    TimeSlotRadio(
                                        time: "13:00 - 15:00",
                                        status: roomData["slot_3"]),
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
                                        onChanged:
                                            isAvailable(roomData["slot_4"])
                                                ? (value) => setState(() {
                                                      _selectedSlot =
                                                          value as String?;
                                                    })
                                                : null),
                                    TimeSlotRadio(
                                        time: "15:00 - 17:00",
                                        status: roomData["slot_4"]),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]),
                        const SizedBox(
                          height: 24,
                        ),
                        Flexible(
                            child: TextFormField(
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
                        )),
                      ],
                    ),
                  )),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(16, 80, 176, 1.0)),
                    onPressed: _reasonController.text.isEmpty
                        ? null
                        : (() {
                            // api

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return MessageDialog(
                                  content:
                                      'Your Reservation for ${roomData["roomName"]}\nhas been confirmed',
                                  onConfirm: () {
                                    // change to status page
                                    // Navigator.pushReplacement<void, void>(
                                    //   context,
                                    //   MaterialPageRoute<void>(
                                    //     builder: (BuildContext context) =>
                                    //         const Status(),
                                    //   ),
                                    // );
                                    Navigator.of(context).pop();
                                  },
                                  // no cancel button
                                  onCancel: null,
                                  messageType: 'ok',
                                );
                              },
                            );
                          }),
                    child: const Text(
                      "Reserve this room",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
              )
            ],
          ),
        )),
      ),
    );
  }
}
