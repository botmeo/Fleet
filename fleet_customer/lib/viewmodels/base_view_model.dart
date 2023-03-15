import 'package:flutter/cupertino.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isSelected = false;
  get isSelected => _isSelected;

  set isSelected(value) {
    _isSelected = value;
    notifyListeners();
  }
}
