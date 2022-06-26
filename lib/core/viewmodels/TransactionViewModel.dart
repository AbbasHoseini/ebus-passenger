import 'dart:convert';

import 'package:ebus/core/models/TransactionArgs.dart';
import 'package:ebus/core/services/MockWebservice.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionViewModel with ChangeNotifier {
  final AuthServiceType? authServiceType;
  TransactionViewModel({this.authServiceType});
  bool _isLoading = true;
  List<TransactionArgs> _transactions = <TransactionArgs>[];

  bool get isLoading => _isLoading;
  List<TransactionArgs> get transactions => _transactions;
  Future<bool> getTransactionList(BuildContext context) async {
    String token = await getToken();
    List<TransactionArgs> transactions = [];
    http.Response result;
    if (authServiceType == AuthServiceType.mock) {
      result = await MockWebservice().getTransactionsHistoryResult(token);
    } else {
      result = await Webservice().getTransactionsHistoryResult(token);
    }
    print("getTransactionList $result");

    final bodyResponse = json.decode(result.body);
    int statusCode = result.statusCode;
    print(statusCode);

    switch (statusCode) {
      case 400:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        notifyListeners();
        _isLoading = false;
        return false;
        break;
      case 200:
        var dataList = bodyResponse["data"] as List;
        if (dataList == null) return true;
        String tType = "";
        for (int i = 0; i < dataList.length; i++) {
          if (dataList[i]["pay_type"] == 1)
            tType = "واریز";
          else
            tType = "پرداخت";
          transactions.add(TransactionArgs(
              id: dataList[i]["id"],
              title: dataList[i]["description"] ?? "نامشخص",
              description: "وارد نشده",
              amount: dataList[i]["amount"],
              type: tType,
              date: getShamsiDate(dataList[i]["createdAt"].substring(0, 10)),
              time: dataList[i]["createdAt"].toString().substring(11, 16)));
        }
        _transactions = transactions;
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
