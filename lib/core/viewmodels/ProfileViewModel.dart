import 'dart:convert';

import 'package:ebus/core/models/User.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart' as pref;
import 'package:flutter/material.dart';
import 'package:ebus/core/services/Webservice.dart';

class ProfileViewModel extends ChangeNotifier {
  bool _isLoaded = false;
  bool _isLoadedPassword = true;
  bool _isObsecureCurrent = true;
  bool _isObsecureNew = true;
  int _userGender = 1;
  var _currentPassController = TextEditingController();
  var _newPassController = TextEditingController();
  var _confirmPassController = TextEditingController();
  var _fistNameController = TextEditingController();
  var _lastNameController = TextEditingController();
  var _nationalCodeController = TextEditingController();
  var _emailController = TextEditingController();
  var _phoneController = TextEditingController();
  var _userNameController = TextEditingController();
  String? _currentPassErrorText, _newPassErrorText, _passconfirmErrorText, _userNameErrorText,
  _mobileErrorText, _emailErrorText, _nationalCodeErrorText;

  User _user = User();

  User get user => _user;
  bool get isLoaded => _isLoaded;
  bool get isLoadedPassword => _isLoadedPassword;
  bool get isObsecureCurrent => _isObsecureCurrent;
  bool get isObsecureNew => _isObsecureNew;
  int get userGender => _userGender;
  TextEditingController get currentPassController => _currentPassController;
  TextEditingController get newPassController => _newPassController;
  TextEditingController get confirmPassController => _confirmPassController;
  TextEditingController get fistNameController => _fistNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get nationalCodeController => _nationalCodeController;
  TextEditingController get emailController => _emailController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get userNameController => _userNameController;
  String get newPassErrorText => _newPassErrorText ?? '';
  String get passconfirmErrorText => _passconfirmErrorText ?? '';
  String get currentPassErrorText => _currentPassErrorText ?? '';
  String get userNameErrorText => _userNameErrorText ?? '';
  String get mobileErrorText => _mobileErrorText ?? '';
  String get emailErrorText => _emailErrorText ?? '';
  String get nationalCodeErrorText => _nationalCodeErrorText ?? '';

  toggleObsecureCurrent() {
    _isObsecureCurrent = !_isObsecureCurrent;
    notifyListeners();
  }

  toggleObsecureNew() {
    _isObsecureNew = !_isObsecureNew;
    notifyListeners();
  }

  toggleUserGender(value) {
    _userGender = value ? 1 : 0;
    print('_userGender = $_userGender');
    notifyListeners();
  }

  getUserGender(int gender) {
    _userGender = gender;

    notifyListeners();
    return _userGender;
  }

  getUserProfile(BuildContext context) async {
    print('getUserProfile getUserProfile getUserProfile getUserProfile');

    var token = await pref.getToken();
    print('token = $token');
    Webservice().getProfileData(token).then((response) {
      if (response != null) {
        var jr = jsonDecode(response.body);

        var status;
        var data;
        try {
          status = response.statusCode;
        } catch (e) {
          status = 401;
        }

        if (status == 200) {
          data = jr['data'];

          print('getuserprof data' + data.toString());
          var user = User.fromJson(data);
          print('getuserprof user is' + user.toString());

          _fistNameController.text = user.name ?? '';
          _lastNameController.text = user.lname ?? '';
          _nationalCodeController.text = user.nationalCode ?? '';
          _emailController.text = user.mail ?? '';
          _phoneController.text = user.phone!;
          _userNameController.text = user.userName ?? '';

          _user = user;
          _isLoaded = true;
          notifyListeners();
          return user;
        } else if (status == 401) {
          pref.setLogout(context);
        } else {
          print('status is not 200');
        }
      } else {
        print('error response null');
        return null;
      }
    });
    return null;
  }

