import 'package:flutter/material.dart';
//component
import '/components/filters.dart';
import '/components/room_card.dart';
import '/components/search_btn.dart';

class Browse extends StatefulWidget {
  const Browse({super.key});

  @override
  State<Browse> createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  Map<int, Map<String, dynamic>> roomsSample = {
    1: {
      "role": 'student',
      "roomId": '1',
      "roomName": 'Room 1',
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
      "roomName": 'Room 2',
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
      "roomName": 'Room 3',
      "desc":
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus non purus a erat tempor pretium varius quis dolor. Lorem ipsum. ',
      "img": 'assets/rooms/room_1.jpg',
      "slot_1": "disable",
      "slot_2": "disable",
      "slot_3": "disable",
      "slot_4": "disable",
    },
    // เพิ่มห้องอื่นๆ ตามต้องการ
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 45, 116, 221),
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Room List"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SearchButton(),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
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
                          role: itemData?['role'] ?? 'student',
                          roomId: itemData?['roomId'] ?? '',
                          roomName: itemData?['roomName'] ?? 'Room Name',
                          desc: itemData?['desc'] ?? '',
                          img: itemData?['img'] ?? '',
                          slot_1: itemData?['slot_1'] ?? 'N/A',
                          slot_2: itemData?['slot_2'] ?? 'N/A',
                          slot_3: itemData?['slot_3'] ?? 'N/A',
                          slot_4: itemData?['slot_4'] ?? 'N/A',
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
