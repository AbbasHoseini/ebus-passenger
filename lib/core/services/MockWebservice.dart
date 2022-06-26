import 'dart:convert';
import 'package:ebus/core/models/Seat.dart';
import 'package:ebus/core/models/User.dart';
import 'package:ebus/core/services/MockResponses.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:flutter/material.dart';
// import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:http/http.dart' as http;

class MockWebservice {
  final Duration startupTime = Duration(milliseconds: 500);
  final Duration responseTime = Duration(milliseconds: 500);
  String currentUsername = '1', currentPassword = '123';
  String currentMobile = '09190591094';
  String correctCode = '123456';
  String wrongCode = '123457';

  Future<void> delay(Duration duration) async {
    await Future<void>.delayed(duration);
  }

  Future<http.Response> loginWithMobile(String mobile) async {
    print('mocking login');
    await delay(responseTime);
    if (mobile == currentMobile) {
      return correctMobileLoginResponse;
    } else {
      return wrongMobileLoginResponse;
    }
  }

  Future<http.Response> singInFast(String mobile, String verifyCode) async {
    print('mocking login');
    await delay(responseTime);
    if (verifyCode == correctCode) {
      return correctSignInFastResponse;
    } else {
      return wrongSignInFastResponse;
    }
  }

  Future<http.Response> registerFast(
      String password, String cellphone, String nationalCode) async {
    await delay(responseTime);

    var response;
    if (currentMobile == cellphone) {
      //user exists
      response = wrongSignUpResponse;
    } else {
      response = correctSignUpResponse;
    }

    return response;
  }

  Future<http.Response> verifyCodeFast(String number, String sentCode) async {
    await delay(responseTime);

    http.Response response;
    if (correctCode == sentCode) {
      //user exists
      response = correctUserVerificationResponse;
    } else {
      response = wrongUserVerificationResponse;
    }

    return response;
  }

  Future<http.Response> getAllTownShip() async {
    await delay(responseTime);

    http.Response response = correctAllTownShipResponse;
    return response;
  }

  Future<http.Response> getUserCurrentTravel([bool? isFirst]) async {
    await delay(responseTime);

    http.Response response;
    if (isFirst ?? true) {
      response = noCurrentTravelResponse;
    } else {
      response = currentTravelResponse;
    }

    return response;
  }

  Future<http.Response> getSearchResult(
      String token, sourceId, destinationId, String date) async {
    await delay(responseTime);
    http.Response response;
    print('date mock = $date');
    if (date == '2020-07-19') {
      response = correctSearchResultResponse;
    } else {
      response = noTravelsSearchResultResponse;
    }

    return response;
  }

  Future<http.Response> getTravelDetails(
      int travelId, int sourceId, int destinationId) async {
    await delay(responseTime);

    http.Response response = correctTravelDetailsResponse;
    return response;
  }

  Future<http.Response> getTravelTicketInvoice(
      int ticketId, ticketIdReturn, String voucherCode) async {
    await delay(responseTime);

    if (ticketId == 350) {
      return correctTravelTicketInvoiceResponse;
    } else {
      return wrongTravelTicketInvoiceResponse;
    }
  }

  Future<http.Response> getPayByCreditResult() async {
    await delay(responseTime);

    return correctPayByCreditResultResponse;
  }

  Future<http.Response> getPassengersOfFaveList() async {
    await delay(responseTime);

    return correctPassengersOfFaveListResponse;
  }

  Future<http.Response> getTravelTicketId(int travelId, int sourceId,
      int destinationId, List<Seat> seatList) async {
    await delay(responseTime);
    for (var item in seatList) {
      if (item.seatNumber == 11) {
        return wrongTravelTicketIdResponse;
      }
    }
    return correctTravelTicketIdResponse;
  }

  Future<http.Response> addPassengersToFaveList(
      String token, sourceId, destinationId, String date) async {
    await delay(responseTime);
    return correctAddPassengersToFaveListResponse;
  }

  Future<http.Response> removePassengersOfFaveList(String token, int id) async {
    await delay(responseTime);
    return correctRemovePassengersOfFaveListResponse;
  }

  Future<String> getTravelsHistoryResult(String token) async {
    await delay(responseTime);

    var response = correctTravelsHistoryResultResponse;
    return response;
  }

  Future<http.Response> getTransactionsHistoryResult(String token) async {
    await delay(responseTime);

    var response = correctTransactionsHistoryResultResponse;
    return http.Response(response, 200);
  }

  Future<String> getReportItemTitles(String token) async {
    await delay(responseTime);

    var response = correctReportItemTitlesResponse;
    return response;
  }

  Future<http.Response> submitReport(
      String token, String description, int travelId, int supportItemId) async {
    await delay(responseTime);

    String response = correctSubmitReportResponse;
    return http.Response(response, 200);
  }

