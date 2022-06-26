// import 'package:flushbar/flushbar.dart';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jalali_calendar/jalali_calendar.dart';
// import 'package:persian_date/persian_date.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'Constants.dart';

void showInfoFlushbar(
    BuildContext context, String title, String message, bool showOpenButton,
    {int? durationSec, String? filePath, Function? function}) {
  if (showOpenButton) {
    Flushbar(
      mainButton: showOpenButton
          ? InkWell(
              onTap: () => function!(context),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12, blurRadius: 5, spreadRadius: 1)
                    ]),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                margin: EdgeInsets.only(right: 8),
                child: Text('بروز رسانی پروفایل'),
              ),
            )
          : Container(),
      backgroundColor: colorPrimary,
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('$title',
              textDirection: TextDirection.rtl,
              style:
                  TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
          Text(
            '$message',
            textDirection: TextDirection.rtl,
            style: TextStyle(color: Colors.white),
            softWrap: true,
          ),
        ],
      ),
      duration: Duration(seconds: durationSec ?? 1),
    ).show(context);
  } else {
    EasyLoading.showInfo(title);
  }
}

void showInSnackBar(BuildContext context, String snackMessage,
    GlobalKey<ScaffoldState> _scaffoldKey) {
  FocusScope.of(context).requestFocus(FocusNode());
  _scaffoldKey.currentState?.removeCurrentSnackBar();
  _scaffoldKey.currentState!.showSnackBar(SnackBar(
    content: Text(
      snackMessage,
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        /*fontFamily: "WorkSansSemiBold"*/
      ),
    ),
    backgroundColor: colorAccent,
    duration: Duration(seconds: 3),
  ));
}

String convertNumbers(String str) {
  str = str.replaceAll('۱', '1');
  str = str.replaceAll('۲', '2');
  str = str.replaceAll('۳', '3');
  str = str.replaceAll('۴', '4');
  str = str.replaceAll('۵', '5');
  str = str.replaceAll('۶', '6');
  str = str.replaceAll('۷', '7');
  str = str.replaceAll('۸', '8');
  str = str.replaceAll('۹', '9');
  str = str.replaceAll('۰', '0');
  return str;
}

String getGeorgianDate(int shDay, int shMonth, int shYear) {
  String miladiDate;
  PersianDate persianDate = PersianDate();
  String month = "$shMonth", day = "$shDay";
  if (shMonth.toString().length < 2) {
    month = "0$shMonth";
  }
  if (shDay.toString().length < 2) {
    day = "0$shDay";
  }
  miladiDate = "$shYear-$month-$day 19:54";
  print(
      "${shYear.toString().length} ${shMonth.toString().length} ${shDay.toString().length}");
  // miladiDate = persianDate.jalaliToGregorian(miladiDate).toString();
  miladiDate = persianDate
      .jalaliToGregorian(shYear, int.parse(month), int.parse(day))
      .toString();
  miladiDate = miladiDate.substring(0, 10);
  //todo clean temp date, it's for test
  //miladiDate = "2020-05-09";
  print("miladi date = $miladiDate");

  return miladiDate;
}

String getShamsiDate(String date) {
  if (date == null || date == '' || date == '0' || date == '0000-00-00')
    return '';
  print(date);
  PersianDate persianDate = PersianDate();
  // print('--------------------->');
  // print('persianDate is = ${persianDate.getNow.toString()}');
  var tempDate = date.split('-');

  var tempp = persianDate
      // .gregorianToJalali("${date}T00:19:54.000Z")
      .gregorianToJalali(int.parse(tempDate[0]), int.parse(tempDate[1]),
          int.parse(tempDate[2]), '-')
      .toString();
  // .substring(0, 10);
  // print('persianDate is converted = $tempp');

  return tempp;
}

