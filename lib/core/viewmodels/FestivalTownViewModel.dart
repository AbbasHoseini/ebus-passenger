import 'dart:convert';
import 'package:ebus/core/models/Festival.dart';
import 'package:ebus/core/models/FestivalTown.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/material.dart';

class FestivalTownViewModel with ChangeNotifier {
  final AuthServiceType? authServiceType;
  FestivalTownViewModel({this.authServiceType});

  Festival? _festival;

  bool _isFestivalTownsLoaded = false;
  bool _noInternetFestivalTowns = false;

  bool get isFestivalTownsLoaded => _isFestivalTownsLoaded;
  bool get noInternetFestivalTowns => _noInternetFestivalTowns;

  List<FestivalTown> _festivalTowns = <FestivalTown>[];

  List<FestivalTown> get festivalTowns => _festivalTowns;

  Festival get festivalId => _festival!;

  void init(BuildContext context, Festival festival) {
    _festival = festival;
    getFestivalTowns(context);
  }

  Future<bool> getFestivalTowns(BuildContext context) async {
    var result;
    if (authServiceType == AuthServiceType.mock) {
      // result = await MockWebservice().getFestivalTowns();
    } else {
      result = await Webservice().getFestivalTowns(_festival!.id!);
    }

    if (result == null) {
      _isFestivalTownsLoaded = true;
      _noInternetFestivalTowns = true;
      notifyListeners();
      return true;
    } else {
      final bodyResponse = jsonDecode(result);
      var statusCode;
      var data;

      try {
        statusCode = bodyResponse["status"];
        data = bodyResponse["data"];
      } catch (e) {
        statusCode = bodyResponse[0]['get_festival_travels']["status"];
        data = bodyResponse[0]['get_festival_travels']["data"];
      }

      if (data == null || data == "null") {
        _isFestivalTownsLoaded = true;
        _noInternetFestivalTowns = false;
        notifyListeners();
        return true;
      } else {
        final Iterable json = data;

        _festivalTowns =
            json.map((item) => FestivalTown.fromJson(item)).toList();
        print("festival towns length = ${_festivalTowns.length}");
        _isFestivalTownsLoaded = true;
        _noInternetFestivalTowns = false;
        notifyListeners();
        return true;
      }
    }
  }

  void reload(BuildContext context) {
    getFestivalTowns(context);
  }

  void clear() {
    _festivalTowns = [];
    _isFestivalTownsLoaded = false;
    _noInternetFestivalTowns = false;
  }
}
