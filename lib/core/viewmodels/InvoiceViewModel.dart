import 'dart:async';
import 'dart:convert';

import 'package:ebus/core/models/InvoiceArgs.dart';
import 'package:ebus/core/models/PassengerArgs.dart';
import 'package:ebus/core/services/MockWebservice.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:uni_links/uni_links.dart';
import 'package:intl/intl.dart' as intl;
import 'package:http/http.dart' as http;

class InvoiceViewModel with ChangeNotifier {
  final AuthServiceType? authServiceType;
  InvoiceViewModel({this.authServiceType});
  bool _loading = false;
  String _latestLink = 'Unknown';
  Uri? _latestUri;
  StreamSubscription? _sub;
  List<PassengerArgs>? _passengersArgs;
  var formatter = intl.NumberFormat('#,###');

  MapController? _mapController;
  MapController get mapController => _mapController!;

  List<PassengerArgs> get passengersArgs => _passengersArgs!;

  set passengersArgs(List<PassengerArgs> value) {
    _passengersArgs = value;
    notifyListeners();
  }

  goToNextPage(BuildContext context) {
    print('go to next page!');
    Navigator.pushNamed(
      context,
      '/AssignPassengersView',
    );
  }

  initPlatformStateForStringUniLinks(BuildContext context) async {
    // Attach a listener to the links stream
    _sub = linkStream.listen((link) {
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
        goToNextPage(context);
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

    _latestLink = initialLink ?? '';
    _latestUri = initialUri;
  }

  Future payTheBill(BuildContext context, InvoiceArgs invoiceArgs) async {
    if (_loading) {
      showInfoFlushbar(
          context, "توجه", "لطفا منتظر دریافت پاسخ پرداخت بمانید", false,
          durationSec: 2);
      return;
    }
    _loading = true;
    notifyListeners();
    String token = await getToken();
    http.Response response;
    print('payTheBill');
    try {
      if (authServiceType != AuthServiceType.mock) {
        response = await Webservice().getPayByCreditResult(token, invoiceArgs);
      } else {
        response = await MockWebservice().getPayByCreditResult();
      }
    } on Exception catch (e) {
      showInfoFlushbar(context, "سرویس کامل نیست", "سرویس کامل نیست", false,
          durationSec: 2);
      return false;
    }
    print('response = ${response.body}');
    if (response != null) {
      var bodyResponse = json.decode(response.body);
      int statusCode;

      statusCode = response.statusCode;

      if (statusCode == 200 || statusCode == 201) {
        _loading = false;
        notifyListeners();
        Navigator.pushNamed(
          context,
          '/AssignPassengersView',
        );
      } else {
        String message;
        try {
          message = bodyResponse["message"];
        } catch (e) {
          try {
            message = bodyResponse["data"]["message"];
          } catch (e) {
            message = 'خطای اینترنت یا اعتبار ناکافی';
          }
        }
        _loading = false;
        notifyListeners();
        showInfoFlushbar(context, 'خطا', message, false, durationSec: 3);
      }
    } else {
      _loading = false;
      showInfoFlushbar(context, 'خطا', (response ) as String, false,
          durationSec: 3);
      notifyListeners();
    }
  }

  bool get loading => _loading;
  set setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void init(BuildContext context, InvoiceArgs args) {
    print('sourcePoint = ${args.sourcePoint}');
    print('destinationPoint = ${args.destinationPoint}');
    _mapController = MapController();
    _mapController!.onReady.then((value) {
      _mapController!.fitBounds(
          LatLngBounds.fromPoints([
            args.sourcePoint ?? LatLng(36.637570, 48.469709),
            args.destinationPoint ?? LatLng(35.643905, 51.405017)
          ]),
          options: const FitBoundsOptions(
              padding:
                  EdgeInsets.only(left: 52, right: 32, bottom: 85, top: 64)));
    });

    initPlatformStateForStringUniLinks(context);
  }
}
