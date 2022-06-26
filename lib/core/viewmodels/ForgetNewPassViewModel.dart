import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/core/viewmodels/loginViewModelOld.dart';

class ForgetNewPassViewModel extends ChangeNotifier{

  bool? success;

  ForgetNewPassViewModel({this.success});


  List<LoginViewModelOld> loginList = <LoginViewModelOld>[];


  Future<bool> confirmNewPass(int id, String password, String clientID, String fcmToken, String rsa) async {
    final results =  await forgetPassword4ConfirmCode(id, password, password, clientID, fcmToken, rsa);
    loginList = results.map((item) => LoginViewModelOld(login: item)).toList();
    print(loginList);
    success=loginList[0].loggedIn;
    notifyListeners();
    return loginList[0].loggedIn;
  }

}