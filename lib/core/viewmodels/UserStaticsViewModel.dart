import 'dart:convert';

import 'package:ebus/core/services/MockWebservice.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserStaticsViewModel with ChangeNotifier {
  final AuthServiceType? authServiceType;
  UserStaticsViewModel({this.authServiceType});
  
  bool? _loading = true;
  String? _travelCount, _travelPrice, _travelDistance, _travelTime,_travelDiscount;


  bool get loading => _loading!;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String get travelCount => _travelCount!;

  set travelCount(String value) {
    _travelCount = value;
    notifyListeners();
  }

  get travelPrice => _travelPrice;

  set travelPrice(value) {
    _travelPrice = value;
    notifyListeners();
  }

  get travelDistance => _travelDistance;

  set travelDistance(value) {
    _travelDistance = value;
    notifyListeners();
  }

  get travelTime => _travelTime;

  set travelTime(value) {
    _travelTime = value;
    notifyListeners();
  }

  get travelDiscount => _travelDiscount;

  set travelDiscount(value) {
    _travelDiscount = value;
    notifyListeners();
  }

  Future<bool> getUserStaticInfo(BuildContext context) async {
    _loading=true;
    String token = await getToken();
    var result;
    if (authServiceType == AuthServiceType.mock) {
      result = await MockWebservice().getUserStatics(token);
    } else {
      result = await Webservice().getUserStatics(token);
    }
    print("getUserStaticInfo $result");

    final bodyResponse = json.decode(result);
    String statusCode = bodyResponse["status"];
    print(statusCode);
    notifyListeners();

    switch (statusCode) {
      case "404":
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        _loading=false;
        notifyListeners();
        return false;
        break;
      case "200":
        var data = bodyResponse["data"];
        _travelCount = (data["travel_count"]?? "وارد نشده").toString();
        _travelPrice = (data["travel_price"] ?? "وارد نشده").toString();
        _travelDistance = data["travel_distance"] ?? "وارد نشده";
        _travelTime =( data["travel_time"] ?? "وارد نشده").toString();
        _travelDiscount = (data["travel_discount"] ?? "وارد نشده").toString();
        _loading=false;
        notifyListeners();
        return true;
        break;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        _loading=false;
        notifyListeners();
        return false;
    }
  }


}