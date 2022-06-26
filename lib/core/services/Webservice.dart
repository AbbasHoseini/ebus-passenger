import 'dart:convert';
import 'dart:io';
import 'package:ebus/core/models/InvoiceArgs.dart';
import 'package:ebus/core/models/PaymentOptionArgs.dart';
import 'package:ebus/core/models/Refund.dart';
import 'package:ebus/core/models/Seat.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
// import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ebus/core/models/AppUpdate.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/core/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

// Forget Password API Calls
Future<String> forgetPassword1GetOptions(
    String username, String clientID, String fcmToken, String rsa) async {
  // final url =
  //     "$baseUrl/loginapi/forgetpass?username=$username&Client_id=$clientID&fcm_Token=$fcmToken&rsa=$rsa";
  final url = Uri.https(baseUrl,
      "/loginapi/forgetpass?username=$username&Client_id=$clientID&fcm_Token=$fcmToken&rsa=$rsa");
  print(url);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    print("ebus forgetPasswordGetOptions Response " + response.body);
    return response.body;
  } else {
    throw Exception("Unable to perform forgetPasswordGetOptions!");
  }
}

Future<String> forgetPassword2OptionSelected(int id, bool mail, bool phone,
    String clientID, String fcmToken, String rsa) async {
  // final url =
  //     "$baseUrl/loginapi/forgetpassstep2?id=$id&mail=$mail&phone=$phone&Client_id=$clientID&fcm_Token=$fcmToken&rsa=$rsa";
  final url = Uri.https(baseUrl,
      "/loginapi/forgetpassstep2?id=$id&mail=$mail&phone=$phone&Client_id=$clientID&fcm_Token=$fcmToken&rsa=$rsa");

  print(url);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    print("ebus forgetPassword2OptionSelected Response " + response.body);
    return response.body;
  } else {
    throw Exception("Unable to perform forgetPassword2OptionSelected!");
  }
}

Future<String> forgetPassword3CheckCode(
    int id, String number, String clientID, String fcmToken, String rsa) async {
  final url = Uri.https(baseUrl,
      "/loginapi/forgetpassstep3?id=$id&number=$number&Client_id=$clientID&fcm_Token=$fcmToken&rsa=$rsa");
  print(url);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    print("ebus forgetPassword3CheckCode Response " + response.body);
    return response.body;
  } else {
    throw Exception("Unable to perform forgetPassword3CheckCode!");
  }
}

Future<List<User>> forgetPassword4ConfirmCode(int id, String newPass,
    String confirmPass, String clientID, String fcmToken, String rsa) async {
  // final url =
  //     "$baseUrl/loginapi/forgetpassconfirm?id=$id&newpass=$newPass&confirmpass=$confirmPass&Client_id=$clientID&fcm_Token=$fcmToken&rsa=$rsa";
  final url = Uri.https(baseUrl,
      "/loginapi/forgetpassconfirm?id=$id&newpass=$newPass&confirmpass=$confirmPass&Client_id=$clientID&fcm_Token=$fcmToken&rsa=$rsa");
  print(url);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    print("ebus forgetPassword4ConfirmCode Response " + response.body);
    final body = jsonDecode(response.body);
    final Iterable json = body;
    return json.map((item) => User.fromJson(item)).toList();
  } else {
    throw Exception("Unable to perform forgetPassword4ConfirmCode!");
  }
}

//////////////////////////////

///////////////////////////////////////

Future<bool> _setLoggedIn(
    String name, String token, String refreshToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('name', name);
  prefs.setString('access_token', token);
  prefs.setString('refresh_token', refreshToken);
  prefs.setBool('isLoggedIn', true);
  return true;
}

