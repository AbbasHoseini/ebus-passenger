import 'package:ebus/core/viewmodels/MainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setLogout(BuildContext mainContext) {
  MainViewModel mainViewModel =
      Provider.of<MainViewModel>(mainContext, listen: false);
  mainViewModel.isFirst = true;
  setLoggedInToFalse().then((commited) {
    Navigator.of(mainContext)
        .pushNamedAndRemoveUntil('/LoginView', (Route<dynamic> route) => false);
  });
}

Future<bool> setLoggedInToFalse() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('name', ' ');
  prefs.setString('lname', ' ');
  prefs.setString('mail', ' ');
  prefs.setString('token', ' ');
  prefs.setString('phone', ' ');
  prefs.setString('code', ' ');
  prefs.setString('status', ' ');

  prefs.setBool('isLoggedIn', false);
  return true;
}

Future<bool> getLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isLoggedIn =
      prefs.getBool('isLoggedIn') == null ? false : prefs.getBool('isLoggedIn');
  return isLoggedIn!;
}

Future<bool> setLoggedIn(String name, String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('name', name);
  prefs.setString('AccessToken', token);
  prefs.setBool('isLoggedIn', true);
  return true;
}

Future<String> getPhoneNumber() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? phone =
      prefs.getString('phone') == null ? ' ' : prefs.getString('phone');
  return phone!;
}

Future<bool> setToken(String token) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future<int> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? userId = prefs.getInt('userId') == null ? null : prefs.getInt('userId');
  return userId!;
}

Future<bool> setUserId(int id) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', id);
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? phone =
      prefs.getString('token') == null ? ' ' : prefs.getString('token');
  return phone!;
}

Future<bool> setUserInfo(String name, String lastName, String nationalCode,
    String userName, String phone, int gender, int credit) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('firstname', name);
    prefs.setString('lastname', lastName);
    prefs.setString('nationalcode', nationalCode);
    prefs.setString('username', userName);
    prefs.setInt('gender', gender);
    prefs.setInt('credit', credit);
    prefs.setString('phone', phone);
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future<List<String>> getUserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> userInfoList = <String>[];
  userInfoList.add(prefs.getString('firstname') ?? '');
  userInfoList.add(prefs.getString('lastname') ?? '');
  userInfoList.add(prefs.getString('nationalcode') ?? '');
  userInfoList.add((prefs.getInt('gender') ?? '').toString());
  userInfoList.add((prefs.getInt('credit')?? '').toString());
  userInfoList.add(prefs.getString('username') ?? '');
  userInfoList.add(prefs.getString('phone') ?? '');
  print("success in getUserInfo");
  print(
      "${userInfoList[0]} ${userInfoList[1]} ${userInfoList[2]} ${userInfoList[3]} ${userInfoList[4]} ${userInfoList[5]} asdvvvvv");
  return userInfoList;
}

Future<bool> setCityNames(String source, String destination) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("shdsss $source $destination");
    prefs.setString('source', source);
    prefs.setString('destination', destination);
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future<List<String>> getCityNames() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> cities = <String>[];
  String? temp =
      prefs.getString('source') == null ? ' ' : prefs.getString('source');
  cities.add(temp!);
  String? temp2 = prefs.getString('destination') == null
      ? ' '
      : prefs.getString('destination');
  cities.add(temp2!);
  print("shdsss2 ${temp} ${temp2}");
  return cities;
}

Future<bool> setTicketDate(String date) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ticketdate', date);
    return true;
  } on Exception catch (e) {
    return false;
  }
}

Future<String> getTicketDate() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? temp = prefs.getString('ticketdate') == null
      ? ' '
      : prefs.getString('ticketdate');

  return temp!;
}

Future<bool> getTwoWay() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isTwoWay =
      prefs.getBool('isTwoWay') == null ? false : prefs.getBool('isTwoWay');
  return isTwoWay!;
}

Future<bool> setTwoWay(bool way) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isTwoWay', way);
  return true;
}

Future<int> getQnty() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Object? qnt = prefs.getInt('quantity') == null ? false : prefs.getInt('quantity'); //TODO
  return qnt! as int;
}

Future<bool> setQnty(int q) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('quantity', q);
  } on Exception catch (e) {
    return false;
  }
  return true;
}

Future<int?> getTravelId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Object? travelId =
      prefs.getInt('travelId') == null ? false : prefs.getInt('travelId');
  return travelId as int;
}

Future<bool> setTravelId(int q) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('travelId', q);
  } on Exception catch (e) {
    return false;
  }
  return true;
}
