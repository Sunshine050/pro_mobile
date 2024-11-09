import 'package:flutter/material.dart';

import '../components/filters.dart';
import '../components/room_card.dart';
import '../components/search_btn.dart';

class Browse extends StatefulWidget {
  const Browse({super.key, required String role});

  get role => null;

  @override
  State<Browse> createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  Map<int, Map<String, dynamic>> roomsSample = {
    1: {
      "role": 'student',
      "roomId": '1',
      "roomName": 'room_name',
      "desc":
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus non purus a erat tempor pretium varius quis dolor. Lorem ipsum. ',
      "img": 'assets/rooms/room_1.jpg',
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
      "img": 'assets/rooms/room_1.jpg',
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
      "img": 'assets/rooms/room_1.jpg',
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
      "img": 'assets/rooms/room_1.jpg',
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
      "img": 'assets/rooms/room_1.jpg',
      "slot_1": "free",
      "slot_2": "free",
      "slot_3": "free",
      "slot_4": "free",
    },
  };

  @override
  void initState() {
    super.initState();

    // api get rooms
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 45, 116, 221)),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Room List"),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: SearchButton())
            ],
          ),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Column(
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        child: Filters(),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: roomsSample.length,
                    itemBuilder: (context, index) {
                      final itemKey = roomsSample.keys.elementAt(index);
                      final itemData = roomsSample[itemKey];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: RoomCard(
                          role: widget.role,
                          roomId: itemData?['roomId'],
                          roomName: itemData?['roomName'],
                          desc: itemData?['desc'],
                          img: itemData?['img'],
                          slot_1: itemData?['slot_1'],
                          slot_2: itemData?['slot_2'],
                          slot_3: itemData?['slot_3'],
                          slot_4: itemData?['slot_4'],
                        ),
                      );
                    },
                  ),
                ),
                // RadioButtonExample()
              ],
            ),
          )),
        ));
  }
}