void setLogout(BuildContext mainContext) {
  setLoggedInToFalse().then((commited) {
    Navigator.of(mainContext)
        .pushNamedAndRemoveUntil('/LoginPage', (Route<dynamic> route) => false);
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

/////////////////////

Future<bool> getLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') == null
      ? false
      : prefs.getBool('isLoggedIn') ?? false;
  return isLoggedIn;
}

Future<String> getProfileData(String token) async {
  // final url = "$baseUrl/customer/listtotal?token=$token";
  final url = Uri.https(baseUrl, "/customer/listtotal?token=$token");

  print(url);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    print("ebus getProfileData Response " + response.body);
    return response.body;
  } else {
    throw Exception("Unable to perform getProfileData!");
  }
}

Future<String> setProfileData(String token, String name, String lastName,
    String gender, String username) async {
  // final url =
  //     "$baseUrl/Customer/edit_prof?token=$token&name=$name&lname=$lastName&sex=$gender&username=$username";
  final url = Uri.https(baseUrl,
      "/Customer/edit_prof?token=$token&name=$name&lname=$lastName&sex=$gender&username=$username");
  print(url);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    print("ebus setProfileData Response " + response.body);
    return response.body;
  } else {
    throw Exception("Unable to perform setProfileData!");
  }
}

Future<String> changePassword(
    String token, String pass, String newPass, String newPassConfirm) async {
  // final url =
  //     "$baseUrl/loginapi/ChangePass?token=$token&Pass=$pass&Newpass=$newPass&NewpassConfirm=$newPassConfirm";
  final url = Uri.https(baseUrl,
      "/loginapi/ChangePass?token=$token&Pass=$pass&Newpass=$newPass&NewpassConfirm=$newPassConfirm");

  print(url);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    print("ebus changePassword Response " + response.body);
    return response.body;
  } else {
    throw Exception("Unable to perform changePassword!");
  }
}

class Webservice {
  Future<http.Response> login(
    String password,
    String username,
  ) async {
    final url = Uri.https(baseUrl, "$prefixURL/auth/signin");
    print(url);
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map data = {"phone": username, "password": password};

    var body = json.encode(data);
    print(body);
    final response = await http.post(url, headers: header, body: body);
    print('loginResponse + ${response.statusCode}');
    return response;

    // switch (response.statusCode) {
    //   case 200:
    //     return response.body;
    //     break;
    //   case 201:
    //     return response.body;
    //     break;
    //   case 404:
    //     return response.body;
    //     break;
    //   default:
    //     return '500';
    // }
  }

  Future<String> register(
      String password,
      String cellphone,
      String mail,
      String name,
      String lname,
      String username,
      int gender,
      String nationalCode,
      String address,
      String dob) async {
    // final url = "$baseUrl/rpc/signup";
    final url = Uri.https(baseUrl, "/rpc/signup");

    print(url);
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map data = {
      "name": name,
      "family": lname,
      "email": mail,
      "username": username,
      "password": password,
      "mobile_number": cellphone,
      "gender": gender,
      "national_code": nationalCode,
      "address": address,
      "dob": dob
    };
    var body = json.encode(data);
    final response = await http.post(url, headers: header, body: body);
    print('registerResponse + ${response.body}');

    switch (response.statusCode) {
      case 200:
        return response.body;
        break;
      default:
        return 'null';
    }
  }

  Future<http.Response> registerFast(
    String password,
    String cellphone,
    String nationalCode,
  ) async {
    final url = Uri.https(baseUrl, "$prefixURL/auth/registerWithMobile");

    print(url);
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map data = {
      // "password": "$password",
      // "repassword": "$password",
      "phone": cellphone,
      // "national_code": "$nationalCode",
    };
    var body = json.encode(data);
    http.Response response = await http.post(url, headers: header, body: body);
    print('registerResponse + ${response.body}');

    return response;
  }

  Future<String> verifyCode(String username, String sentCode) async {
    // final url = "$baseUrl/rpc/user_verification";
    final url = Uri.https(baseUrl, "/rpc/user_verification");

    print(url);
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map data = {"verification_code": sentCode, "user_name": username};
    var body = json.encode(data);
    final response = await http.post(url, headers: header, body: body);
    print('verifyCodeResponse + ${response.body}');

    switch (response.statusCode) {
      case 200:
        return response.body;
        break;
      default:
        return 'null';
    }
  }

  Future<http.Response> verifyCodeFast(String number, String sentCode) async {
    final url = Uri.https(baseUrl, "$prefixURL/auth/verifyRegister");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map data = {"code": sentCode, "phone": number};

    var body = json.encode(data);
    http.Response response = await http.post(url, headers: header, body: body);

    return response;
  }

