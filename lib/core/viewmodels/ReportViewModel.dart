import 'dart:convert';

import 'package:ebus/core/models/ReportArgs.dart';
import 'package:ebus/core/models/ReportTitleItem.dart';
import 'package:ebus/core/services/MockWebservice.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReportViewModel with ChangeNotifier {
  final AuthServiceType? authServiceType;
  ReportViewModel({this.authServiceType});
  bool _loading = true;
  String? _description;
  int? _travelId;
  List<ReportTitleItem>? _reportTitlesList;
  List<ReportTitleItem>? _mainTitleList;
  List<ReportTitleItem>? _subTitlesList;
  List<List<ReportTitleItem>>? _list;
  ReportTitleItem? _selectedMainTitle;
  ReportTitleItem? _selectedSubTitle;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController travelIdController = TextEditingController();
  List<ExpandableController> _expandableControllers = <ExpandableController>[];

  List<ExpandableController> get expandableController => _expandableControllers;

  String get description => _description!;

  set description(String value) {
    _description = value;
    notifyListeners();
  }

  int get travelId => _travelId!;

  set travelId(int value) {
    _travelId = value;
    notifyListeners();
  }

  List<ReportTitleItem> get reportTitlesList => _reportTitlesList!;

  set reportTitlesList(List<ReportTitleItem> value) {
    _reportTitlesList = value;
    notifyListeners();
  }

  List<ReportTitleItem> get subTitlesList => _subTitlesList!;

  set subTitlesList(List<ReportTitleItem> value) {
    _subTitlesList = value;
    notifyListeners();
  }

  List<ReportTitleItem> get mainTitleList => _mainTitleList!;

  set mainTitleList(List<ReportTitleItem> value) {
    _mainTitleList = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ReportTitleItem get selectedMainTitle => _selectedMainTitle!;

  void setSelectedMainTitle(ReportTitleItem value) {
    _selectedMainTitle = value;
    notifyListeners();
  }

  ReportTitleItem get selectedSubTitle => _selectedSubTitle!;

  set selectedSubTitle(ReportTitleItem value) {
    _selectedSubTitle = value;
    notifyListeners();
  }

  init(BuildContext context) {
    getReportsList(context).then((val) {
      notifyListeners();
    });
  }

  Future<bool> getReportsList(BuildContext context) async {
    _loading = true;
    String token = await getToken();
    _reportTitlesList = [];
    _mainTitleList = [];
    _list = [];
    _subTitlesList = [];
    _expandableControllers = [];
    _selectedMainTitle = ReportTitleItem();
    _selectedSubTitle = ReportTitleItem();
    http.Response result;

    result = await Webservice().getReportItemTitles(token);

    final bodyResponse = json.decode(result.body);
    int statusCode = result.statusCode;
    print(statusCode);

    switch (statusCode) {
      case 404:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        _loading = false;
        return false;
        break;
      case 200:
        var dataList = bodyResponse["data"] as List;
        for (int i = 0; i < dataList.length; i++) {
          _reportTitlesList!.add(ReportTitleItem(
              id: dataList[i]["id"],
              title: dataList[i]["title"],
              parentId: dataList[i]["parentId"]));
          if (_reportTitlesList!.last.parentId == null ||
              _reportTitlesList!.last.parentId == 0) {
            _mainTitleList!.add(_reportTitlesList!.last);
            ExpandableController expandableControllerTemp =
                ExpandableController();
            expandableControllerTemp.addListener(() {
              notifyListeners();
            });
            _expandableControllers.add(expandableControllerTemp);
            _list!.add([]);
          }
        }
        int counter = 0;
        _mainTitleList!.forEach((item) {
          getSubItemList(item, counter);
          counter++;
        });
        _selectedMainTitle = _mainTitleList!.first;
        _subTitlesList = <ReportTitleItem>[];
        _loading = false;
        return true;
        break;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        _loading = false;
        return false;
    }
  }

  Future<bool> submitReportInfo(BuildContext context) async {
    _loading = true;
    var userId = await getUserId();
    print('userId = $userId');
    if (travelIdController.text.isEmpty) {
      showInfoFlushbar(context, 'لطفا کد سفر را وارد کنید', '', false);
      return false;
    }
    String token = await getToken();
    int? reportId = _selectedSubTitle!.id ?? _selectedMainTitle!.id;
    http.Response result;
    if (authServiceType == AuthServiceType.mock) {
      result = await MockWebservice().submitReport(
          token,
          descriptionController.text,
          int.parse(travelIdController.text),
          reportId!);
    } else {
      result = await Webservice().submitReport(
          token,
          descriptionController.text,
          int.parse(travelIdController.text),
          reportId!);
    }

    final bodyResponse = json.decode(result.body);
    int statusCode = result.statusCode;
    print(statusCode);
    descriptionController.text = "";
    travelIdController.text = "";
    notifyListeners();

    switch (statusCode) {
      case 404:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        _loading = false;
        notifyListeners();
        return false;
        break;
      case 201:
        var data = bodyResponse;
        String notif = " کد پیگیری گزارش شما ${data["trackingCode"]}";
        _loading = false;
        showInfoFlushbar(context, "گزارش شما ثبت شد", notif, false,
            durationSec: 4);
        notifyListeners();
        return true;
        break;
      case 200:
        var data = bodyResponse;
        _loading = false;
        showInfoFlushbar(context, "گزارش شما ثبت شد", '', false,
            durationSec: 2);
        notifyListeners();
        return true;
        break;
      default:
        showInfoFlushbar(context, 'کد سفر اشتباه است', "", false,
            durationSec: 2);
        _loading = false;
        notifyListeners();
        return false;
    }
  }

  Future<void> getSubItemList(
      ReportTitleItem reportTitleItem, int index) async {
    _subTitlesList = <ReportTitleItem>[];
    for (int i = 0; i < _reportTitlesList!.length; i++) {
      if (_reportTitlesList![i].parentId == reportTitleItem.id) {
        _subTitlesList!.add(_reportTitlesList![i]);
      }
    }
    _list![index] = _subTitlesList!;
  }

  List<List<ReportTitleItem>> get list => _list!;

  void setList(List<List<ReportTitleItem>> value) {
    _list = value;
    notifyListeners();
  }
}
