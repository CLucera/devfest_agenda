import 'dart:collection';

import 'package:devfest_agenda/models/devfest_model.dart';
import 'package:flutter/material.dart';

class AppChangeNotifier extends ChangeNotifier {

  List<DevfestModel> selectedDevfests = [];


  UnmodifiableListView<DevfestModel> get devfests => UnmodifiableListView(hatDevfest);
  UnmodifiableListView<DevfestModel> get hatDevfests => UnmodifiableListView(hatDevfest);

  void select(List<DevfestModel> items) {
    selectedDevfests = items;
    notifyListeners();
  }

  /// Removes all items from the cart.
  void deselect() {
    selectedDevfests.clear();
    notifyListeners();
  }
}