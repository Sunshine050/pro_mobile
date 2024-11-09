import 'package:flutter/material.dart';

class FiltersModel extends ChangeNotifier {
  Set<String> selectedFilters = {};
  Map<String, String> filtersMap = {
    "Any Available": "any",
    "08:00 - 10:00": "slot_1",
    "10:00 - 12:00": "slot_2",
    "13:00 - 15:00": "slot_3",
    "15:00 - 17:00": "slot_4"
  };

  void updateFilter(String newFilter) {
    if (selectedFilters.contains(newFilter)) {
      selectedFilters.remove(newFilter);
    } else {
      selectedFilters.add(newFilter);
    }
    notifyListeners();
    // print(selectedFilters);
  }

  bool isSelected(String filter) => selectedFilters.contains(filter);

  Map<String, dynamic> getFilterOptions() {
    final mappedFilters = selectedFilters.map((e) {
      return filtersMap[e];
    }).toList();
    // debugPrint(mappedFilters[0]);
    return {'slots': mappedFilters};
  }
}
