import 'dart:async';
import 'dart:convert';

import 'package:ebus/core/services/MockWebservice.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/CurrencyInputFormatter.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:uni_links/uni_links.dart';

class WalletViewModel with ChangeNotifier {
  final AuthServiceType? authServiceType;
  WalletViewModel({this.authServiceType});

  final int fixAddOrSubsctractAmount = 10000;
  final int firstFixAmount = 500000;
  final int secondFixAmount = 1000000;
  final int thirdFixAmount = 3000000;

  String _latestLink = 'Unknown';
  Uri? _latestUri;
  StreamSubscription? _sub;

  int? _credit;
  int? _addAmount = 0;
  bool _isLoading = true;
  var formatter = NumberFormat('#,###');
  CurrencyInputFormatter addAmountFormatter = CurrencyInputFormatter();
  TextEditingController amountController = TextEditingController();

  int get credit => _credit ?? 0;
  int get addAmount => _addAmount!;
  bool get isLoading => _isLoading;

  set addAmount(int amount) {
    _addAmount = amount;
    notifyListeners();
  }

  Future<int?> getWalletCredit(BuildContext context) async {
    _isLoading = true;
    http.Response result;
    try {
      if (authServiceType == AuthServiceType.mock) {
        result = await MockWebservice().getCredit();
      } else {
        result = await Webservice().getCredit();
      }
    } on Exception catch (e) {
      showInfoFlushbar(context, dialogErrorSTR, "خطای سرور", false,
          durationSec: 2);
      notifyListeners();
      return null;
    }
    int statusCode = result.statusCode;
    switch (statusCode) {
      case 200:
        _credit = jsonDecode(result.body)['credit'];
        _isLoading = false;
        notifyListeners();
        return _credit;
        break;
      case 401:
        showInfoFlushbar(
            context, "لطفا دوباره وارد شوید", "لطفا دوباره وارد شوید", false,
            durationSec: 2);
        Timer(Duration(seconds: 2), () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/LoginView', (route) => false);
        });
        break;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "خطای سرور", false,
            durationSec: 2);
        _isLoading = false;
        _credit = null;
        notifyListeners();
        return null;
    }
  }

  Future<bool> addToCredit(BuildContext context) async {
    await initPlatformStateForStringUniLinks(context);
    int creditToPay = addAmountFormatter.getUnmaskedInt();
    print('55555555555555555555555555555555555555 ${creditToPay}');
    if (creditToPay <= 10000) {
      showInfoFlushbar(
          context, 'مقدار مبلغ نمی‌تواند کمتر از ۱۰۰۰۰ ریال باشد', '', false,
          durationSec: 3);
      return false;
    }
    http.Response response = await Webservice().getOrderId(creditToPay);
    await Webservice().getPayByBankCredit(jsonDecode(response.body)['orderId']);
    return true;
  }

  Future<void> initPlatformStateForStringUniLinks(BuildContext context) async {
    // Attach a listener to the links stream
    _sub = linkStream.listen((String? link) {
      _latestLink = link ?? 'Unknown';
      _latestUri = null;
      try {
        if (link != null) _latestUri = Uri.parse(link);
      } on FormatException {}
      notifyListeners();
    }, onError: (err) {
      _latestLink = 'Failed to get latest link: $err.';
      _latestUri = null;
      notifyListeners();
    });

    // Attach a second listener to the stream
    linkStream.listen((link) {
      print('got link: $link');
      var uri = Uri.parse(link!);
      String message = uri.queryParameters['msg']!;
      bool status = uri.queryParameters['status'] == 'true';
      if (status) {
        print('status is true, message is $message');
        getWalletCredit(context);
      } else {
        print('status is false, message is $message');
      }
    }, onError: (err) {
      print('got err: $err');
    });

    // Get the latest link
    String? initialLink;
    Uri? initialUri;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialLink = await getInitialLink();
      print('initial link: $initialLink');
      if (initialLink != null) initialUri = Uri.parse(initialLink);
    } on PlatformException {
      initialLink = 'Failed to get initial link.';
      initialUri = null;
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
      initialUri = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    _latestLink = initialLink!;
    _latestUri = initialUri;
  }
}
