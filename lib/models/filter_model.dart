import 'package:flutter/material.dart';

class FiltersModel extends ChangeNotifier {
  Set<String> selectedFilters = {};

  void updateFilter(String newFilter) {
    if (selectedFilters.contains(newFilter)) {
      selectedFilters.remove(newFilter);
    } else {
      selectedFilters.add(newFilter);
    }
    notifyListeners();
    print(selectedFilters);
  }

  bool isSelected(String filter) => selectedFilters.contains(filter);
}
