import 'dart:convert';
import 'package:ebus/core/models/Refund.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RefundsViewModel with ChangeNotifier {
  final AuthServiceType? authServiceType;
  RefundsViewModel({this.authServiceType});
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  List<Refund> _refunds = [];
  List<Refund> get refunds => _refunds;

  Future getRefunds(BuildContext context) async {
    _isLoading = true;
    _refunds = [];

    http.Response? result;
    try {
      if (authServiceType == AuthServiceType.mock) {
        // result = await MockWebservice().getPostRefund();
      } else {
        result = await Webservice().getRefunds();
      }
    } on Exception catch (e) {
      showInfoFlushbar(context, dialogErrorSTR, "خطای سرور", false,
          durationSec: 2);
      notifyListeners();
      return false;
    }
    int statusCode = result!.statusCode;
    switch (statusCode) {
      case 200:
        _successRefund(context, result.body);
        notifyListeners();
        break;
      case 201:
        _successRefund(context, result.body);
        notifyListeners();
        break;
      default:
        showInfoFlushbar(
            context, 'خطا در ارتباط با سرور', 'لطفا دوباره تلاش کنید', false);
        _isLoading = false;
        notifyListeners();
    }
  }

  void _successRefund(BuildContext context, String body) {
    final parsed = jsonDecode(body);
    _refunds =
        parsed["data"].map<Refund>((json) => Refund.fromJson(json)).toList();
    // print('_refunds[0] = ${_refunds[0]}');
    _isLoading = false;
  }

  Future cancelRefund(Refund refund, BuildContext context) async {
    _isLoading = true;
    _refunds = [];

    http.Response? result;
    try {
      if (authServiceType == AuthServiceType.mock) {
        // result = await MockWebservice().getPostRefund();
      } else {
        result = await Webservice().cancelRefund(refund);
      }
    } on Exception catch (e) {
      showInfoFlushbar(context, dialogErrorSTR, "خطای سرور", false,
          durationSec: 2);
      notifyListeners();
      return false;
    }
    int statusCode = result!.statusCode;
    switch (statusCode) {
      case 200:
        _successCancelRefund(context, result.body);
        notifyListeners();
        break;
      case 201:
        _successCancelRefund(context, result.body);
        notifyListeners();
        break;
      default:
        showInfoFlushbar(
            context, 'خطا در ارتباط با سرور', 'لطفا دوباره تلاش کنید', false);
        _isLoading = false;
        notifyListeners();
    }
  }

  void _successCancelRefund(BuildContext context, String body) {
    showInfoFlushbar(context, 'استرداد با موفقیت لغو شد', ' ', false);
    getRefunds(context);
  }
}
