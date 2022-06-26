import 'dart:async';
import 'dart:convert';

import 'package:ebus/core/services/MockWebservice.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/core/viewmodels/SignUpViewmodel.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart' as sharedPreference;
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
// import 'package:sms_advanced/sms_advanced.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthServiceType? authServiceType;
  LoginViewModel({this.authServiceType});
  int _step = 0;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _verifyCodeController = TextEditingController();
  void setStep(int s) {
    _step = s;
    notifyListeners();
  }

  final FocusNode _codeFocusNode = FocusNode();
  FocusNode get codeFocusNode => _codeFocusNode;

  int get step => _step;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get verifyCodeController => _verifyCodeController;

  String? _token;
  bool _loading = false;
  // ProgressDialog pr;
  // ProgressDialog prVerify;
  int? _endTime;
  int get endTime => _endTime!;
  bool _isCountingDown = false;
  bool get isCountingDown => _isCountingDown;
  bool get loading => _loading;

  bool _smsRecieved = false;
  bool get smsRecieved => _smsRecieved;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  get token => _token;
  void setToken(String ss) {
    _token = ss;
    notifyListeners();
  }

  // sms receiver
  // final SmsReceiver _receiver = SmsReceiver();
  // void listenToSMS() {
  //   print('listening to SMS');
  //   _receiver.onSmsReceived!.listen((SmsMessage msg) {
  //     onSmsReceived(msg.body!);
  //   });
  // }

  void onSmsReceived(String message) {
    print('message = $message');

    if (message.contains('ایباس') ||
        message.toLowerCase().contains('ebus') ||
        message.contains('کد تایید')) {
      String code = message.split(':')[1].replaceAll(' ', '');
      print(code);
      code = code.trim();
      code = code.split('\n').first.trim().replaceAll(' ', '');
      print(code);

      _smsRecieved = true;
      notifyListeners();
      if (_step == 1) {
        Future.delayed(const Duration(seconds: 1), () {
          _verifyCodeController.text = code;
          notifyListeners();
        });
      }
    } else {}
  }




  // BoxDecoration get pinPutDecorationSubmitted {
  //   return BoxDecoration(
  //     color: Colors.grey[200],
  //     borderRadius: BorderRadius.circular(20.0),
  //   );
  // }
  
  defaultPinTheme(myWidth) {
    final defaultPinTheme = PinTheme(
      margin: const EdgeInsets.all(2.0),
      constraints: BoxConstraints(maxWidth: (myWidth - 22 - 64) / 7),
      height: (myWidth - 22 - 64) / 7,
      width: (myWidth - 22 - 64) / 7,
      decoration: const BoxDecoration(),
    );
    return defaultPinTheme;
  }

  submittedPinTheme(myWidth) {
    final submittedPinTheme = defaultPinTheme(myWidth).copyWith(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
    return submittedPinTheme;
  }

focusedPinTheme(myWidth) {
    final focusedPinTheme = defaultPinTheme(myWidth).copyDecorationWith(
      // PinTheme(
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all(
        color: colorPrimary,
        width: 1,
      ),
    );
    return focusedPinTheme;
  }
  // BoxDecoration get pinPutDecorationSelected {
  //   return BoxDecoration(
  //     // color: Colors.grey[300],
  //     borderRadius: BorderRadius.circular(5.0),
  //     border: Border.all(
  //       color: colorPrimary,
  //       width: 1,
  //     ),
  //   );
  // }

followingPinTheme(myWidth) {
    final followingPinTheme = defaultPinTheme(myWidth).copyWith(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
    return followingPinTheme;
  }
  // BoxDecoration get pinPutDecorationFollowing {
  //   return BoxDecoration(
  //     color: Colors.grey[100],
  //     borderRadius: BorderRadius.circular(5.0),
  //   );
  // }

  bool loginValidateFields(BuildContext context) {
    if (phoneController.text.isEmpty) {
      showInfoFlushbar(context, 'شماره تلفن نمی‌تواند خالی باشد!',
          'شماره تلفن نمی‌تواند خالی باشد!', false,
          durationSec: 2);
      return false;
    } else if (phoneController.text.length != 11) {
      showInfoFlushbar(context, 'شماره تلفن اشتباه وارد شده است',
          'شماره تلفن اشتباه وارد شده است', false,
          durationSec: 2);
      return false;
    } else {
      return true;
    }
  }

  Future<bool> sendCode(BuildContext context) async {
    String phone = phoneController.text;
    // listenToSMS();
    http.Response result;
    _loading = true;
    notifyListeners();
    if (authServiceType == AuthServiceType.mock) {
      result = await MockWebservice().loginWithMobile(phone);
    } else {
      result = (await Webservice().loginWithMobile(phone))!;
    }
    _loading = false;
    notifyListeners();
    print("fast sendCode to $phone $result");
    if (result == null || result == 'null') {
      showInfoFlushbar(context, dialogErrorSTR, "خطای اتصال به سرور!", false,
          durationSec: 2);
      notifyListeners();
      return false;
    }
    final bodyResponse = json.decode(result.body);
    var statusCode;
    var data;

    statusCode = result.statusCode;
    data = bodyResponse["data"];

    print(bodyResponse);
    switch (statusCode) {
      case 404:
        showInfoFlushbar(context, "کاربری یافت نشد!", "کاربری یافت نشد!", false,
            durationSec: 2);

        notifyListeners();
        return false;

      case 200:
        _isCountingDown = true;
        _endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60;
        _step = 1;

        notifyListeners();
        if (authServiceType == AuthServiceType.mock) {
          _codeFocusNode.requestFocus();
          Future.delayed(const Duration(seconds: 1), () {
            _smsRecieved = true;
            notifyListeners();
          });
        }

        return true;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "خطای ناشناخته!", false,
            durationSec: 2);
        notifyListeners();
        return false;
    }
  }

  signIn(BuildContext context) async {
    String phone = phoneController.text;
    String varifyCode = verifyCodeController.text;
    // listenToSMS();
    http.Response result;
    _loading = true;
    notifyListeners();
    if (authServiceType == AuthServiceType.mock) {
      result = await MockWebservice().singInFast(phone, varifyCode);
    } else {
      result = await Webservice().singInFast(phone, varifyCode);
    }
    print("fast signIn $result");

    _loading = false;
    notifyListeners();
    if (result.statusCode == 500) {
      showInfoFlushbar(
          context, "خطای اتصال به سرور", "خطای اتصال به سرور", false,
          durationSec: 2);
      return false;
    }

    if (result == null || result.statusCode == 404) {
      showInfoFlushbar(
          context,
          "کد تایید فاقد اعتبار یا زمان آن پایان یافته است",
          "کد تایید فاقد اعتبار یا زمان آن پایان یافته است",
          false,
          durationSec: 2);
      _verifyCodeController.clear();
      notifyListeners();
      return false;
    }

    final bodyResponse = json.decode(result.body);
    int statusCode;

    statusCode = result.statusCode;

    print(statusCode);
    _smsRecieved = false;

    switch (statusCode) {
      case 404:
        showInfoFlushbar(
            // context, dialogErrorSTR, "شماره تلفن تایید نشده است!", false,
            context,
            "کد تایید فاقد اعتبار یا زمان آن پایان یافته است",
            // "Verification Token Timeout ",
            "کد تایید فاقد اعتبار یا زمان آن پایان یافته است",
            false,
            durationSec: 2);

        notifyListeners();
        return false;
        break;
      case 200:
        // prVerify.hide();
        // showInfoFlushbar(context, '', "User Verifed Successfully", false,
        _isCountingDown = false;
        String token = bodyResponse["data"]["token"];
        await sharedPreference.setToken(token);
        await sharedPreference
            .setUserId(bodyResponse["data"]["user"]["id"] ?? 0);
        await sharedPreference.setUserInfo(
            bodyResponse["data"]["user"]["firstName"] ?? 'null',
            bodyResponse["data"]["user"]["lastName"] ?? 'null',
            bodyResponse["data"]["user"]["nationalCode"] ?? 'null',
            bodyResponse["data"]["user"]["username"] ?? 'null',
            bodyResponse["data"]["user"]["phone"] ?? 'null',
            bodyResponse["data"]["user"]["gender"] ?? 0,
            bodyResponse["data"]["user"]["credit"] ?? 0);
        setToken(token);
        print('bodyResponse["data"]["user"] = ${bodyResponse["data"]["user"]}');
        print(
            'bodyResponse["data"]["user"]["lastName"] = ${bodyResponse["data"]["user"]["lastName"]}');

        String name = '';
        if (bodyResponse["data"]["user"]["firstName"] == null &&
            bodyResponse["data"]["user"]["lastName"] == null) {
          name = bodyResponse["data"]["user"]["phone"] ?? '';
        } else {
          name = (bodyResponse["data"]["user"]["firstName"] ?? '') +
              ' ' +
              (bodyResponse["data"]["user"]["lastName"] ?? '');
        }
        await setLoggedIn(name, token);
        // showInfoFlushbar(context, '', "ورود با موفقیت", false, durationSec: 2);
        notifyListeners();

        clear();
        if (context != null) {
          print('going to main view');
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/MainView', (Route<dynamic> route) => false);
        }

        // return true;
        break;
      default:
        // prVerify.hide();
        showInfoFlushbar(context, dialogErrorSTR, "خطای ناشناخته!", false,
            durationSec: 2);
        notifyListeners();
      // return false;
    }
  }

  void clear() {
    _phoneController.clear();
    _verifyCodeController.clear();
    _step = 0;
    _smsRecieved = false;
    // _receiver.onSmsReceived.listen((event) {}).cancel();
    print("cleared");
    notifyListeners();
  }

  void onCountdownEnd() {
    _isCountingDown = false;
    notifyListeners();
  }
}
