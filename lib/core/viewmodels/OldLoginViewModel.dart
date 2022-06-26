import 'dart:convert';

import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart' as sharedPreference;

class OldLoginViewModel extends ChangeNotifier {
  String? _token;
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  get token => _token;
  void setToken(String ss) {
    _token = ss;
    notifyListeners();
  }

  var passwordController = TextEditingController();
  var usernameController = TextEditingController();

  bool loginValidateFields(BuildContext context) {
    if (usernameController.text.length < 1 ||
        passwordController.text.length < 1) {
      showInfoFlushbar(context, signInFieldEmptySTR, signInFieldEmptySTR, false,
          durationSec: 2);
      return false;
    } else
      return true;
  }

  Future<bool> signIn(BuildContext context) async {
    String password = passwordController.text;
    String username = usernameController.text;

    final result = await Webservice().login(password, username);
    print("signInnnnnnnnnnn $result");

    final bodyResponse = json.decode(result.body);
    var data;

    print(result);
    print(result.statusCode);
    switch (result.statusCode) {
      case 404:
        showInfoFlushbar(
            context, "نام کاربری یافت نشد!", "نام کاربری یافت نشد!", false,
            durationSec: 2);
        notifyListeners();
        return false;
        break;

      case 401:
        showInfoFlushbar(context, "رمز عبور یا نام کاربری اشتباه است!",
            "رمز عبور یا نام کاربری اشتباه است!", false,
            durationSec: 2);
        notifyListeners();
        return false;
        break;
      case 200:
        _token = bodyResponse["accessToken"];
        await sharedPreference.setToken(_token!);

        await sharedPreference.setUserId(bodyResponse["id"] ?? 0);
        await sharedPreference.setUserInfo(
            bodyResponse["firstName"] ?? 'null',
            bodyResponse["lastName"] ?? 'null',
            bodyResponse["nationalCode"] ?? 'null',
            bodyResponse["userName"] ?? 'null',
            bodyResponse["phone"] ?? 'null',
            bodyResponse["gender"] ?? 0,
            bodyResponse["credit"] ?? 0);
        setToken(_token!);
        if (_token == null) {
          showInfoFlushbar(context, "خطای توکن", "خطای توکن", false,
              durationSec: 2);
          return false;
        } else {
          await setLoggedIn(bodyResponse["userName"] ?? '', _token!);
        }

        notifyListeners();
        return true;
        break;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "خطای ناشناخته!", false,
            durationSec: 2);
        notifyListeners();
        return false;
    }
  }
}
