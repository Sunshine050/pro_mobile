import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pro_mobile/services/rooms_service.dart';
import 'package:pro_mobile/views/staff/manage_rooms_page.dart';
// import '../components/filters.dart';
import '../components/room_card.dart';
import '../components/search_btn.dart';
import '../models/filter_model.dart';

class Browse extends StatefulWidget {
  final String role;
  const Browse({super.key, required this.role});

  @override
  State<Browse> createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  final filtersModel = FiltersModel();
  Map<int, Map<String, dynamic>> filteredRooms = {};
  List<dynamic> rooms = [];

  List<String> filtersList = [
    "Any Available",
    "08:00 - 10:00",
    "10:00 - 12:00",
    "13:00 - 15:00",
    "15:00 - 17:00"
  ];

  @override
  void initState() {
    super.initState();

    // api get rooms
    _getRoom();

    // _filterRooms();
    // filtersModel.addListener(() {
    //   _filterRooms();
    // });
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

  // void _filterRooms() {
  //   filteredRooms.clear();
  //   for (var entry in rooms) {
  //     // check if any slot is free => available
  //     bool isAvailable = false;
  //     for (var slot in entry.value.values) {
  //       if (slot == "free") {
  //         isAvailable = true;
  //         break;
  //       }
  //     }
  //     // add to filtered list
  //     if (filtersModel.isSelected("Any Available") && isAvailable) {
  //       setState(() {
  //         filteredRooms[entry.key] = entry.value;
  //       });
  //     } else if (!filtersModel.isSelected("Any Available")) {
  //       if (filtersModel.isSelected("08:00 - 10:00")) {
  //         for (var slot in entry.value.keys) {
  //           if (slot == "slot_1" && entry.value["slot_1"] == "free") {
  //             setState(() {
  //               filteredRooms[entry.key] = entry.value;
  //             });
  //             break;
  //           }
  //         }
  //       } else if (filtersModel.isSelected("10:00 - 12:00")) {
  //         for (var slot in entry.value.keys) {
  //           if (slot == "slot_2" && entry.value["slot_2"] == "free") {
  //             setState(() {
  //               filteredRooms[entry.key] = entry.value;
  //             });
  //             break;
  //           }
  //         }
  //       } else if (filtersModel.isSelected("13:00 - 15:00")) {
  //         for (var slot in entry.value.keys) {
  //           if (slot == "slot_3" && entry.value["slot_3"] == "free") {
  //             setState(() {
  //               filteredRooms[entry.key] = entry.value;
  //             });
  //             break;
  //           }
  //         }
  //       } else if (filtersModel.isSelected("15:00 - 17:00")) {
  //         for (var slot in entry.value.keys) {
  //           if (slot == "slot_4" && entry.value["slot_4"] == "free") {
  //             setState(() {
  //               filteredRooms[entry.key] = entry.value;
  //             });
  //             break;
  //           }
  //         }
  //       } else {
  //         setState(() {
  //           filteredRooms[entry.key] = entry.value;
  //         });
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Room List"),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 16), child: SearchButton())
        ],
      ),
      body: SafeArea(
        child: Stack(children: [
          Column(
            children: [
              // filter row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child:
                              // Filters(),
                              Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Wrap(
                                spacing: 4.0,
                                children: filtersList.map((e) {
                                  return FilterChip(
                                    label: Text(
                                      e,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    labelPadding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    selected: filtersModel.isSelected(e),
                                    onSelected: (bool selected) => setState(() {
                                      filtersModel.updateFilter(e);
                                    }),
                                  );
                                }).toList(),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              // list room
              Expanded(
                child: FutureBuilder(
                    future: _getRoom(),
                    builder: (context, snapshot) {
                      if (rooms.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 24),
                        itemCount: rooms.length,
                        itemBuilder: (context, index) {
                          final itemData = rooms[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 24),
                            child: RoomCard(
                              role: 'student',
                              roomId: itemData?['id'],
                              roomName: itemData?['room_name'],
                              desc: itemData?['desc'],
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
            ],
          ),
          // add room btn
          // Builder(builder: (context) {
          //   return (widget.role == "staff")
          //       ? Positioned(
          //           right: 20.0,
          //           bottom: 20.0,
          //           child: FloatingActionButton(
          //             backgroundColor: Colors.white,
          //             onPressed: () {
          //               Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => const ManageRooms(
          //                             isAdd: true,
          //                             roomId: "1",
          //                           )));
          //             },
          //             child: const Icon(
          //               Icons.add,
          //               color: Color.fromRGBO(16, 80, 176, 1.0),
          //             ),
          //           ),
          //         )
          //       : const SizedBox.shrink();
          // }),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    filtersModel.removeListener(() {});
    super.dispose();
  }
}
