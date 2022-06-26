import 'dart:convert';

import 'package:ebus/core/models/Festival.dart';
import 'package:ebus/core/services/MockWebservice.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/cupertino.dart';

class FestivalsViewModel with ChangeNotifier {
  final AuthServiceType? authServiceType;
  FestivalsViewModel({this.authServiceType});
  bool _isFestivalsLoaded = false;
  bool _noInternetFestival = false;
  List<Festival> _festivals = <Festival>[];

  bool get isFestivalsLoaded => _isFestivalsLoaded;
  bool get noInternetFestival => _noInternetFestival;
  List<Festival> get festivals => _festivals;

  Future<bool> getFestivals(BuildContext context, int limit) async {
    var result;
    if (authServiceType == AuthServiceType.mock) {
      // result = await MockWebservice().getFestivals(limit);
    } else {
      result = await Webservice().getFestivals(limit);
    }

    if (result == null) {
      _isFestivalsLoaded = true;
      _noInternetFestival = true;
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
        statusCode = bodyResponse[0]['get_festivals']["status"];
        data = bodyResponse[0]['get_festivals']["data"];
      }

      final Iterable json = data;

      _festivals = json.map((item) => Festival.fromJson(item)).toList();
      print("festivals length = ${_festivals.length}");

      _isFestivalsLoaded = true;
      _noInternetFestival = false;
      notifyListeners();
      return true;
    }
  }

  void goToFestivalDetail(BuildContext context, Festival festival) {
    Navigator.of(context).pushNamed('/FestivalDetailView', arguments: festival);
  }

  void goBuyTicket(BuildContext context, Festival id) {
    Navigator.of(context).pushNamed('/FestivalTownView', arguments: id);
  }

  void reload(BuildContext context) {
    _noInternetFestival = false;
    _isFestivalsLoaded = false;
    notifyListeners();
    getFestivals(context, 0);
  }
}
