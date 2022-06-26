import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:ebus/core/models/Bus.dart';
import 'package:ebus/core/models/ResultArgs.dart';
import 'package:ebus/core/models/Seat.dart';
import 'package:ebus/core/models/TravelDetailsArgs.dart';
import 'package:ebus/core/services/MockWebservice.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:jalali_calendar/jalali_calendar.dart';
// import 'package:persian_date/persian_date.dart';
import 'package:provider/provider.dart';

import 'MainViewModel.dart';

class ResultViewModel with ChangeNotifier {
  final AuthServiceType? authServiceType;
  ResultViewModel({this.authServiceType});
  List<Bus> busList = <Bus>[];
  TravelDetailsArgs travelDetailsArgs = TravelDetailsArgs();
  bool _isSelectingComingTrip = false;
  bool _goingTripSelected = false;
  int? _goingDateIndex;
  int? _returnDateIndex;
  bool _isLoading = false;
  var formatter = NumberFormat('#,###');

  bool get isLoading => _isLoading;

  bool get goingTripSelected => _goingTripSelected;
  int get goingDateIndex => _goingDateIndex!;
  int get returnDateIndex => _returnDateIndex!;

  Future<bool> getNextPrevDay(ResultArgs resultArgs, bool next, String date,
      BuildContext context) async {
    print('next $next');
    List dateSplit = date.split('-');
    var resultDay = DateTime(int.parse(dateSplit[0]), int.parse(dateSplit[1]),
        int.parse(dateSplit[2]));
    if (!next && resultDay.isBefore(DateTime.now())) {
      showInfoFlushbar(context, "نمی‌توانید برای دیروز بلیط خریداری کنید!",
          "نمی‌توانید برای دیروز بلیط خریداری کنید!", false,
          durationSec: 2);
      return false;
    }
    if (next) {
      resultDay = resultDay.add(Duration(days: 1));
    } else {
      resultDay = resultDay.add(Duration(days: -1));
    }
    date = "$resultDay";
    date = date.substring(0, 10);

    String token = await getToken();

    int sCode = resultArgs.sourceCode!;
    int dCode = resultArgs.destinationCode!;

    var result;
    MainViewModel mainViewModel =
        Provider.of<MainViewModel>(context, listen: false);
    if (authServiceType == AuthServiceType.mock) {
      result = await MockWebservice().getSearchResult(token, sCode, dCode, date);
    } else {
      result = await Webservice().getSearchResult(
          token,
          sCode,
          dCode,
          date,
          mainViewModel.festivalSearch == null
              ? null
              : mainViewModel.festivalSearch!.festival!.id);
    }
    print("getSearchResult1 $date $result");

    final bodyResponse = json.decode(result.body);
    var statusCode;
    var data;

    statusCode = result.statusCode;
    data = bodyResponse["data"];
    print(statusCode);
    switch (statusCode) {
      case 404:
        showInfoFlushbar(context, dialogErrorSTR, "404", false, durationSec: 3);
        notifyListeners();
        return false;
        break;
      case 200:
        var dataList = data as List;
        if (dataList == null || dataList.length < 1) {
          next
              ? showInfoFlushbar(context, "سفری برای روز بعد وجود ندارد",
                  "سفری برای روز بعد وجود ندارد", false, durationSec: 2)
              : showInfoFlushbar(context, "سفری برای روز قبل وجود ندارد",
                  "سفری برای روز قبل وجود ندارد", false,
                  durationSec: 2);
          return false;
        }

        busList = dataList.map((item) => Bus.fromJson(item)).toList();
        print("busList length ${busList.length}");
        return true;
        break;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 3);
        notifyListeners();
        return false;
    }

