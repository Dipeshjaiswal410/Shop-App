import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  bool _passwordVisibility = true;
  bool get passwordVisibility => _passwordVisibility;

  /*********Visibility********/
  void changePasswordVisibility() {
    if (_passwordVisibility == true) {
      _passwordVisibility = false;
      notifyListeners();
    } else {
      _passwordVisibility = true;
      notifyListeners();
    }
  }
}
