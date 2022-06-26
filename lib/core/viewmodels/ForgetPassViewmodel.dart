import 'dart:convert';

import '../../core/services/MockWebservice.dart';
import '../../core/services/Webservice.dart';
import '../../helpers/Constants.dart';
import '../../helpers/HelperFunctions.dart';
import 'package:flutter/material.dart';

class ForgetPassViewmodel with ChangeNotifier {
  final AuthServiceType? authServiceType;
  ForgetPassViewmodel({this.authServiceType});
  var _webService;

  String? _phone;
  bool _isLoaded = true;
  int _step = 0;
  String? _verificationCode;
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _newPassController = TextEditingController();
  TextEditingController _confirmNewPassController = TextEditingController();
  TextEditingController _verificationController = TextEditingController();

  TextEditingController get mobileController => _mobileController;
  TextEditingController get newPassController => _newPassController;
  TextEditingController get verificationController => _verificationController;
  TextEditingController get confirmNewPassController =>
      _confirmNewPassController;

  bool get isLoaded => _isLoaded;
  String get phone => _phone!;
  String get verificationCode => _verificationCode!;
  int get step => _step;

  void nextStep(BuildContext context) {
    _webService = authServiceType == AuthServiceType.real
        ? Webservice()
        : MockWebservice();
    if (_step == 0) {
      if (_mobileController.text != null && _mobileController.text != '') {
        _webService
            .postMobileForgetPass(_mobileController.text)
            .then((response) {
          bool result = mapPostMobileForgetPass(response);
          if (!result) {
            showInfoFlushbar(
                context, 'کاربر با این تلفن همراه یافت نشد', ' ', false,
                durationSec: 3);
          }
        });
      } else {
        showInfoFlushbar(
            context, 'لطفا شماره موبایل خود را وارد نمایید', ' ', false,
            durationSec: 3);
      }
    } else if (_step == 1) {
      if (_verificationController.text != null &&
          _verificationController.text != '') {
        _webService
            .postVerificationCodeForgetPass(
                _verificationController.text, mobileController.text)
            .then((response) {
          bool result = mapPostVerificationCodeForgetPass(response);
          if (!result) {
            showInfoFlushbar(context, 'کد وارد شده صحیح نیست', ' ', false,
                durationSec: 3);
          }
        });
      } else {
        showInfoFlushbar(context, 'لطفا کد تأیید را وارد نمایید', ' ', false,
            durationSec: 3);
      }
    } else if (_step == 2) {
      if (_newPassController.text != null &&
          _newPassController.text != '' &&
          _confirmNewPassController.text != null &&
          _confirmNewPassController.text != '') {
        if (_newPassController.text == _confirmNewPassController.text) {
          _webService
              .postNewPasswordForgetPass(
                  _newPassController.text, mobileController.text)
              .then((response) {
            bool result = mapPostNewPasswordForgetPass(response);
            if (!result) {
              showInfoFlushbar(context, 'خطا در ارتباط با سرور', ' ', false,
                  durationSec: 3);
            } else {
              Navigator.pushReplacementNamed(context, '/LoginView');
            }
          });
        } else {
          showInfoFlushbar(
              context, 'رمز عبور و تکرار آن یکسان نیستند', ' ', false,
              durationSec: 3);
        }
      } else {
        showInfoFlushbar(
            context, 'لطفا رمز عبور جدید و تکرار آن را وارد نمایید', ' ', false,
            durationSec: 3);
      }
    } else {}
  }

  void previousStep() {
    _step--;
    notifyListeners();
  }

  bool mapPostMobileForgetPass(String response) {
    var jr = jsonDecode(response);
    var data;
    var status;
    try {
      data = jr[0]['forget_password_request_passenger']['data'];
      status = jr[0]['forget_password_request_passenger']['status'];
    } catch (e) {
      data = jr['data'];
      status = jr['status'];
    }

    if (status == '200' || status == '201') {
      _verificationCode = data['verification_code'];
      print('verification code = $_verificationCode');
      //_verificationController.text = _verificationCode;
      _step++;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool mapPostVerificationCodeForgetPass(String response) {
    var jr = jsonDecode(response);
    var data;
    var status;
    try {
      data =
          jr[0]['verify_forget_password_verification_code_passenger']['data'];
      status =
          jr[0]['verify_forget_password_verification_code_passenger']['status'];
    } catch (e) {
      data = jr['data'];
      status = jr['status'];
    }

    if (status == '200' || status == '201') {
      _step++;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool mapPostNewPasswordForgetPass(String response) {
    var jr = jsonDecode(response);
    var data;
    var status;
    try {
      data = jr[0]['update_driver_password_passenger']['data'];
      status = jr[0]['update_driver_password_passenger']['status'];
    } catch (e) {
      data = jr[0]['update_driver_password_passenger']['data'];
      status = jr[0]['update_driver_password_passenger']['status'];
    }

    if (status == '200' || status == '201') {
      _step = 0;
      _mobileController.text = '';
      _confirmNewPassController.text = '';
      _newPassController.text = '';
      _verificationController.text = '';

      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void setStep(int val) {
    _step=val;
    notifyListeners();
  }
}