  Future<String> getUserStatics(String token) async {
    await delay(responseTime);

    var response = correctUserStaticsResponse;
    return response;
  }

  Future<http.Response> getTicketsInfo(
      String token, int ticketTravelID, List<Seat> infoList) async {
    await delay(responseTime);

    return correctTicketsInfoResponse;
  }

  Future<bool> setLoggedIn(String name, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setString('AccessToken', token);
    prefs.setBool('isLoggedIn', true);
    return true;
  }

  void setLogout(BuildContext mainContext) {
    setLoggedInToFalse().then((commited) {
      Navigator.of(mainContext).pushNamedAndRemoveUntil(
          '/LoginPage', (Route<dynamic> route) => false);
    });
  }

  Future<bool> setLoggedInToFalse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', ' ');
    prefs.setString('username', ' ');
    prefs.setString('token', ' ');
    prefs.setString('access_token', ' ');
    prefs.setString('refresh_token', ' ');
    prefs.setBool('isLoggedIn', false);
    return true;
  }

  Future<bool> getLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn') == null
        ? false
        : prefs.getBool('isLoggedIn');
    return isLoggedIn!;
  }

  Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('AccessToken') == null
        ? ' '
        : prefs.getString('AccessToken');
    return accessToken!;
  }

  // Future<String> getCurrentVersion() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   //String versionName = packageInfo.version;
  //   String versionCode = packageInfo.buildNumber;
  //   print('versionCode = $versionCode');
  //   return versionCode;
  // }

  Future<String> fetchTravelStations(int tavelId) async {
    print('mocking fetchTravelStations');
    await delay(responseTime);
    print('after delay fetchTravelStations');
    return fetchTravelStationsResponse;
  }

  Future<String> fetchPassengers() async {
    print('mocking fetchPassengers');
    await delay(responseTime);
    print('after delay fetchPassengers');
    return fetchPassengersResponse;
  }

  ////////
  Future<String> getProfileData(String token) async {
    await delay(responseTime);
    return getDriverResponse;
  }

  Future<String> postNewPasswordForgetPass(
      String newPassword, String mobile) async {
    await delay(responseTime);

    return postNewPassForgetPassResponse;
  }

  Future<String?> fetchStationPassengers(int tavelId, int stationId) async {
    String token = await getAccessToken();
    // final url = "$baseUrl/rpc/get_travel_station_in_out_detail";
    final url = Uri.http(baseUrl, "/rpc/get_travel_station_in_out_detail");
    print('token = $token');
    print(url);
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map data = {
      "intext": {"token": token, "travel_id": tavelId, "station_id": stationId}
    };
    var body = json.encode(data);
    final response = await http.post(url, headers: header, body: body);
    print('fetchStationPassengers Response + ${response.body}');

    switch (response.statusCode) {
      case 200:
        return response.body;
        break;
      default:
        return null;
    }
  }

  Future<String> changeDriverPasswordCall(
      String token, String oldPassword, String newPassword) async {
    final url = "$baseUrl/rpc/change_driver_password";

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    Map data = {
      "intext": {
        "token": "$token",
        "old_password": "$oldPassword",
        "new_password": "$newPassword"
      }
    };

    var body = json.encode(data);
    print('body.encoded = $body');

    // final response = await http.post(url, headers: header, body: body);
    // print('change_driver_password = ${response.body}');
    print(
        'change_driver_password driverChangePasssword = $driverChangePasssword');
    // switch (response.statusCode) {
    //   case 200:
    //     await delay(responseTime);
    //     return driverChangePasssword;
    //     break;
    //   default:
    //     return 'null';
    // }

    await delay(responseTime);
    return driverChangePasssword;
  }

  Future<String> getMessages(String token) async {
    return messagesFromAdmin;
  }

  Future<http.Response> getCredit() async {
    return http.Response(getCreditResponse, 200);
  }

  Future<String> getDriverTripsHistory(int code) async {
    await delay(responseTime);
    if (correctCode == code) {
      return correctGetDriverTrips;
    } else {
      return wrongGetDriverTrips;
    }
  }

  Future<String> readyToCheckIn() async {
    return readyToCheckInResponse;
  }

  Future<String?> validatePhone(String cellphone, String type) async {
    await delay(responseTime);
    // final url =
    //     "$baseUrl/loginapi/validatemail?cellphone=$cellphone&type=$type";
    final url = Uri.http(
        baseUrl, "/loginapi/validatemail?cellphone=$cellphone&type=$type");
    print(url);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("ebus SignupRequest Response " + response.body);
        return response.body;
      } else {
        print('!!1!!!!!1!!!');
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  getFestivals(int limit) {
    return getFestivalsResponse;
  }

  getFestivalTowns() {
    return getFestivalTownsResponse;
  }
}
