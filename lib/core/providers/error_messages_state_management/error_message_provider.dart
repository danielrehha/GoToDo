import 'package:flutter/material.dart';

class ErrorMessageProvider extends ChangeNotifier {
  String errorMessage = '';

  void setErrorMessage({@required String error}) {
    errorMessage = error;
    notifyListeners();
  }

  void clearErrorMessage() {
    errorMessage = '';
    notifyListeners();
  }
}
