import 'package:flutter/cupertino.dart';

class BaseViewModel extends ChangeNotifier {
  int currentIndex = 0;
  bool _isSelected = false;

  void updateCurrentIndex(int value) {
    currentIndex = value;
    notifyListeners();
  }

  get isSelected => _isSelected;

  set isSelected(value) {
    _isSelected = value;
    notifyListeners();
  }
}
