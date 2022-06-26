import 'dart:convert';

import 'package:ebus/core/models/TravelsHistoryArgs.dart';
import 'package:ebus/core/services/MockWebservice.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart' as sharedPref;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';

class MyTravelDashboardViewModel with ChangeNotifier {
  final AuthServiceType? authServiceType;
  MyTravelDashboardViewModel({this.authServiceType});
  ScrollController _scrollController = ScrollController();
  bool _scrollVisibility = true;
  bool _loading = true;
  String? _travelCount, _travelDistance, _travelTime;
  List<TravelHistoryArgs>? _myTravels;
  List<MapController>? _mapList;
  var formatter = NumberFormat('#,###');

  List<MapController> get mapList => _mapList!;
  set mapList(List<MapController> value) {
    _mapList = value;
  }

  bool get scrollVisibility => _scrollVisibility;
  set scrollVisibility(bool value) {
    _scrollVisibility = value;
    notifyListeners();
  }

  ScrollController get scrollController => _scrollController;
  set scrollController(ScrollController value) {
    _scrollController = value;
    notifyListeners();
  }

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String get travelCount => _travelCount!;
  set travelCount(String value) {
    _travelCount = value;
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

  List<TravelHistoryArgs> get myTravels => _myTravels!;
  set myTravels(List<TravelHistoryArgs> value) {
    _myTravels = value;
    notifyListeners();
  }

  init(BuildContext context) {
    _loading = true;
    _scrollVisibility = true;
    _mapList = <MapController>[];
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          5 /*|| _scrollController.position.pixels < _scrollController.position.maxScrollExtent*/)
        _scrollVisibility = false;
      else
        _scrollVisibility = true;
      notifyListeners();
      //print("_scrollVisibility $_scrollVisibility");
      //print("_scrollController.position.pixels ${_scrollController.position.pixels}");
    });
    getDashboardInfo(context).then((val) {
      notifyListeners();
    });
  }

  bool isInteger(value) => value is int;

  Future<bool> getDashboardInfo(BuildContext context) async {
    _loading = true;
    var result;
    if (authServiceType == AuthServiceType.mock) {
      result = await MockWebservice().getUserStatics("token");
    } else {
      result = await Webservice().getTravelDashboardInfo();
    }
    print("getDashboardInfo $result");

    switch (result) {
      case "null":
        showInfoFlushbar(context, dialogErrorSTR, "خطای سرور", false,
            durationSec: 2);
        // sharedPref.setLogout(context);
        _loading = false;
        // notifyListeners();
        return false;
        break;
      default:
        final bodyResponse = json.decode(result);

        var data;
        try {
          data = bodyResponse;
        } catch (e) {
          print("getDashboardInfo data error $e");
          showInfoFlushbar(
              context, dialogErrorSTR, "خطا در دریافت اطلاعات", false,
              durationSec: 2);
        }
        print('data length getDashboardInfo= ${data.length}');
        _travelCount = (data["travelCount"] ?? "وارد نشده").toString();
        _travelDistance = (data["distanceCount"] ?? "وارد نشده").toString();
        _travelTime = (data["hourCount"] ?? "وارد نشده").toString();

        _myTravels = [];
        var list = data["travelReports"] as List;
        if (list == null) {
          _loading = false;
          // notifyListeners();
          return true;
          //list=jsonDecode('[{"id": 855, "sourceTownship": "زنجان", "destTownship": "تهران", "seatCount": 1, "departureDatetime": "2020-11-05T00:00:00", "ticketPrice": 0}, {"id": 855, "sourceTownship": "زنجان", "destTownship": "تهران", "seatCount": 1, "departureDatetime": "2020-11-05T00:00:00", "ticketPrice": 0},{"id": 855, "sourceTownship": "زنجان", "destTownship": "تهران", "seatCount": 1, "departureDatetime": "2020-11-05T00:00:00", "ticketPrice": 0}]');
        }
        list.forEach((item) {
          _mapList!.add(MapController());
          _myTravels!.add(
            TravelHistoryArgs(
              id: item["id"] ?? -1,
              sourceTown: item["sourceTownship"] ?? "نامشخص",
              destTown: item["destTownship"] ?? "نامشخص",
              seatCount: isInteger((item["seatCount"] ?? -1))
                  ? (item["seatCount"] ?? -1)
                  : int.parse(item["seatCount"]),
              date: item["departureDatetime"] ?? "",
              time: item["departureDatetime"].toString().substring(11, 16),
              travelTicketPrice: item["ticketPrice"] ?? -1,
              sourceLat: (item["sourceLat"] ?? 36.6830) * 0.0, //Zanjan lat
              sourceLong: (item["sourceLong"] ?? 48.5087) * 0.0, //Zanjan long
              destLat: (item["destLat"] ?? 35.6892) * 0.0, //Tehran lat
              destLong: (item["destLong"] ?? 51.3890) * 0.0, //Tehran long
              qrCode: item["qrCode"],
            ),
          );
        });

        _loading = false;
        // notifyListeners();
        return true;
        break;
    }
  }

  bool isAfter(String date) {
    print('date is $date');
    print('parsed date is ${DateTime.parse(date)}');
    // return true;
    return DateTime.parse(date).isAfter(DateTime.now());
  }
}
