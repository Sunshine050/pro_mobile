import 'package:flutter/material.dart';

import '../views/booking.dart';

class RoomCardSm extends StatefulWidget {
  final String roomId, roomName, img, slot_1, slot_2, slot_3, slot_4;

  const RoomCardSm(
      {super.key,
      required this.roomId,
      required this.roomName,
      required this.img,
      required this.slot_1,
      required this.slot_2,
      required this.slot_3,
      required this.slot_4});

  @override
  State<RoomCardSm> createState() => _RoomCardSmState();
}

class _RoomCardSmState extends State<RoomCardSm> {
  List<dynamic> bookmarkedState = [
    true,
    Color.fromARGB(255, 255, 193, 7),
    Icons.bookmark_added_rounded
  ];

  void bookmark() {
    // api

    setState(() {
      if (bookmarkedState[0] == false) {
        bookmarkedState[0] = true;
        bookmarkedState[1] = const Color.fromARGB(255, 255, 193, 7);
        bookmarkedState[2] = Icons.bookmark_added_rounded;
      } else {
        bookmarkedState[0] = false;
        bookmarkedState[1] = Colors.black;
        bookmarkedState[2] = Icons.bookmark_add_outlined;
      }
    });
  }

  // if all slot are "reserved" or "disable" => disable btn
  bool isAvailable(List<String> slotStatus) {
    return slotStatus.any((status) => status == 'free' || status == "pending");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Image.asset(
              widget.img,
              fit: BoxFit.fitHeight,
              width: 180,
            ),
          ),
          SizedBox(
            width: 180,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.roomName,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  GestureDetector(
                    onTap: () {
                      bookmark();
                    },
                    child: Icon(
                      bookmarkedState[2],
                      color: bookmarkedState[1],
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Builder(builder: (context) {
              String textBtn = "Unavailable";
              Color btnColor = Colors.black;
              if (isAvailable([
                widget.slot_1,
                widget.slot_2,
                widget.slot_3,
                widget.slot_4
              ])) {
                textBtn = "Reserve this room";
                btnColor = Colors.white;
              }
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(16, 80, 176, 1.0)),
                  onPressed: isAvailable([
                    widget.slot_1,
                    widget.slot_2,
                    widget.slot_3,
                    widget.slot_4
                  ])
                      ? () => {
                            // to booking page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Booking(roomId: widget.roomId)),
                            )
                          }
                      : null,
                  child: Text(textBtn,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: btnColor)));
            }),
          )
        ],
      ),
    );
  }
}
