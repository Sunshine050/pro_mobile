import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pro_mobile/components/message_dialog.dart';
import 'package:pro_mobile/components/room_card_sm.dart';
import 'package:pro_mobile/services/rooms_service.dart';
import 'package:pro_mobile/views/homepage.dart';

class Profile extends StatefulWidget {
  final String role;
  final int userId;
  const Profile({super.key, required this.userId, required this.role});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Map<int, Map<String, dynamic>> userData;
  List<dynamic> rooms = [];

  @override
  void initState() {
    super.initState();

    // api get user data

    // mock up
    userData = {
      1: {
        "userId": "1",
        "role": "student",
        "username": "username",
        "email": "user_email@lamduan.mfu.ac.th"
      }
    };
  }

  Future<dynamic> _getRoom() async {
    try {
      final response = await RoomsService().getRooms().timeout(
            const Duration(seconds: 10),
          );
      if (response.statusCode == 200) {
        rooms = jsonDecode(response.body);
        // for (var i in rooms) {
        //   debugPrint(i['room_name']);
        // }
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: const Icon(Icons.arrow_back)),
        title: Text(userData[1]?["username"]),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton.outlined(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return MessageDialog(
                        content: 'Are you sure?',
                        onConfirm: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => Homepage(),
                              ),
                              (Route<dynamic> route) => false);
                        },
                        onCancel: () {
                          // close dialog
                          Navigator.of(context).pop();
                        },
                        messageType: 'danger',
                      );
                    },
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.red,
                    width: 1.5,
                  ),
                ),
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.red,
                )),
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 24,
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(150)),
            ),
            child: Image.asset(
              "assets/rooms/room_1.jpg", // mock up
              fit: BoxFit.cover,
              width: 150,
              height: 150,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Center(
            child: Text(
              userData[1]?["email"],
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const Spacer(),
          Builder(builder: (context) {
            return (widget.role == "student")
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.bookmark_added_rounded,
                              color: Color.fromARGB(255, 255, 193, 7),
                              size: 36,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Your bookmarked rooms",
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SizedBox(
                          height: 300,
                          child: FutureBuilder(
                              future: _getRoom(),
                              builder: (context, snapshot) {
                                if (rooms.isEmpty) {
                                  return const SizedBox.shrink();
                                }
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(bottom: 24),
                                  itemCount: rooms.length,
                                  itemBuilder: (context, index) {
                                    final itemData = rooms[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: RoomCardSm(
                                        roomId: itemData?['id'],
                                        roomName: itemData?['room_name'],
                                        img: itemData?['image'],
                                        slot_1: itemData?['slot_1'],
                                        slot_2: itemData?['slot_2'],
                                        slot_3: itemData?['slot_3'],
                                        slot_4: itemData?['slot_4'],
                                      ),
                                    );
                                  },
                                );
                              }),
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink();
          }),
          const Spacer()
        ],
      )),
    );
  }
}