    // switch (statusCode) {
    //   case "404":
    //
    //     showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
    //     notifyListeners();
    //     return false;
    //     break;
    //   case "200":
    //     var dataList = bodyResponse["Data"] as List ?? null;
    //
    //     if (dataList == null) {
    //       next
    //           ? showInfoFlushbar(context, dialogErrorSTR,
    //               "سفری برای روز بعد وجود ندارد", false, durationSec: 2)
    //           : showInfoFlushbar(context, dialogErrorSTR,
    //               "سفری برای روز قبل وجود ندارد", false,
    //               durationSec: 2);
    //       return false;
    //     }
    //     print('bus list string to json = $dataList');
    //     busList = dataList.map((item) => Bus.fromJson(item)).toList();
    //     print("busList length ${busList.length}");
    //     return true;
    //     break;
    //   default:
    //
    //     showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
    //     notifyListeners();
    //     return false;
    // }
  }

  Future<bool> reserveTicket(
      int sourceId, int destId, int travelId, BuildContext context) async {
    travelDetailsArgs.sourceId = sourceId;
    travelDetailsArgs.destinationId = destId;
    travelDetailsArgs.travelId = travelId;

    var result;
    if (authServiceType == AuthServiceType.mock) {
      result =
          await MockWebservice().getTravelDetails(travelId, sourceId, destId);
    } else {
      result = await Webservice().getTravelDetails(travelId, sourceId, destId);
    }
    print("reserveTicket $result");

    final bodyResponse = json.decode(result);
    String statusCode = bodyResponse["status"];
    print(statusCode);

    switch (statusCode) {
      case "404":
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        notifyListeners();
        return false;
        break;
      case "200":
        var data = bodyResponse["data"];
        if (data == null) {
          showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
          notifyListeners();
          return false;
        }

        travelDetailsArgs.sourceLat = data["township_details"][0]["source_lat"];
        travelDetailsArgs.sourceLong =
            data["township_details"][0]["source_lon"];
        travelDetailsArgs.destLat = data["township_details"][0]["dest_lat"];
        travelDetailsArgs.destLong = data["township_details"][0]["dest_lon"];
        travelDetailsArgs.sourceName =
            data["township_details"][0]["source_title"];
        travelDetailsArgs.destinationName =
            data["township_details"][0]["dest_title"];

        travelDetailsArgs.seatCount = data["car_details"]["seat_count"];
        travelDetailsArgs.rowCount =
            data["car_details"]["seat_row_count"];
        travelDetailsArgs.colCount =
            data["car_details"]["seat_column_count"];
        travelDetailsArgs.carTypeId =
            data["car_details"]["car_location_schema"][0]["car_type_id"] ?? 8;

        travelDetailsArgs.seatList = <Seat>[];
        var busSeats = data["car_details"]["car_location_schema"] as List;
        busSeats.forEach((item) {
          travelDetailsArgs.seatList!.add(Seat(
              gender: 0,
              name: "",
              familyName: "",
              nationalCode: "",
              available: item["car_location_type_id"] == 4 ? 1 : 0,
              carLocationTypeId: item["car_location_type_id"],
              colId: item["column_id"],
              rowId: item["row_id"],
              seatNumber: item["seat_number"]));
        });

        var fixedSeats = data["fixed_seats"] as List;

        int searchCounter = 0;
        if (fixedSeats != null)
          for (int i = 0; i < travelDetailsArgs.seatList!.length; i++) {
            if (searchCounter >= fixedSeats.length) break;
            fixedSeats.forEach((item) {
              if (travelDetailsArgs.seatList![i].seatNumber ==
                  item["seat_number"]) {
                searchCounter++;
                travelDetailsArgs.seatList![i].available = 0;
                travelDetailsArgs.seatList![i].gender = item["gender_id"];
              }
            });
          }

        notifyListeners();
        return true;
        break;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        notifyListeners();
        return false;
    }
  }

  ResultArgs? _resultArgs;

  ResultArgs get resultArgs => _resultArgs!;

  bool get isSelectingComingTrip => _isSelectingComingTrip;

  String setGregorianDate(String date) {
    print("setGregorianDate");
    print("_currentDateController test = $date");

    int currentYear = int.parse(convertNumbers(date.substring(0, 4)));

    int currentMonth = int.parse(convertNumbers(date.substring(5, 7)));

    int currentDay = int.parse(convertNumbers(date.substring(8, 10)));
    print("day = $currentDay");

    PersianDate persianDate = PersianDate();
    String month = "$currentMonth", day = "$currentDay";
    if (currentMonth.toString().length < 2) {
      month = "0$currentMonth";
    }
    if (currentDay.toString().length < 2) {
      day = "0$currentDay";
    }
    String dateString = "$currentYear-$month-$day 19:54";
    print('dateString = $dateString');
    // dateString = persianDate.jalaliToGregorian(dateString).toString();
    dateString = persianDate
        .jalaliToGregorian(currentYear, int.parse(month), int.parse(day))
        .toString();

    dateString = dateString.substring(0, 10);
    if (authServiceType == AuthServiceType.mock) {
      dateString = "2020-07-19"; //1399/04/29
    }
    return dateString;
  }

  String getComingDate(String date, bool next) {
    if (_isSelectingComingTrip) {
      var resultDay = DateTime.parse("$date 20:18:04Z");
      if (next) {
        resultDay = resultDay.add(Duration(days: 1));
      } else {
        resultDay = resultDay.add(Duration(days: -1));
      }
      date = "$resultDay";
      date = date.substring(0, 10);
      return date;
    }
    return date;
  }

  String getGoingDate(String date, bool next) {
    print('date = $date');
    if (!_isSelectingComingTrip) {
      var resultDay = DateTime(int.parse(date.split('-')[0]),
          int.parse(date.split('-')[1]), int.parse(date.split('-')[2]));
      if (next) {
        resultDay = resultDay.add(Duration(days: 1));
      } else {
        resultDay = resultDay.add(Duration(days: -1));
      }
      date = "$resultDay";
      date = date.substring(0, 10);
      return date;
    }
    return date;
  }

  void setResultArgs(ResultArgs resultArgs) {
    _resultArgs = resultArgs;
  }

  void goingDateSelected(int index) {
    _goingTripSelected = true;
    _goingDateIndex = index;
    notifyListeners();
  }

  void setreturnDateIndex(int index) {
    _returnDateIndex = index;
    print("return index  = $index");
    notifyListeners();
  }

  void clear() {
    _goingTripSelected = false;
    _resultArgs = null;
  }

  Future<bool> isRegisterCompleted() async {
    bool isComplete = false;
    var value = await getUserInfo();

    List<String> userInfo = value;
    if (userInfo[0] != 'null' &&
        userInfo[1] != 'null' &&
        userInfo[2] != 'null' &&
        userInfo[0] != '' &&
        userInfo[1] != '' &&
        userInfo[2] != '' &&
        userInfo[0] != null &&
        userInfo[1] != null &&
        userInfo[2] != null) {
      print('${userInfo[0]} ${userInfo[1]} && ${userInfo[2]} ');
      print('u can buy now');
      isComplete = true;
    } else {
      print('u cant buy ');
    }

    print('isComplete profile = $isComplete ');
    return isComplete;
  }

  goToProfile(BuildContext context) {
    Navigator.of(context).pushNamed('/ProfileView');
  }

  String getAppbarDate(String goingDate) {
    String shamsi = getShamsiDate(goingDate).toString();
    List<String> dateParameters = shamsi.split('-');
    String returnDate = dateParameters[02] +
        ' ' +
        getMonthName(int.parse(dateParameters[1])) +
        ' ' +
        dateParameters[0];
    print('returnDate = $returnDate');
    return returnDate;
  }

  String getNextDayString(String goingDate) {
    print('goingdate = $goingDate');
    DateTime date = DateTime(int.parse(goingDate.split('-')[0]),
        int.parse(goingDate.split('-')[1]), int.parse(goingDate.split('-')[2]));
    print('goingdate today = $date');
    date = date.add(Duration(days: 1));

    print('goingdate yesterday = $date');
    String shamsi = getShamsiDate(date.toString().substring(0, 10)).toString();
    List<String> dateParameters = shamsi.split('-');
    String returnDate = (int.parse(dateParameters[2])).toString() +
        ' ' +
        getMonthName(int.parse(dateParameters[1]));
    print('getNextDayString = $returnDate');

    return returnDate;
  }

  String getPreviousDayString(String goingDate) {
    print('goingdate = $goingDate');
    DateTime date = DateTime(int.parse(goingDate.split('-')[0]),
        int.parse(goingDate.split('-')[1]), int.parse(goingDate.split('-')[2]));
    print('goingdate today = $date');
    date = date.add(Duration(days: -1));

    print('goingdate yesterday = $date');
    String shamsi = getShamsiDate(date.toString().substring(0, 10)).toString();
    List<String> dateParameters = shamsi.split('-');
    String returnDate = (int.parse(dateParameters[2])).toString() +
        ' ' +
        getMonthName(int.parse(dateParameters[1]));
    print('getPreviousDayString = $returnDate');
    return returnDate;
  }
}
