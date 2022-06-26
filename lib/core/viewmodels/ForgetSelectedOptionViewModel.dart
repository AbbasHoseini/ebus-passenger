import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ebus/core/services/Webservice.dart';

class ForgetSelectedOptionViewModel extends ChangeNotifier{

  bool? success;
  int? id;

  ForgetSelectedOptionViewModel({this.success, this.id});


  /*Future<bool> getForgetSelectedOption(int id, bool phone, bool mail) async {
    this.forgetSelectedOption =  await Webservice().forgetPassword2OptionSelected(id, mail, phone, "","","");
    notifyListeners();
    return this.forgetSelectedOption.success;
  }*/

  Future<bool> getForgetSelectedOption(int id, bool phone, bool mail) async {
    final String response =  await forgetPassword2OptionSelected(id, mail, phone, "","","");
    var jsonObj= jsonDecode(response);

    success=jsonObj["success"];
    this.id=jsonObj["id"];
    print("$success $id");


    notifyListeners();
    return success!;
  }

}