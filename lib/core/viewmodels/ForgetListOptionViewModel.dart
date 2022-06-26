import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ebus/core/services/Webservice.dart';

class ForgetListOptionViewModel extends ChangeNotifier{
  //ForgetListOption forgetListOption;
  bool? status;
  bool? mail;
  bool? phone;
  int? id;

  ForgetListOptionViewModel({this.status, this.mail, this.phone, this.id});

  List<String> get optionsList{
    List<String> list= <String>[];
    if(phone!){list.add("phone");}
    if(mail!){list.add("mail");}
    return list;
  }

  /*Future<bool> getForgetListOptions(String username, String clientID, String fcmToken, String rsa) async {
    this.forgetListOption =  await Webservice().forgetPassword1GetOptions(username, clientID, fcmToken, rsa);
    notifyListeners();
    return this.forgetListOption.status;
  }*/

  Future<bool> getForgetListOptions(String username, String clientID, String fcmToken, String rsa) async {
    final String response  =  await forgetPassword1GetOptions(username, clientID, fcmToken, rsa);
    var jsonObj= jsonDecode(response);

    status=jsonObj["phone"];
    mail=jsonObj["mail"];
    phone=jsonObj["phone"];
    id=jsonObj["id"];
    print("$status $mail $phone $id");

    notifyListeners();
    return status!;
  }

}