import 'dart:convert';

import 'package:ebus/core/services/MockWebservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart' as sharedPreference;
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
// import 'package:sms_autofill/sms_autofill.dart';
// import 'package:sms/sms.dart';
// import 'package:sms_advanced/sms_advanced.dart';


class SignUpViewmodel with ChangeNotifier {
  final AuthServiceType? authServiceType;
  SignUpViewmodel({this.authServiceType});

  String? _emailErrorText,
      _passwordErrorText,
      _confirmPasswordErrorText,
      _codeErrorText,
      _nameErrorText,
      _lnameErrorText,
      _usernameErrorText,
      
      _nationalCodeErrorText;

  String? _mailErrorText = '';

  int? _genderValue = 1;

  String? _code, _idval, _username;

  int _step = 3;

  int currentYear = 1370;
  int currentMonth = 6;
  int currentDay = 15;

  bool _smsRecieved = false;
  bool get smsRecieved => _smsRecieved;

  var _emailController = TextEditingController();
  var _phoneController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  var _codeController = TextEditingController();
  var _nameController = TextEditingController();
  var _lnameController = TextEditingController();
  var _usernameController = TextEditingController();
  var _mailController = TextEditingController();
  //var _genderController = TextEditingController();
  var _nationalCodeController = TextEditingController();
  var _addressController = TextEditingController();
  var _dobController = TextEditingController();

  bool _isObsecure = true;
  bool get isObsecure => _isObsecure;

  TextEditingController get emailController => _emailController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get nationalCodeController => _nationalCodeController;
  TextEditingController get addressCodeController => _addressController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  TextEditingController get codeController => _codeController;
  TextEditingController get nameController => _nameController;
  TextEditingController get lnameController => _lnameController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get mailController => _mailController;

  String get emailErrorText => _emailErrorText!;
  String get passwordErrorText => _passwordErrorText!;
  String get confirmPasswordErrorText => _confirmPasswordErrorText!;
  String get codeErrorText => _codeErrorText!;
  String get nameErrorText => _nameErrorText!;
  String get lnameErrorText => _lnameErrorText!;
  String get usernameErrorText => _usernameErrorText!;
  String get mailErrorText => _mailErrorText!;
  String get nationalCodeErrorText => _nationalCodeErrorText!;
  String get idval => _idval!;
  String get code => _code!;
  int get genderValue => _genderValue!;
  int get getStep => _step;

  void setGenderVal(int val) {
    _genderValue = val;
    notifyListeners();
  }

  void setStep(int ss) {
    _step = ss;
    notifyListeners();
  }

  String get getCode => _code!;
  void setCode(String ss) {
    _code = ss;
    notifyListeners();
  }

  String get getUsername => _username!;
  void setUsername(String ss) {
    _username = ss;
    notifyListeners();
  }

  int getCurrentDay() {
    return currentDay;
  }

  void setCurrentDay(int day) {
    currentDay = day;
    notifyListeners();
  }

  int getCurrentMonth() {
    return currentMonth;
  }

  void setCurrentMonth(int month) {
    currentMonth = month;
    notifyListeners();
  }

  int getCurrentYear() {
    return currentYear;
  }

  void setCurrentYear(int year) {
    currentYear = year;
    notifyListeners();
  }

  FocusNode _codeFocusNode = FocusNode();
  FocusNode get codeFocusNode => _codeFocusNode;