  changePassword(BuildContext context) async {
    var token = await pref.getToken();
    var result = await Webservice().changeUserPasswordCall(
        token, currentPassController.text, newPassController.text);

    if (result != null) {
      var jr = jsonDecode(result);
      var status;

      status = jr['status'];

      if (status == 200 || status == 201) {
        _isLoadedPassword = true;
        showInfoFlushbar(context, 'عملیات با موفقیت انجام شد', '', false,
            durationSec: 2);

        _currentPassController.text = '';
        _newPassController.text = '';
        _confirmPassController.text = '';
        notifyListeners();
        // return user;
      } else if (status == 404) {
        _currentPassErrorText = "رمز فعلی نادرست است";
        setIsLoaded(true);

        showInfoFlushbar(context, status, 'رمز فعلی نادرست است', false,
            durationSec: 2);
        print('status is 404');
      } else {
        setIsLoaded(true);
        showInfoFlushbar(
            context, status, 'درخواست با مشکل مواجه شده است!', false,
            durationSec: 2);
        print('status is not 200');
      }
    } else {
      print('error response null');
      return null;
    }
  }

  validatePasswordAndConfirmPassword(BuildContext context) {
    print('currentPassController text = ${currentPassController.text}');
    if (currentPassController.text != '' &&
        currentPassController.text != null) {
      if (_newPassController.text != "") {
        _currentPassErrorText = null;
        if (confirmPassController.text == _newPassController.text) {
          _newPassErrorText = null;
          _passconfirmErrorText = null;
          setIsLoaded(false);

          //  _isLoadedPassword = false;
          changePassword(context);
        } else {
          print('confirmPassController text = ${confirmPassController.text}');
          print('newPassController text = ${newPassController.text}');

          _newPassErrorText = 'رمز عبور و تکرار آن یکسان نمی باشد';
          _passconfirmErrorText = 'رمز عبور و تکرار آن یکسان نمی باشد';
        }
      } else {
        _newPassErrorText = 'رمز جدید نمی تواند خالی باشد';
      }
    } else {
      _currentPassErrorText = 'رمز فعلی  نمی تواند خالی باشد';
    }
    notifyListeners();
  }

  setIsLoaded(bool value) {
    _isLoadedPassword = value;
    notifyListeners();
  }

  validateUpdateProfileInfo(BuildContext context) async {
    bool isEmailCorrect = isEmail(emailController.text);
    if (!isEmailCorrect && emailController.text.isNotEmpty) {
      showInfoFlushbar(
          context, "ایمیل را درست وارد کنید", 'ایمیل را درست وارد کنید', false,
          durationSec: 2);
      return;
    }
    if (nationalCodeController.text.isNotEmpty &&
        nationalCodeController.text.length != 10) {
      showInfoFlushbar(context, "کد ملی را درست وارد کنید",
          'کد ملی را درست وارد کنید', false,
          durationSec: 2);
      return;
    }
    if (userNameController.text.isNotEmpty &&
        userNameController.text.length < 3) {
      showInfoFlushbar(context, "نام کاربری نمی‌تواند کمتر از ۳ حرف باشد",
          'نام کاربری نمی‌تواند کمتر از ۳ حرف باشد', false,
          durationSec: 2);
      return;
    }

    var token = await pref.getToken();

    var user = User(
      name: fistNameController.text,
      mail: emailController.text,
      genderId: userGender,
      lname: lastNameController.text,
      nationalCode: nationalCodeController.text,
      phone: phoneController.text,
      userName: userNameController.text,
    );

    var result = await Webservice().changeProfileCall(token, user);

    if (result != null) {
      var jr = jsonDecode(result);
      var status;

      status = jr['status'];

      if (status == 200 || status == 201) {
        _isLoadedPassword = true;
        showInfoFlushbar(context, 'عملیات با موفقیت انجام شد', '', false,
            durationSec: 2);

        await pref.setUserInfo(user.name!, user.lname!, user.nationalCode!,
            user.userName!, user.phone!, user.genderId!, 0);

        notifyListeners();
        // return user;
      } else {
        _isLoadedPassword = true;
        showInfoFlushbar(
            context, status, 'درخواست با مشکل مواجه شده است!', false,
            durationSec: 2);
        print('status is not 200');
      }
    } else {
      print('error response null');
      return null;
    }
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }
}
