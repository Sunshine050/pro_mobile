import 'package:flutter/material.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  List<String> filtersList = [
    "Available Only",
    "08:00 - 10:00",
    "10:00 - 12:00",
    "13:00 - 15:00",
    "15:00 - 17:00"
  ];
  Set<String> filtersSelected = <String>{}; // selected value

  Map<String, int> jsonMap = {}; // map to json for api
  String temp = ""; // for test map

  void filter() {
    for (var value in filtersList) {
      jsonMap[value] = filtersSelected.contains(value) ? 1 : 0;
    }

    // api

    temp = "";
    for (var entry in jsonMap.entries) {
      temp += '${entry.value}, ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 4.0,
          children: filtersList.map((e) {
            return FilterChip(
              label: Text(
                e,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              labelPadding: const EdgeInsets.symmetric(horizontal: 4),
              selected: filtersSelected.contains(e),
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    filtersSelected.add(e);
                    filter();
                  } else {
                    filtersSelected.remove(e);
                    filter();
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
