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
    "Available Only",
    "08:00 - 10:00",
    "10:00 - 12:00",
    "13:00 - 15:00",
    "15:00 - 17:00"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
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
                style: Theme.of(context).textTheme.bodySmall,
              ),
              labelPadding: const EdgeInsets.symmetric(horizontal: 4),
              selected: filtersModel.isSelected(e),
              onSelected: (bool selected) => setState(() {
                filtersModel.updateFilter(e);
              }),
            );
          }).toList(),
        ),
      ],
    );
  }
}
