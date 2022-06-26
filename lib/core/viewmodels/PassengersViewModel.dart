import 'dart:convert';

import 'package:ebus/UI/widgets/DeletePassengerDialog.dart';
import 'package:ebus/core/models/PassengerArgs.dart';
import 'package:ebus/core/models/Seat.dart';
import 'package:ebus/core/services/MockWebservice.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PassengersViewModel with ChangeNotifier {
  final AuthServiceType? authServiceType;
  PassengersViewModel({this.authServiceType});
  List<PassengerArgs>? _passengerArgs;
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController nationalCodeController = TextEditingController();

  List<TextEditingController> nameControllerList =
      <TextEditingController>[];
  List<TextEditingController> lastNameControllerList =
      <TextEditingController>[];
  List<TextEditingController> nationalCodeControllerList =
      <TextEditingController>[];
  List<Widget>? listWidgets;
  List<Seat>? _selectedSeats;
  List<Seat>? _selectedSeatsReturn;
  List<Seat>? _selectedSeatsReturnDrpDown;
  bool _isTwoWay = false;
  List<PassengerArgs>? _selectedUsers;
  bool shouldInit = true;
  bool _loading = true;
  String sourceName = '', destName = '', date = 'تاریخ';

  List<Seat> get selectedSeatsReturnDrpDown => _selectedSeatsReturnDrpDown!;

  void setSelectedSeatsReturnDrpDown(List<Seat> value) {
    _selectedSeatsReturnDrpDown = value;
    notifyListeners();
  }

  bool get isTwoWay => _isTwoWay;

  set isTwoWay(bool value) {
    _isTwoWay = value;
    notifyListeners();
  }

  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<PassengerArgs> get selectedUsers => _selectedUsers!;

  set selectedUsers(List<PassengerArgs> value) {
    _selectedUsers = value;
    notifyListeners();
  }

  PassengerArgs? _selectedUser;

  PassengerArgs get selectedUser => _selectedUser!;

  set selectedUser(PassengerArgs value) {
    _selectedUser = value;
    notifyListeners();
  }

  List<Seat> get selectedSeats => _selectedSeats!;

  set selectedSeats(List<Seat> value) {
    _selectedSeats = value;
    notifyListeners();
  }

  List<Seat> get selectedSeatsReturn => _selectedSeatsReturn!;

  set selectedSeatsReturn(List<Seat> value) {
    _selectedSeatsReturn = value;
    notifyListeners();
  }

  List<PassengerArgs> get passengerArgs => _passengerArgs!;

  set passengerArgs(List<PassengerArgs> value) {
    _passengerArgs = value;
    notifyListeners();
  }

  initPassengersSeat(
      List<Seat>? list, List<Seat>? listReturn, BuildContext context) {
    List<PassengerArgs> passengersArgs = [];
    _passengerArgs = [];
    getCityNames().then((val) {
      sourceName = val[0];
      destName = val[1];
      notifyListeners();
    });
    getTicketDate().then((val) {
      date = val;
      notifyListeners();
    });
    getTwoWay().then((value) {
      _isTwoWay = value;
      notifyListeners();
    });
    getUserInfo().then((value) {
      print("values ::::::::::::::" + value.toString());
      List<String> userInfo = value;
      //userInfo.forEach((item) {});
      passengersArgs.add(PassengerArgs(
          id: 1,
          nationalCode: userInfo[2],
          name: userInfo[0],
          lastName: userInfo[1]));
      _passengerArgs = passengersArgs;
      _selectedUser = _passengerArgs![0];
      _selectedSeats = <Seat>[];
      _selectedUsers = <PassengerArgs>[];
      nationalCodeControllerList = [];
      lastNameControllerList = [];
      nameControllerList = [];
      if (list != null) {
        for (Seat item in list) {
          print("itemmm ${item.gender} ${item.available} ${item.index}");
          if (item.available == 2) {
            _selectedSeats!.add(item);
            _selectedUsers!.add(_passengerArgs![0]);
            print("asdas.length ${_selectedSeats!.length}");
            nameControllerList.add(TextEditingController());
            lastNameControllerList.add(TextEditingController());
            nationalCodeControllerList.add(TextEditingController());
          }
        }
      }
      if (listReturn != null && isTwoWay) {
        _selectedSeatsReturn = <Seat>[];
        for (Seat item in listReturn) {
          print("_selectedSeatsReturn123");
          print("itemmm ${item.gender} ${item.available} ${item.index}");
          if (item.available == 2) {
            _selectedSeatsReturn!.add(item);
          }
        }
        _selectedSeatsReturnDrpDown = _selectedSeatsReturn;
      }
      notifyListeners();
    });
    getFavePassengers(context).then((val) {
      _loading = false;
      notifyListeners();
    });
    shouldInit = false;
  }

  List<Widget> passengerList(List<PassengerArgs> list, BuildContext context) {
    _passengerArgs = list;
    print("lengthOfList: ${list.length}");
    List<Widget> widgetList = <Widget>[];
    for (PassengerArgs item in _passengerArgs!) {
      widgetList.add(Flexible(
        child: FlatButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                item.name,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: colorTextTitle,
                    fontSize: textFontSizeTitle,
                    fontFamily: 'Sans'),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                item.nationalCode.toString(),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: colorTextTitle,
                    fontSize: textFontSizeTitle,
                    fontFamily: 'Sans'),
              ),
            ],
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => DeletePassengerDialog(
                      id: item.id,
                    ));
            print("id part0 ${item.id.toString()}");
          },
        ),
      ));
      widgetList.add(Divider());
    }
    listWidgets = <Widget>[];
    listWidgets = widgetList;
    //notifyListeners();
    return widgetList;
  }

  Future<bool> deletePassenger(int id, BuildContext context) async {
    int? index;
    for (int i = 0; i < _passengerArgs!.length; i++) {
      if (_passengerArgs![i].id == id) {
        index = i;
      }
    }
    String token = await getToken();
    http.Response result;
    if (authServiceType == AuthServiceType.mock) {
      result = await MockWebservice()
          .removePassengersOfFaveList(token, _passengerArgs![index!].id);
    } else {
      result = await Webservice()
          .removePassengersOfFaveList(token, _passengerArgs![index!].id);
    }

    final bodyResponse =
        json.decode(result.body); //[0]["delete_favorite_passengers"];
    int statusCode = bodyResponse["Status"] ?? result.statusCode;
    print(statusCode);

    switch (statusCode) {
      case 404:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        notifyListeners();
        return false;
        break;
      case 200:
        //var dataList = bodyResponse["data"] as List;
        _passengerArgs!.removeAt(index);
        notifyListeners();
        return true;
        break;
      default:
        showInfoFlushbar(context, 'این کاربر قابل حذف نیست', "", false,
            durationSec: 2);
        notifyListeners();
        return false;
    }
  }

  Future<bool> getPassengersFaveList(BuildContext context) async {
    String token = await getToken();
    List<PassengerArgs> passengersArgs = <PassengerArgs>[];
    http.Response result;
    if (authServiceType == AuthServiceType.mock) {
      result = await MockWebservice().getPassengersOfFaveList();
    } else {
      result = await Webservice().getPassengersOfFaveList();
    }

    final bodyResponse = json.decode(result.body);
    int statusCode = bodyResponse["Status"] ?? result.statusCode;
    print(statusCode);

    switch (statusCode) {
      case 404:
        //unauthorized
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        notifyListeners();
        return false;
        break;
      case 200:
        var dataList = bodyResponse["Data"] as List;
        for (int i = 0; i < dataList.length; i++) {
          passengersArgs.add(PassengerArgs(
              id: dataList[i]["id"],
              nationalCode: dataList[i]["passengerFirstNationalCode"],
              name: dataList[i]["passengerFirstName"],
              lastName: dataList[i]["passengerLastName"]));
        }
        _passengerArgs = _passengerArgs! + passengersArgs;
        //notifyListeners();
        return true;
        break;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        //notifyListeners();
        return false;
    }
  }

  initFavePassengers(BuildContext context) {
    getPassengersFaveList(context).then((item) {
      notifyListeners();
    });
  }

  Future<bool> addPassenger(BuildContext context) async {
    bool addable = true;
    if (nationalCodeController.text.toString().length < 10) {
      showInfoFlushbar(context, "کد ملی را درست وارد نمایید",
          "کد ملی را درست وارد نمایید", false,
          durationSec: 2);
      return false;
    }
    if (nameController.text.toString().length < 1 ||
        lastNameController.text.toString().length < 1) {
      showInfoFlushbar(context, "اطلاعات را کامل وارد نمایید",
          "اطلاعات را کامل وارد نمایید", false,
          durationSec: 2);
      return false;
    }
    print("old ${_passengerArgs!.length}");
    for (int i = 0; i < _passengerArgs!.length; i++) {
      print("_passengerArgs is -- ${_passengerArgs.toString()}");

      if (_passengerArgs![i].nationalCode.toString() ==
          nationalCodeController.text.toString()) {
        addable = false;
      }
    }
    if (!addable) {
      showInfoFlushbar(
          context, "این کاربر وجود دارد", "این کاربر وجود دارد", false,
          durationSec: 2);
      return false;
    }

    String token = await getToken();

    http.Response result;
    if (authServiceType == AuthServiceType.mock) {
      result = await MockWebservice().addPassengersToFaveList(
          token,
          nameController.text.toString(),
          lastNameController.text.toString(),
          nationalCodeController.text.toString());
    } else {
      result = await Webservice().addPassengersToFaveList(
          token,
          nameController.text.toString(),
          lastNameController.text.toString(),
          nationalCodeController.text.toString());
    }

    final bodyResponse = json.decode(result.body);
    int statusCode = result.statusCode;
    print('addPassengersToFaveList response = ${bodyResponse} ');

    switch (statusCode) {
      case 403:
        Navigator.of(context).pop();
        showInfoFlushbar(
            context, "این کاربر وجود دارد.", "این کاربر وجود دارد.", false,
            durationSec: 2);
        notifyListeners();
        return false;
        break;
      case 201:

        // _passengerArgs.add(PassengerArgs(
        //     name: nameController.text.toString(),
        //     nationalCode: nationalCodeController.text,
        //     id: int.parse(nationalCodeController.text)));
        // print("new ${_passengerArgs.length}");
        notifyListeners();
        nameController.clear();
        lastNameController.clear();
        nationalCodeController.clear();
        initPassengersSeat(null, null, context);
        Navigator.of(context).pop();
        return true;
        break;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        notifyListeners();
        Navigator.of(context).pop();
        return false;
    }
  }

  void setSelectedSeatByIndex(PassengerArgs newValue, int index) {
    _selectedSeats![index].name = newValue.name;
    _selectedSeats![index].familyName = newValue.lastName;
    _selectedSeats![index].nationalCode = newValue.nationalCode;
    _selectedUser = newValue;
    _selectedUsers![index] = newValue;
    //new part
    nameControllerList[index].text = newValue.name;
    lastNameControllerList[index].text = newValue.lastName;
    nationalCodeControllerList[index].text = newValue.nationalCode;

    notifyListeners();
  }

  void setSelectedSeatReturnByIndex(Seat newValue, int index) {
    _selectedSeatsReturnDrpDown![index].seatNumber = newValue.seatNumber;
    print("index $index");
    _selectedSeatsReturnDrpDown!.forEach((element) {
      print("drp ${element.seatNumber}");
    });
    _selectedSeatsReturn!.forEach((element) {
      print("main ${element.seatNumber}");
    });
    notifyListeners();
  }

  Future<bool> getFavePassengers(BuildContext context) async {
    http.Response result;
    try {
      if (authServiceType == AuthServiceType.mock) {
        result = await MockWebservice().getPassengersOfFaveList();
      } else {
        result = await Webservice().getPassengersOfFaveList();
      }
    } on Exception catch (e) {
      showInfoFlushbar(context, dialogErrorSTR, "خطای سرور", false,
          durationSec: 2);
      return false;
    }

    print('getFavePassengers = ${result.body}');

    final bodyResponse = json.decode(result.body);
    int statusCode = bodyResponse["Status"] ?? result.statusCode;

    switch (statusCode) {
      case 403:
        Navigator.of(context).pop();
        showInfoFlushbar(
            context, "این کاربر وجود دارد.", "این کاربر وجود دارد.", false,
            durationSec: 2);
        notifyListeners();
        return false;
        break;
      case 200:
        print('getFavePassengers status = 200');
        if (_passengerArgs == null || _passengerArgs!.length < 1) {
          print('getFavePassengers _passengerArgs is empty');
          _passengerArgs = <PassengerArgs>[];
        }
        var list = bodyResponse["data"] as List;
        if (list == null) {
          notifyListeners();
          return false;
        }

        list.forEach((val) {
          _passengerArgs!.add(PassengerArgs(
              name: val["passengerFirstName"] ?? '',
              lastName: val["passengerLastName"] ?? '',
              nationalCode: val["passengerNationalCode"] ?? '',
              id: val["id"]));
        });
        notifyListeners();
        return true;
        break;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        notifyListeners();
        return false;
    }
  }

  Future<bool> setSelectedSeats(BuildContext context) async {
    for (int i = 0; i < _selectedSeats!.length; i++) {
      if (nationalCodeControllerList[i].text.isEmpty ||
          nationalCodeControllerList[i].text.length != 10) {
        showInfoFlushbar(context, "کد ملی مسافر معتبر نیست!",
            "کد ملی مسافر معتبر نیست!", false,
            durationSec: 2);
        return false;
      }
      if (nameControllerList[i].text.isEmpty ||
          lastNameControllerList[i].text.isEmpty) {
        showInfoFlushbar(context, "اطلاعات مسافر را وارد کنید!",
            "اطلاعات مسافر را وارد کنید!", false,
            durationSec: 2);
        return false;
      }
      _selectedSeats![i].name = nameControllerList[i].text;
      _selectedSeats![i].familyName = lastNameControllerList[i].text;
      _selectedSeats![i].nationalCode = nationalCodeControllerList[i].text;
    }
    return true;
  }

  bool checkSelectedSeatsReturn(BuildContext context) {
    int checkCounter = 0;
    for (int i = 0; i < _selectedSeatsReturn!.length; i++) {
      checkCounter = 0;
      for (int j = 0; j < _selectedSeatsReturn!.length; j++) {
        if (_selectedSeatsReturn![i].seatNumber ==
            _selectedSeatsReturn![j].seatNumber) {
          checkCounter++;
        }
      }
      if (checkCounter > 1) {
        showInfoFlushbar(context, "صندلی های برگشت تکرای اند!",
            "صندلی های برگشت تکرای اند!", false,
            durationSec: 2);
        return false;
      }
    }
    return true;
  }

  bool isAllUnique() {
    for (var i = 0; i < nationalCodeControllerList.length; i++) {
      for (var j = i + 1; j < nationalCodeControllerList.length; j++) {
        if (nationalCodeControllerList[i].text ==
            nationalCodeControllerList[j].text) {
          print(
              "duplicate = ${nationalCodeControllerList[i].text} = ${nationalCodeControllerList[j].text}");
          return false;
        }
      }
    }
    return true;
  }

  bool isAllFilled() {
    print('national length = ${nationalCodeControllerList.length}');
    for (var i = 0; i < nationalCodeControllerList.length; i++) {
      print('national code = ${nationalCodeControllerList[i].text}');
      if (nationalCodeControllerList[i].text == null ||
          nationalCodeControllerList[i].text.trim() == '') {
        return false;
      }
    }
    return true;
  }
}