  Future<String> resendVerifyCode(String cellphone) async {
    // final url = "$baseUrl/rpc/resend_verification_code";
    final url = Uri.https(baseUrl, "/rpc/resend_verification_code");

    print(url);
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map data = {"mobile_number": cellphone};
    var body = json.encode(data);
    print('resendVerifyCodeBody + $body');
    final response = await http.post(url, headers: header, body: body);
    print('resendVerifyCodeResponse + ${response.body}');

    switch (response.statusCode) {
      case 200:
        return response.body;
        break;
      default:
        return 'null';
    }
  }

  Future<String> resendVerifyCodeFast(String cellphone) async {
    // final url = "$baseUrl/rpc/resend_verification_code";
    final url = Uri.https(baseUrl, "/rpc/resend_verification_code");

    print(url);
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map data = {"mobile_number": cellphone};
    var body = json.encode(data);
    final response = await http.post(url, headers: header, body: body);
    print('resendVerifyCodeResponse + ${response.body}');

    switch (response.statusCode) {
      case 200:
        return response.body;
        break;
      default:
        return 'null';
    }
  }

  Future<http.Response> getAllTownShip() async {
    final url = Uri.https(baseUrl, "$prefixURL/township");

    print(url);
    String token = await getToken();
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    http.Response response = await http.get(url, headers: header).timeout(
        Duration(seconds: 5),
        onTimeout: () => http.Response('Timed Out', 500));

    return response;
  }

  Future<http.Response> getAllTShips() async {
    final url = Uri.https(baseUrl, '$prefixURL/township/list/cities');

    String token = await getToken();
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    http.Response response = await http.get(url, headers: header).timeout(
        Duration(seconds: 5),
        onTimeout: () => http.Response('Time Out', 500));
    return response;
  }

  Future<String> getAllProvince(String token) async {
    // final url = "$baseUrl/rpc/get_province_all";
    final url = Uri.https(baseUrl, "/rpc/get_province_all");

    print(url);
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map data = {"token": token};
    var body = json.encode(data);
    final response = await http.post(url, headers: header, body: body);
    print('getAllTownShip + ${response.body}');

    switch (response.statusCode) {
      case 200:
        return response.body;
        break;
      default:
        return 'null';
    }
  }

  Future<http.Response> getSearchResult(String token, sourceCode,
      destinationCode, String date, festivalId) async {
    // final url = "$baseUrl/rpc/search_travel";

    final url = Uri.parse("https://" +
        baseUrl +
        "$prefixURL/travel/index/search?sourceTownshipId=$sourceCode&destTownshipId=$destinationCode&travelDate=$date");

    print('getSearchResult url = $url');
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map data;
    // if (festivalId == null) {
    //   data = {
    //     "sourceTownshipId": sourceId,
    //     "destTownshipId": destinationId,
    //     "travelDate": "$date"
    //   };
    // } else {
    //   data = {
    //     "token": "$token",
    //     "source_township_id": sourceId,
    //     "dest_township_id": destinationId,
    //     "travel_date": "$date",
    //     "festival_id": festivalId
    //   };
    // }
    final response = await http.get(
      url,
      headers: header,
    );
    print('getSearchResult ${response.body}');
    return response;
  }

  Future<http.Response> getTravelDetails(
      int travelId, int sourceId, int destinationId) async {
    final url = Uri.parse("https://" +
        baseUrl +
        "$prefixURL/travel/detail/getTravelDetail?sourceTownshipId=$sourceId&destTownshipId=$destinationId&travelId=$travelId");

    print('getTravelDetails = $url');
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    http.Response response;
    try {
      response = await http.get(url, headers: header);
    } catch (e) {
      print(e);
      return http.Response('', 500);
    }
    print('getCurrentTravel + ${response.body}');

    return response;
  }

  Future<http.Response> getTravelTicketId(int travelId, int sourceId,
      int destinationId, List<Seat> seatList) async {
    final url = Uri.https(baseUrl, "$prefixURL/ticket/buyTicket");
    String token = await getToken();

    List<String> userInfo = await getUserInfo();
    String userFirstName = userInfo[0];
    String userLastName = userInfo[1];
    String nationalCode = userInfo[2];

    print(url);
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };

    List<Map> seatGenderList = [];
    for (var item in seatList) {
      seatGenderList
          .add({"gender": item.gender, "seatNumber": item.seatNumber});
    }

    Map data = {
      "travelId": travelId,
      "sourceTownshipId": sourceId,
      "destTownshipId": destinationId,
      "userFirstName": userFirstName,
      "userLastName": userLastName,
      "userNationalCode": nationalCode,
      "listOfPassengers": seatGenderList
    };

    var body = json.encode(data);
    print('body buyTicket = $body');

    http.Response response;
    try {
      response = await http.post(url, headers: header, body: body);
      print('getTravelTicketId + ${response.body}');
    } catch (e) {
      print(e);
      return http.Response('', 500);
    }

    return response;
  }

  Future<String?> getPayByBank(int credit, int id) async {
    // String url = "https://171.22.27.169:8080/pay/mellat/$credit/54565";
    int userId = await getUserId();
    String url = "https://$baseUrl$prefixURL/pay/mellat/$id";
    print('bank Url = $url');
    String token = await getToken();
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };
    launch(url, headers: header);
    return null;
  }

  Future<http.Response> getOrderId(int credit) async {
    final url = Uri.parse('https://' + baseUrl + "$prefixURL/pay/chargeWallet");
    print('getOrderId Url = $url');
    String token = await getToken();

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };
    Map data = {"amount": credit, "platform": 1};
    var body = json.encode(data);
    var response;
    try {
      response = await http.post(url, headers: header, body: body);
    } catch (e) {
      print(e);
      return http.Response('', 500);
    }
    print('getOrderId response + ${response.body}');
    print('getOrderId status + ${response.statusCode}');

    return response;
  }

  Future<String?> getPayByBankCredit(int orderId) async {
    // String url = "https://171.22.27.169:8080/pay/mellat/$credit/54565";
    int userId = await getUserId();
    String url = "https://$baseUrl$prefixURL/pay/mellat/$orderId";
    print('bank Url = $url');
    String token = await getToken();
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };
    launch(url, headers: header);
    return null;
  }

  Future<http.Response> getTravelTicketInvoice(
      int ticketId, ticketIdReturn, String voucherCode) async {
    final url = Uri.parse('https://' +
        baseUrl +
        "$prefixURL/ticket/getTicketInvoice?ticketId=$ticketId&platform=1");

    String token = await getToken();

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };

    var response;
    try {
      response = await http.get(url, headers: header);
    } catch (e) {
      print(e);
      return http.Response('', 500);
    }
    print('getTravelTicketInvoice response + ${response.body}');
    print('getTravelTicketInvoice status + ${response.statusCode}');

    return response;
  }

  Future<http.Response> getPayByCreditResult(
      String token, InvoiceArgs invoiceArgs) async {
    final url = Uri.parse("https://" + baseUrl + "$prefixURL/pay/payByCredit");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };
    Map data = {
      "travelTicketId": invoiceArgs.ticketId,
      "orderId": invoiceArgs.orderId,
    };
    var body = json.encode(data);
    print('PayByCredit data = $body');
    http.Response response = await http.post(url, headers: header, body: body);

    return response;
  }

  Future<http.Response> getPassengersOfFaveList() async {
    String token = await getToken();
    final url = Uri.https(baseUrl, "$prefixURL/ticket/favoritePassenger");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };
    http.Response response = await http.get(url, headers: header);
    return response;
  }

  Future<http.Response> addPassengersToFaveList(
      String token, String name, String lastName, String nationalCode) async {
    final url = Uri.https(baseUrl, "$prefixURL/ticket/favoritePassenger");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };

    Map data = {
      "passengerFirstName": name,
      "passengerLastName": lastName,
      "passengerNationalCode": nationalCode
    };
    var body = json.encode(data);
    http.Response response = await http.post(url, headers: header, body: body);

    return response;
  }

  Future<http.Response> removePassengersOfFaveList(String token, int id) async {
    final url =
        Uri.https(baseUrl, "$prefixURL/ticket/favoritePassenger/$id");
    print('Url Delete FavPassenger $url');

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };
    http.Response response = await http.delete(url, headers: header);
    return response;
  }

  Future<String> getTravelsHistoryResult(String token) async {
    // final url = "$baseUrl/rpc/rep_user_travels";
    final url = Uri.https(baseUrl, "/rpc/rep_user_travels");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    Map data = {"token": token};
    var body = json.encode(data);
    final response = await http.post(url, headers: header, body: body);
    print('getTravelsHistoryResult ${response.body}');

    switch (response.statusCode) {
      case 200:
        return response.body;
        break;
      default:
        return 'null';
    }
  }

  Future<http.Response> getTransactionsHistoryResult(String token) async {
    // final url = "$baseUrl/rpc/rep_user_transactions";
    final url =
        Uri.https(baseUrl, "$prefixURL/travel/user/getUserTransaction");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };

    http.Response response = await http.get(url, headers: header);
    print('getTransactionsHistoryResult ${response.body}');

    return response;
  }

  Future<http.Response> getReportItemTitles(String token) async {
    // final url = "$baseUrl/rpc/s_support_item";
    final url =
        Uri.https(baseUrl, "$prefixURL/travel/support/getSupportItems");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };
    print('getReportItemTitles url = $url');

    http.Response response = await http.get(url, headers: header);
    print('getReportItemTitles response = ${response.body}');
    return response;
  }

  Future<http.Response> submitReport(
      String token, String description, int travelId, int supportItemId) async {
    // final url = "$baseUrl/rpc/i_support_item_ticket";
    final url = Uri.https(
        baseUrl, "$prefixURL/travel/support/createSupportItemTicket");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };

    Map data = {
      "description": description,
      "travelId": travelId,
      "supportItemId": supportItemId
    };
    var body = json.encode(data);
    http.Response response = await http.post(url, headers: header, body: body);
    print('submitReport ${response.body}');

    return response;
  }

  Future<String> getUserStatics(String token) async {
    // final url = "$baseUrl/rpc/get_passenger_travels";
    final url = Uri.https(baseUrl, "/rpc/get_passenger_travels");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    Map data = {"token": token};
    var body = json.encode(data);
    final response = await http.post(url, headers: header, body: body);
    print('getUserStatics ${response.body}');

    switch (response.statusCode) {
      case 200:
        return response.body;
        break;
      default:
        return 'null';
    }
  }

  Future<http.Response> getTicketsInfo(
      String token, int ticketTravelID, List<Seat> infoList, orderId) async {
    final url = Uri.https(baseUrl, "$prefixURL/ticket/insertPassengerInfo");
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };

    List<Map> seatGenderList = [];
    for (var item in infoList) {
      // seatGenderList =
      //     '$seatGenderList{"first_name":"${item.name}","last_name":"${item.familyName}","national_code":"${item.nationalCode}","seat_number":${item.seatNumber}},';
      seatGenderList.add({
        "passengerFirstName": item.name,
        "passengerLastName": item.familyName,
        "passengerNationalCode": item.nationalCode,
        "seatNumber": item.seatNumber,
      });
    }

    Map data = {
      "travelTicketId": ticketTravelID,
      "passengerListInfo": seatGenderList,
      "orderId": orderId,
    };

    var body = json.encode(data);
    final http.Response response =
        await http.post(url, headers: header, body: body);

    return response;
  }

  Future<http.Response?> getProfileData(String token) async {
    final url = Uri.https(baseUrl, "$prefixURL/auth/getUserProfile");

    print('token = $token');
    print('url = $url');

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };

    final response = await http.get(url, headers: header);

    print('response.statusCode ${response.statusCode} ');
    print('get_profile response = ${response.body} ');
    switch (response.statusCode) {
      case 200:
        return response;
        break;
      default:
        return null;
    }
  }

  Future<String> changeProfileCall(String token, User user) async {
    final url = Uri.https(baseUrl, "$prefixURL/auth/updateUserProfile");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };

    Map data = {
      "firstName": "${user.name}",
      "lastName": "${user.lname}",
      "email": "${user.mail}",
      "gender": "${user.genderId}",
      "nationalCode": "${user.nationalCode}",
      "phone": "${user.phone}",
      "userName": "${user.userName}",
    };

    var body = json.encode(data);

    final response = await http.put(url, headers: header, body: body);
    print('update_profile = ${response.body}');
    switch (response.statusCode) {
      case 200:
        return response.body;
        break;
      default:
        return 'null';
    }
  }

  Future<String> changeUserPasswordCall(
      String token, String oldPassword, String newPassword) async {
    final url = Uri.https(baseUrl, "$prefixURL/auth/changeUserPassword");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };

    print('changeUserPasswordCall url = $url');

    Map data = {"oldPassword": oldPassword, "newPassword": newPassword};

    var body = json.encode(data);
    print('body.encoded = $body');

    final response = await http.post(url, headers: header, body: body);
    print('change_passenger_password = ${response.body}');
    switch (response.statusCode) {
      case 200:
        return response.body;
        break;
      default:
        return 'null';
    }
  }

  Future<http.Response?> loginWithMobile(String phone) async {
    final url = Uri.https(baseUrl, "$prefixURL/auth/loginWithMobile");

    print(url);
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map data = {"phone": phone};
    print('maaaap data: $data');
    var body = json.encode(data);
    try {
      http.Response response =
          await http.post(url, headers: header, body: body).timeout(
                const Duration(seconds: 500),
                // onTimeout: () => null,
              );
      print(response.body);
      return response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response> singInFast(String phone, String verifyCode) async {
    // final url = "$baseUrl/rpc/fast_user_verification";
    final url = Uri.https(baseUrl, "$prefixURL/auth/verifyLogin");

    print(url);
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    print('verifyCode = $verifyCode');
    Map data = {"code": verifyCode, "phone": phone};
    print('data = $data');

    var body = json.encode(data);
    http.Response response =
        await http.post(url, headers: header, body: body).timeout(
              Duration(seconds: 5),
              onTimeout: () => http.Response('timed out', 500),
            );
    return response;
  }

  Future<String?> getFestivals(int limit) async {
    final url = Uri.https(baseUrl, "/rpc/get_festivals");
    print(url);
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map data = {"limit": "$limit"};
    print(' getFestivals data = $data');

    var body = json.encode(data);
    try {
      final response = await http.post(url, headers: header, body: body);
      print('getFestivals + ${response.body}');

      switch (response.statusCode) {
        case 200:
          return response.body;
          break;
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> getFestivalTowns(int festivalId) async {
    // final url = "$baseUrl/rpc/get_festival_travels";
    final url = Uri.https(baseUrl, "/rpc/get_festival_travels");

    print(url);
    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map data = {"festival_id": "$festivalId"};
    print('getFestivalTowns data = $data');

    var body = json.encode(data);
    try {
      final response = await http.post(url, headers: header, body: body);
      print('getFestivalTowns + ${response.body}');

      switch (response.statusCode) {
        case 200:
          return response.body;
          break;
        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> postMobileForgetPass(String mobile) async {
    // final url = "$baseUrl/rpc/forget_password_request_passenger";
    final url = Uri.https(baseUrl, "/rpc/forget_password_request_passenger");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map data = {"mobile_number": mobile};
    print(url);
    print('postMobileForgetPass data + $data');

    var body = json.encode(data);
    final response = await http.post(url, headers: header, body: body);
    print('postMobileForgetPass + ${response.body}');

    switch (response.statusCode) {
      case 200:
        return response.body;
        break;
      default:
        return null;
    }
  }

  Future<String?> postVerificationCodeForgetPass(
      String code, String mobile) async {
    // final url =
    //     "$baseUrl/rpc/verify_forget_password_verification_code_passenger";
    final url = Uri.https(
        baseUrl, "/rpc/verify_forget_password_verification_code_passenger");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map data = {"mobile_number": mobile, "verification_code": code};

    var body = json.encode(data);
    final response = await http.post(url, headers: header, body: body);
    print('postVerificationCodeForgetPass + ${response.body}');

    switch (response.statusCode) {
      case 200:
        return response.body;
        break;
      default:
        return null;
    }
  }

  Future<String?> postNewPasswordForgetPass(
      String newPassword, String mobile) async {
    // final url = "$baseUrl/rpc/update_driver_password_passenger";
    final url = Uri.https(baseUrl, "/rpc/update_driver_password_passenger");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };
    Map data = {"mobile_number": mobile, "new_password": newPassword};

    var body = json.encode(data);
    final response = await http.post(url, headers: header, body: body);
    print('postNewPasswordForgetPass + ${response.body}');

    switch (response.statusCode) {
      case 200:
        return response.body;
        break;
      default:
        return null;
    }
  }

  Future<http.Response> getReportsList() async {
    String token = await getToken();
    // final url = "$baseUrl/rpc/rep_user_support_item";
    final url = Uri.https(
        baseUrl, "$prefixURL/travel/support/getSupportItemTicket");
    print('getReportsList url $url');

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };

    print('getReportsListSendData $token');
    http.Response response = await http.get(url, headers: header);
    print('getSupportItemTickets ${response.body}');
    return response;
  }

  Future<http.Response> postRefund(Refund refund) async {
    String token = await getToken();
    // final url = "$baseUrl/rpc/rep_user_support_item";
    final url = Uri.https(baseUrl, "$prefixURL/ticket/refund");
    print('postRefund url $url');

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };
    Map data = refund.toMap();
    var body = json.encode(data);
    print('postRefund $token');
    print('postRefund $body');
    http.Response response = await http.post(url, headers: header, body: body);
    print('postRefund ${response.body}');
    return response;
  }

  Future<http.Response> cancelRefund(Refund refund) async {
    String token = await getToken();
    // final url = "$baseUrl/rpc/rep_user_support_item";
    final url =
        Uri.https(baseUrl, "$prefixURL/ticket/refund/${refund.id}");
    print('cencelRefund url $url');

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };
    Map data = {"status": -1};
    var body = json.encode(data);

    print('cencelRefund $token');
    http.Response response = await http.put(url, headers: header, body: body);
    print('cencelRefund ${response.body}');
    return response;
  }

  Future<http.Response> getRefunds() async {
    String token = await getToken();
    // final url = "$baseUrl/rpc/rep_user_support_item";
    final url = Uri.https(baseUrl, "$prefixURL/ticket/refund");
    print('getRefunds url $url');

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };
    http.Response response = await http.get(url, headers: header);
    print('getRefunds ${response.body}');
    return response;
  }

  Future<http.Response> getCredit() async {
    String token = await getToken();
    // final url = "$baseUrl/rpc/rep_user_support_item";
    final url = Uri.https(baseUrl, "$prefixURL/auth/getUserCredit");
    print('getCredit url $url');

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };

    print('getCredit $token');
    http.Response response = await http.get(url, headers: header);
    print('getCredit ${response.body}');
    return response;
  }

  Future<String> getTravelHistoryDetail(int ticketId) async {
    String token = await getToken();
    // final url = "$baseUrl/rpc/get_ticket_detail";
    final url = Uri.https(baseUrl, "/rpc/get_ticket_detail");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8"
    };

    Map data = {"token": token, "ticket_id": "$ticketId"};
    var body = json.encode(data);
    final response = await http.post(url, headers: header, body: body);
    print('getTravelHistoryDetail ${response.body}');
    switch (response.statusCode) {
      case 200:
        return response.body;
        break;
      default:
        return 'null';
    }
  }

  Future<String> getTravelDashboardInfo() async {
    String token = await getToken();
    // final url = "$baseUrl/rpc/rep_user_dashboard_item";
    final url = Uri.https(baseUrl, "$prefixURL/travel/user/userTravelReport");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };

    final response = await http.get(url, headers: header);
    print('getTravelDashboardInfo response ${response.body}');
    switch (response.statusCode) {
      case 200:
        return response.body;
        break;
      default:
        return 'null';
    }
  }

  Future<http.Response> getUserCurrentTravel([bool? isFirst]) async {
    String token = await getToken();
    // final url = "$baseUrl/rpc/get_user_active_travel";
    final url =
        Uri.https(baseUrl, "$prefixURL/travel/user/getUserActiveTravel");

    Map<String, String> header = {
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token"
    };

    http.Response response = await http.get(url, headers: header);
    print('getUserCurrentTravel ${response.body}');
    return response;
  }
}
