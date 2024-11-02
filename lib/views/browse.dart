import 'package:flutter/material.dart';
import 'package:pro_mobile/components/tabsBar.dart';
import 'package:pro_mobile/views/staff/manage_rooms_page.dart';
import 'package:pro_mobile/widgets/staff_add_edit.dart';
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

  late Map<int, Map<String, dynamic>> roomsSample;
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
    roomsSample = {
      1: {
        "role": widget.role,
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
        "role": widget.role,
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
        "role": widget.role,
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
        "role": widget.role,
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
        "role": widget.role,
        "roomId": '5',
        "roomName": 'room_name',
        "desc":
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus non purus a erat tempor pretium varius quis dolor. Lorem ipsum. ',
        "img": 'room_1.jpg',
        "slot_1": "free",
        "slot_2": "free",
        "slot_3": "free",
        "slot_4": "free",
      }
    };

    _filterRooms();
    filtersModel.addListener(() {
      _filterRooms();
    });
  }

  void _filterRooms() {
    filteredRooms.clear();
    for (var entry in roomsSample.entries) {
      // check if any slot is free => available
      bool isAvailable = false;
      for (var slot in entry.value.values) {
        if (slot == "free") {
          isAvailable = true;
          break;
        }
      }
      // add to filtered list
      if (filtersModel.isSelected("Any Available") && isAvailable) {
        setState(() {
          filteredRooms[entry.key] = entry.value;
        });
      } else if (!filtersModel.isSelected("Any Available")) {
        if (filtersModel.isSelected("08:00 - 10:00")) {
          for (var slot in entry.value.keys) {
            if (slot == "slot_1" && entry.value["slot_1"] == "free") {
              setState(() {
                filteredRooms[entry.key] = entry.value;
              });
              break;
            }
          }
        } else if (filtersModel.isSelected("10:00 - 12:00")) {
          for (var slot in entry.value.keys) {
            if (slot == "slot_2" && entry.value["slot_2"] == "free") {
              setState(() {
                filteredRooms[entry.key] = entry.value;
              });
              break;
            }
          }
        } else if (filtersModel.isSelected("13:00 - 15:00")) {
          for (var slot in entry.value.keys) {
            if (slot == "slot_3" && entry.value["slot_3"] == "free") {
              setState(() {
                filteredRooms[entry.key] = entry.value;
              });
              break;
            }
          }
        } else if (filtersModel.isSelected("15:00 - 17:00")) {
          for (var slot in entry.value.keys) {
            if (slot == "slot_4" && entry.value["slot_4"] == "free") {
              setState(() {
                filteredRooms[entry.key] = entry.value;
              });
              break;
            }
          }
        } else {
          setState(() {
            filteredRooms[entry.key] = entry.value;
          });
        }
      }
    }
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Room List"),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 16),
                child: SearchButton())
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      labelPadding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      selected: filtersModel.isSelected(e),
                                      onSelected: (bool selected) =>
                                          setState(() {
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
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: filteredRooms.length,
                    itemBuilder: (context, index) {
                      final itemKey = filteredRooms.keys.elementAt(index);
                      final itemData = filteredRooms[itemKey];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 24),
                        child: RoomCard(
                          role: itemData?['role'],
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
                TabsbarNavigator(role: widget.role)
              ],
            ),
            Builder(builder: (context) {
              return (widget.role == "staff")
                  ? Positioned(
                      right: 20.0,
                      bottom: 70.0,
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ManageRooms(
                                        isAdd: true,
                                        roomId: "1",
                                      )));
                        },
                        child: const Icon(Icons.add),
                      ),
                    )
                  : const SizedBox.shrink();
            }),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    filtersModel.removeListener(() {});
    super.dispose();
  }
}
