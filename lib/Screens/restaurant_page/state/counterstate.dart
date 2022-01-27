import 'package:flutter/cupertino.dart';

class CounterState with ChangeNotifier {
  Map<String, int> _counterMap = Map();

  int? getValue(String key) {
    return _counterMap[key];
  }

  intialize(String key) {
    _counterMap[key] = 0;
    notifyListeners();
  }

  increaseValue(String key) {
    if (_counterMap[key] != null) _counterMap[key] = _counterMap[key]! + 1;
    notifyListeners();
  }

  decreaseValue(String key) {
    if (_counterMap[key] != null) _counterMap[key] = _counterMap[key]! - 1;
    notifyListeners();
  }
}
