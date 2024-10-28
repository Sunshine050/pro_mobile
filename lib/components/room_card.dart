import 'package:flutter/material.dart';
import 'package:pro_mobile/components/time_slot.dart';
import 'package:pro_mobile/views/student/booking_form_page.dart';

class RoomCard extends StatefulWidget {
  final String role,
      roomId,
      roomName,
      desc,
      img,
      slot_1,
      slot_2,
      slot_3,
      slot_4;

  const RoomCard(
      {super.key,
      required this.role,
      required this.roomId,
      required this.roomName,
      required this.desc,
      required this.img,
      required this.slot_1,
      required this.slot_2,
      required this.slot_3,
      required this.slot_4});

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  List<dynamic> bookmarkedState = [
    false,
    Colors.black,
    const Icon(Icons.bookmark_add_outlined)
  ];

  void bookmark() {
    // api

    setState(() {
      if (bookmarkedState[0] == false) {
        bookmarkedState[0] = true;
        bookmarkedState[1] = const Color.fromARGB(255, 255, 193, 7);
        bookmarkedState[2] = const Icon(Icons.bookmark_added_rounded);
      } else {
        bookmarkedState[0] = false;
        bookmarkedState[1] = Colors.black;
        bookmarkedState[2] = const Icon(Icons.bookmark_add_outlined);
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
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(16)),
                    ),
                    child: Image.asset(
                      widget.img,
                      fit: BoxFit.cover,
                      height: 165,
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TimeSlot(time: "08:00 - 10:00", status: widget.slot_1),
                        const SizedBox(
                          height: 4,
                        ),
                        TimeSlot(time: "10:00 - 12:00", status: widget.slot_2),
                        const SizedBox(
                          height: 4,
                        ),
                        TimeSlot(time: "13:00 - 15:00", status: widget.slot_3),
                        const SizedBox(
                          height: 4,
                        ),
                        TimeSlot(time: "15:00 - 17:00", status: widget.slot_4),
                      ],
                    ),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.roomName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    // student => bookmark btn : else none
                    Builder(builder: (context) {
                      if (widget.role == "student") {
                        return IconButton(
                          icon: bookmarkedState[2],
                          onPressed: () {
                            bookmark();
                          },
                          color: bookmarkedState[1],
                          iconSize: 24.0,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.desc,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // check role => build btn
                    Builder(builder: (context) {
                      switch (widget.role) {
                        case "student":
                          return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(16, 80, 176, 1.0)),
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
                                              builder: (context) => Booking(
                                                  roomId: widget.roomId)),
                                        )
                                      }
                                  : null,
                              child: const Text("Reserve this room",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )));
                        case "staff":
                          return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(16, 80, 176, 1.0)),
                              onPressed: () => {
                                    // to edit page
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           Booking(roomId: widget.roomId)),
                                    // )
                                  },
                              child: const Text("Edit",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )));
                        default:
                          return const SizedBox.shrink();
                      }
                    }),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