String convertTojalali(String dateTimeGregorian) {
  // print('caonverted dateTimeGregorian date = $dateTimeGregorian');

  var convertedNumber = convertNumbers(dateTimeGregorian);
  print('caonverted dateTimeGregorian date = $convertedNumber');
  var dateGregorian = dateTimeGregorian.substring(0, 10).split('-');
  // var dateGregorian = convertedNumber.split('/');
  // var dateGregorian = dateTimeGregorian.split('-');
  // print(
  //     'converting date = ${dateGregorian.first}');
  // print(
  //     'converting date = ${dateGregorian[0].toString()} - ${dateGregorian[1].toString()} -${dateGregorian[2].toString()}');

  // print('year = ${int.parse(dateGregorian[0])}');
  // print('month = ${int.parse(dateGregorian[1])}');
  // print('day = ${int.parse(dateGregorian[2])}');
  Gregorian g = Gregorian(int.parse(dateGregorian[0]),
      int.parse(dateGregorian[1]), int.parse(dateGregorian[2]));
  // print('g = $g');

  Jalali g2j1 = g.toJalali();
  // print('g2j1 = $g2j1');

  // print('caonverted kazem g2j1 date = ${g2j1.toString()}');
  // print('caonverted kazem g2j1 date = ${g2j1.year}/${g2j1.month}/${g2j1.day}');
  var jalaliDate = '${g2j1.year}/${g2j1.month}/${g2j1.day}';

  // var convertingtime = dateTimeGregorian.replaceAll(' ', 'T');
  // var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(convertingtime, true);
  // var dateLocal = dateTime.toLocal();
  // var jalalitime = '${dateTimeGregorian.substring(11, 19)}';
  // var jalalitime = '${dateTimeGregorian.substring(11, 19)}';
  // print(
  //     'jalalitimejalalitimejalalitimejalalitimejalalitimejalalitimejalalitimejalalitime = $jalaliDate');
  return jalaliDate;
  // return dateLocal.toString().substring(11,19);
  // return [dateLocal.toString().substring(11, 19), jalaliDate];
}

String convertDateTimeToJalali(DateTime date) {
  Gregorian g = Gregorian(date.year, date.month, date.day);
  Jalali g2j1 = g.toJalali();
  return '${g2j1.year}/${g2j1.month}/${g2j1.day} - ${date.hour}:${date.minute}';
}

DateTime convertToDateTime(String date) {
  var dateGregorian = date.substring(0, 10).split('-');
  return DateTime(int.parse(dateGregorian[0]), int.parse(dateGregorian[1]),
      int.parse(dateGregorian[2]));
}

DateTime convertToDateWithTime(String date) {
  var dateGregorian = date.substring(0, 10).split('-');
  String time = date.split('T')[1];
  time = time.substring(0, 8);
  var timeGregorian = time.split(':');
  print("timeGregorian $time");
  return DateTime(
    int.parse(dateGregorian[0]),
    int.parse(dateGregorian[1]),
    int.parse(dateGregorian[2]),
    int.parse(timeGregorian[0]),
    int.parse(timeGregorian[1]),
    int.parse(timeGregorian[2]),
  );
}

int getDays(String startDate, String endDate) {
  var convertedNumberStart = convertNumbers(startDate);
  var convertedNumberEnd = convertNumbers(endDate);

  var stringGregorianStart = convertedNumberStart.substring(0, 10).split('-');
  var stringGregorianEnd = convertedNumberEnd.substring(0, 10).split('-');

  // Gregorian dateGregorianStart = Gregorian(int.parse(stringGregorianStart[0]),
  //     int.parse(stringGregorianStart[1]), int.parse(stringGregorianStart[2]));
  // Gregorian dateGregorianEnd = Gregorian(int.parse(stringGregorianEnd[0]),
  //     int.parse(stringGregorianEnd[1]), int.parse(stringGregorianEnd[2]));

  DateTime startDateTime = DateTime(int.parse(stringGregorianStart[0]),
      int.parse(stringGregorianStart[1]), int.parse(stringGregorianStart[2]));
  DateTime endDateTime = DateTime(int.parse(stringGregorianEnd[0]),
      int.parse(stringGregorianEnd[1]), int.parse(stringGregorianEnd[2]));

  int days = endDateTime.difference(startDateTime).inDays;

  return days;
}

String getMonthName(int monthInt) {
  switch (monthInt) {
    case 1:
      return 'فروردین';
      break;
    case 2:
      return 'اردیبهشت';
      break;
    case 3:
      return 'خرداد';
      break;
    case 4:
      return 'تیر';
      break;
    case 5:
      return 'مرداد';
      break;
    case 6:
      return 'شهریور';
      break;
    case 7:
      return 'مهر';
      break;
    case 8:
      return 'آبان';
      break;
    case 9:
      return 'آذر';
      break;
    case 10:
      return 'دی';
      break;
    case 11:
      return 'بهمن';
      break;
    case 12:
      return 'اسفند';
      break;
    default:
      return 'فروردین';
      break;
  }
}
