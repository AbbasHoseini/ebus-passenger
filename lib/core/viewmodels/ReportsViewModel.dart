import 'dart:convert';

import 'package:ebus/core/models/ReportArgs.dart';
import 'package:ebus/core/services/MockWebservice.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ReportsViewModel with ChangeNotifier {
  final AuthServiceType? authServiceType;
  ReportsViewModel({this.authServiceType});
  List<ReportArgs> _reportsArgs = [];
  List<ReportArgs> get reportArgs => _reportsArgs;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  Future<bool> getReportsList(BuildContext context) async {
    List<ReportArgs> reports = [];
    _isLoading = true;
    http.Response result;
    try {
      if (authServiceType == AuthServiceType.mock) {
        result = await MockWebservice().getPassengersOfFaveList();
      } else {
        result = await Webservice().getReportsList();
      }
    } on Exception catch (e) {
      showInfoFlushbar(context, dialogErrorSTR, "خطای سرور", false,
          durationSec: 2);
      notifyListeners();
      return false;
    }
    int statusCode;
    var data;
    final bodyResponse = json.decode(result.body);
    if (result == null) {
      _reportsArgs = [];

      notifyListeners();
      return true;
    } else {
      statusCode = result.statusCode;
      data = bodyResponse["data"];

      if (data == null || data.length < 1) {
        _reportsArgs = [];
        _isLoading = false;
        notifyListeners();
        return true;
      }

      switch (statusCode) {
        case 404:
          showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
          notifyListeners();
          return false;
          break;
        case 200:
          for (int i = 0; i < data.length; i++) {
            if (data[i]["Travel"]["departureDatetime"] == null ||
                data[i]["Travel"]["departureDatetime"] == '')
              data[i]["Travel"]["departureDatetime"] = '0000-00-00T00:00:00';
            if (data[i]["createdAt"] == null || data[i]["createdAt"] == '')
              data[i]["createdAt"] = '0000-00-00T00:00:00';
            print(
                'data[i]["Travel"]["departureDatetime"] ${data[i]["Travel"]["departureDatetime"]}');
            reports.add(ReportArgs(
                reportId: data[i]["supportItemId"] ?? 0,
                travelId: data[i]["travelId"] ?? 0,
                title: data[i]["SupportItem"]["title"] ?? 'نامشخص',
                description: data[i]["description"] ?? 'نامشخص',
                source: data[i]["Travel"]["Direction"]["directionSource"]
                        ["title"] ??
                    'نامشخص',
                destination: data[i]["Travel"]["Direction"]["directionDest"]
                        ["title"] ??
                    'نامشخص',
                travelDate: getShamsiDate(data[i]["Travel"]["departureDatetime"]
                    .toString()
                    .substring(0, 10)),
                createDate: getShamsiDate(
                    data[i]["createdAt"].toString().substring(0, 10)),
                travelTime: data[i]["Travel"]["departureDatetime"]
                    .toString()
                    .substring(11, 16),
                createTime: data[i]["createdAt"].toString().substring(11, 16)));
          }
          print('got _reportsArgs-------------------');
          _reportsArgs = reports;
          _isLoading = false;
          notifyListeners();
          return true;
          break;
        default:
          showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
          _isLoading = false;
          notifyListeners();
          return false;
      }
    }
  }
}
