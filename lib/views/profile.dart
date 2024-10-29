import 'package:flutter/material.dart';
import 'package:pro_mobile/components/message_dialog.dart';
import 'package:pro_mobile/components/room_card_sm.dart';
import 'package:pro_mobile/components/tabsBar.dart';
import 'package:pro_mobile/views/home.dart';

class Profile extends StatefulWidget {
  final String userId, role;
  const Profile({super.key, required this.userId, required this.role});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Map<int, Map<String, dynamic>> userData;
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

    // api get user data

    // mock up
    userData = {
      1: {
        "userId": "1",
        "role": "student",
        "username": "username",
        "email": "user_email@gmail.com"
      }
    };
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
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
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
            Text(
              userData[1]?["email"],
              style: Theme.of(context).textTheme.bodyLarge,
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
                            child: ListView.builder(
                              scrollDirection:
                                  Axis.horizontal, // Horizontal scrolling
                              itemCount: roomsSample.length,
                              itemBuilder: (context, index) {
                                final itemKey =
                                    roomsSample.keys.elementAt(index);
                                final itemData = roomsSample[itemKey];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: RoomCardSm(
                                    roomId: itemData?['roomId'],
                                    roomName: itemData?['roomName'],
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
                        ),
                      ],
                    )
                  : SizedBox.shrink();
            }),
            const Spacer(),
            TabsbarNavigator(role: widget.role)
          ],
        )),
      ),
    );
  }
}
