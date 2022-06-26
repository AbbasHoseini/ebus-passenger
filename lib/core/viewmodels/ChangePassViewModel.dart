import 'package:flutter/material.dart';
import 'package:ebus/core/services/Webservice.dart';

class ChangePassViewModel extends ChangeNotifier {
  bool success;

  ChangePassViewModel({required this.success});

  Future<bool> confirmNewPass(String token, String password, String newPass,
      String newPassConfirm) async {
    final response =
        await changePassword(token, password, newPass, newPassConfirm);
    try {
      if (response.contains("PassChangeSuccessfully")) {
        print(response);
        notifyListeners();
        return true;
      }
    } on Exception catch (e) {
      notifyListeners();
      return false;
    }
    notifyListeners();
    return false;
  }
}
