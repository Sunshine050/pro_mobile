import 'package:flutter/material.dart';

import '../models/filter_model.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  final filtersModel = FiltersModel();
  List<String> filtersList = [
    "Any Available",
    "08:00 - 10:00",
    "10:00 - 12:00",
    "13:00 - 15:00",
    "15:00 - 17:00"
  ];

  List<String> filtersValue = ["any", "slot_1", "slot_2", "slot_3", "slot_4"];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Wrap(
          spacing: 4.0,
          children: List.generate(filtersList.length, (index) {
            return FilterChip(
                label: Text(filtersList[index]),
                selected: filtersModel.isSelected(filtersValue[index]),
                onSelected: (bool selected) => setState(() {
                      filtersModel.updateFilter(filtersValue[index]);
                    }));
          }),
        ),
      ],
    );
  }
}