  BoxDecoration get pinPutDecorationSubmitted {
    return BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(20.0),
    );
  }

  BoxDecoration get pinPutDecorationSelected {
    return BoxDecoration(
      // color: Colors.grey[300],
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all(
        color: colorPrimary,
        width: 1,
      ),
    );
  }

  BoxDecoration get pinPutDecorationFollowing {
    return BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(5.0),
    );
  }

  defaultPinTheme(myWidth) {
    final defaultPinTheme = PinTheme(
      margin: const EdgeInsets.all(2.0),
      constraints: BoxConstraints(maxWidth: (myWidth - 22 - 64) / 7),
      height: (myWidth - 22 - 64) / 7,
      // decoration: followingPinTheme.
    );
    return defaultPinTheme;
  }

  //TODO: should be remove- from another package pinput 2.1.4
  // final defaultPinTheme = PinTheme(
  //   margin: const EdgeInsets.all(2.0),
  //   constraints: BoxConstraints(maxWidth: (myWidth - 22 - 64) / 7),
  //   height: (myWidth - 22 - 64) / 7,
  //   // decoration: followingPinTheme.
  // );
  followingPinTheme(myWidth) {
    final followingPinTheme = defaultPinTheme(myWidth).copyWith(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
    return followingPinTheme;
  }

  submittedPinTheme(myWidth) {
    final submittedPinTheme = defaultPinTheme(myWidth).copyWith(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20.0),
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

  // SmsReceiver _receiver = SmsReceiver();
  // void listenToSMS() {
  //   print('listening to SMS');
  //   _receiver.onSmsReceived!.listen((SmsMessage msg) {
  //     onSmsReceived(msg.body!);
  //   });
  // }

  // PinFieldAutoFill _receiver = PinFieldAutoFill();
  // void 

  void onSmsReceived(String message) {
    print('message = $message');
    if (authServiceType == AuthServiceType.mock) {
      _smsRecieved = true;
      notifyListeners();
    } else {
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

        Future.delayed(Duration(seconds: 1), () {
          _codeController.text = code;
          notifyListeners();
        });
        // _codeController.text = code;
        // notifyListeners();
      } else {}
    }
  }

  bool signupOnClick(String pass, String confirmPass, String nationalCode) {
    // _emailErrorText = emailValidator(email);
    // _nationalCodeErrorText = nationalCodeValidator(nationalCode);
    // _passwordErrorText = passwordValidator(pass);
    // _confirmPasswordErrorText = confirmpasswordValidator(confirmPass, pass);
    // _usernameErrorText = usernameValidator(username);

    print(
        "$_emailErrorText $_passwordErrorText $_confirmPasswordErrorText $_usernameErrorText");
    notifyListeners();
    return (_emailErrorText == null &&
        _nationalCodeErrorText == null &&
        _confirmPasswordErrorText == null &&
        _usernameErrorText == null &&
        _passwordErrorText == null);
  }

  String? nationalCodeValidator(String value) {
    if (value.isEmpty) {
      _nationalCodeErrorText = 'کد ملی نمیتواند خالی باشد.';
      return _nationalCodeErrorText!;
    } else if (value.length < 10) {
      _nationalCodeErrorText =
          'ایمیل  یا شماره تلفن کمتر از 10 حرف نمی‌تواند باشد.';
      return _nationalCodeErrorText!;
    } else {
      return null;
    }
  }

  Future<bool> signup(String password, String confirmPassword, String cellphone,
      String nationalCode, BuildContext context, Key key) async {
    _smsRecieved = false;
    if (cellphone == null || cellphone.trim() == '') {
      showInfoFlushbar(context, "شماره تلفن نمی‌تواند خالی باشد!",
          "شماره تلفن نمی‌تواند خالی باشد!", false,
          durationSec: 2);
      notifyListeners();
      return false;
    }
    if (cellphone.length != 11) {
      showInfoFlushbar(context, "شماره تلفن اشتباه وارد شده است",
          "شماره تلفن اشتباه وارد شده است", false,
          durationSec: 2);
      notifyListeners();
      return false;
    }
    http.Response result;
    if (authServiceType == AuthServiceType.mock) {
      result = await MockWebservice()
          .registerFast(password, cellphone, nationalCode);
    } else {
      result =
          await Webservice().registerFast(password, cellphone, nationalCode);
    }
    print("resultttt $result");

    final bodyResponse = json.decode(result.body);
    int statusCode;

    statusCode = result.statusCode;

    print(statusCode);

    switch (statusCode) {
      case 403:
        showInfoFlushbar(context, "این کاربر قبلا ثبت نام کرده است!",
            "این کاربر قبلا ثبت نام کرده است!", false,
            durationSec: 2);
        notifyListeners();
        return false;
        break;
      case 200:
        // listenToSMS();
        _step = 2;
        notifyListeners();
        if (authServiceType == AuthServiceType.mock) {
          _codeFocusNode.requestFocus();
          Future.delayed(const Duration(seconds: 1), () {
            _smsRecieved = true;
            notifyListeners();
          });
        }
        return true;
        break;
      case 201:
        // listenToSMS();
        _step = 2;
        notifyListeners();
        if (authServiceType == AuthServiceType.mock) {
          _codeFocusNode.requestFocus();
          Future.delayed(Duration(seconds: 1), () {
            _smsRecieved = true;
            notifyListeners();
          });
        }

        return true;
        break;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "خطای ناشناخته!", false,
            durationSec: 2);
        notifyListeners();
        return false;
    }
  }

  Future<bool> signUpVerify(
      String number, String code, BuildContext context, Key key) async {
    http.Response result;
    if (authServiceType == AuthServiceType.mock) {
      result = await MockWebservice().verifyCodeFast(number, code);
    } else {
      result = await Webservice().verifyCodeFast(number, code);
    }
    print("signUpVerify ${result.body}");
    final bodyResponse = json.decode(result.body);
    int statusCode;

    statusCode = result.statusCode;

    print(statusCode);

    _smsRecieved = false;
    switch (statusCode) {
      case 404:
        showInfoFlushbar(context, "کد وارد شده صحیح نیست", " ", false,
            durationSec: 2);
        return false;
        break;
      case 200:
        String token;
        codeController.clear();
        token = bodyResponse["data"]["token"];

        if (token != null) {
          await sharedPreference.setToken(token);
          await sharedPreference
              .setUserId(bodyResponse["data"]["user"]["id"] ?? 0);
          await sharedPreference.setUserInfo(
              'null', 'null', 'null', 'null', number, 0, 0);
        } else {
          showInfoFlushbar(context, dialogErrorSTR, "خطای توکن", false,
              durationSec: 2);
          notifyListeners();
          return false;
        }
        clear();
        notifyListeners();
        return true;
        break;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "خطای ناشناخته", false,
            durationSec: 2);
        return false;
    }
  }

  Future<bool> signUpResendVerify(
      String phone, BuildContext context, Key key) async {
    var result;
    if (authServiceType == AuthServiceType.mock) {
      // result = await MockWebservice().resendVerifyCodeFast(phone);
    } else {
      result = await Webservice().resendVerifyCodeFast(phone);
    }
    print("signUpResendVerify $result");
    final bodyResponse = json.decode(result);
    String statusCode;
    try {
      statusCode = bodyResponse["status"];
    } catch (e) {
      statusCode = bodyResponse[0]["resend_verification_code"]["status"];
    }
    print(statusCode);
    switch (statusCode) {
      case "404":
        showInfoFlushbar(
            context, "این کاربر وجود ندارد", "این کاربر وجود ندارد", false,
            durationSec: 2);
        _step = 1;
        return false;
        break;
      case "200":
        try {
          _code = bodyResponse["data"]["Resended verification_code"];
        } catch (e) {
          _code = bodyResponse[0]["resend_verification_code"]["data"]
              ["Resended verification_code"];
        }

        _step = 2;
        // showInfoFlushbar(context, operationDone, "کد تایید: $_code", false,
        //     durationSec: 10);
        notifyListeners();
        return true;
        break;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "خطای ناشناخته!", false,
            durationSec: 2);
        return false;
    }
  }

  void decreaseStep() {
    _step--;
    notifyListeners();
  }

  void clear() {
    _step = 3;
    _phoneController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _nationalCodeController.clear();
  }

  onWillPop(BuildContext context) {
    // _step = 3;
    // notifyListeners();
    print("_step = $_step");
    if (_step == 2) {
      _step = 3;
      notifyListeners();
    } else {
      Navigator.of(context).pop();
    }
    return true;
  }
}
