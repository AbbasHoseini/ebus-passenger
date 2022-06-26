import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ebus/core/models/AppUpdate.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashViewmodel with ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isLastVersion = false;
  bool _isTimerFinnished = false;
  AppUpdate? _appUpdate;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLastVersion => _isLastVersion;
  bool get isTimerFinnished => _isTimerFinnished;
  AppUpdate get appUpdate => _appUpdate!;

  Future initSplash(BuildContext context) async {
    
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 25.0
      ..radius = 5.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.white
      ..maskType = EasyLoadingMaskType.custom
      ..textColor = Colors.white
      ..maskColor = Colors.grey.withOpacity(0.7)
      ..dismissOnTap = true;
  }
}
