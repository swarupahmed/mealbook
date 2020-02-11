import 'package:flutter/material.dart';

class StateNotifer with ChangeNotifier {
  bool _fabDisabled = false;
  bool _navDisabled = false;

  get fabDisabled => _fabDisabled;
  get navDisabled => _navDisabled;

  set fabDisabled(val) {
    _fabDisabled = val;
    notifyListeners();
  }

  set navDisabled(val) {
    _navDisabled = val;
    notifyListeners();
  }
}
