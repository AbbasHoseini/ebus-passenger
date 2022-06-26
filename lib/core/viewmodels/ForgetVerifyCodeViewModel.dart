import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ebus/core/services/Webservice.dart';

class ForgetVerifyCodeViewModel extends ChangeNotifier{

  String? success, message;

  ForgetVerifyCodeViewModel({this.success, this.message});


  Future<bool> verifyForgetSentForgetCode(int id, String code, String clientID, String fcmToken, String rsa) async {
    final String response  =  await  forgetPassword3CheckCode(id, code, clientID, fcmToken, rsa);
    var jsonObj= jsonDecode(response);

    success=jsonObj["success"];
    message=jsonObj["message"];
    print("$success $message");

    notifyListeners();
    return this.success=="True"? true:false;
  }

}