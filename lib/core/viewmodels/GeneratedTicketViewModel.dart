import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ebus/core/models/InvoiceArgs.dart';
import 'package:ebus/core/models/Seat.dart';
import 'package:ebus/core/viewmodels/MainViewModel.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ebus/core/services/MockWebservice.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as I;
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';
//import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart' as sharedPref;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class GeneratedTicketViewModel with ChangeNotifier {
  final AuthServiceType? authServiceType;
  GeneratedTicketViewModel({this.authServiceType});

  bool _isHistoryDetail = false;
  bool _loading = true;
  List<Seat>? _tickets;
  List<Seat>? _ticketsReturn;
  List<bool> _toggleList = [true, false, false];
  LatLng? _currentPoint;
  LatLng? _sourcePoint;
  LatLng? _destinationPoint;
  MapController? _mapController;
  var _base64QR;
  bool _isTwoWay = false;

  bool _downloading = false;
  bool inside = false;
  Uint8List? imageInMemory;
  var _downloadsDirectory;

  String? purchaseDate,
      shamsiPurchaseDate,
      departureDate,
      shamsiDepartureDate,
      departureTime,
      arivalTime,
      purchaseTime,
      sourceCity,
      destinationCity = '';

  String? purchaseDateReturn,
      shamsiPurchaseDateReturn,
      departureDateReturn,
      shamsiDepartureDateReturn,
      departureTimeReturn,
      purchaseTimeReturn;

  int? _ticketId,
      _orderId,
      distance,
      duration,
      _ticketIdReturn,
      _basePrice,
      _basePriceReturn;
  List<Seat>? _seatList;
  List<Seat>? _seatListReturn;

  String? _name, _family;

  bool get isTwoWay => _isTwoWay;

  void setIsTwoWay(bool value) {
    _isTwoWay = value;
    notifyListeners();
  }

  List<Seat> get ticketsReturn => _ticketsReturn!;
  List<Seat> get tickets => _tickets!;

  void setTicketsReturn(List<Seat> value) {
    _ticketsReturn = value;
    notifyListeners();
  }

  List<Seat> get seatListReturn => _seatListReturn!;

  void setSeatListReturn(List<Seat> value) {
    _seatListReturn = value;
    notifyListeners();
  }

  int get ticketIdReturn => _ticketIdReturn!;

  void setTicketIdReturn(int value) {
    _ticketIdReturn = value;
    notifyListeners();
  }

  get base64QR => _base64QR;

  void setBase64QR(Uint8List value) {
    _base64QR = value;
    notifyListeners();
  }

  MapController get mapController => _mapController!;
  LatLng get currentPoint => _currentPoint!;
  List<bool> get toggleList => _toggleList;

  LatLng get destinationPoint => _destinationPoint!;

  void setDestinationPoint(LatLng value) {
    _destinationPoint = value;
    notifyListeners();
  }

  LatLng get sourcePoint => _sourcePoint!;

  void setSourcePoint(LatLng value) {
    _sourcePoint = value;
    notifyListeners();
  }

  void setToggleListTrue(int index) {
    _toggleList = [false, false, false];
    _toggleList[index] = true;
    index == 0
        ? _currentPoint = _destinationPoint
        : _currentPoint = _sourcePoint;
    _mapController!.move(_currentPoint!, 14);
    notifyListeners();
  }

  void setBasePrice(int price) {
    _basePrice = price;
    notifyListeners();
  }

  void setBasePriceRetun(int price) {
    _basePriceReturn = price;
    notifyListeners();
  }

  int getBasePrice() {
    return _basePrice!;
  }

  int getBasePriceReturn() {
    return _basePriceReturn!;
  }

  bool get getLoading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get isHistoryDetail => _isHistoryDetail;

  void setIsHistoryDetail(bool value) {
    _isHistoryDetail = value;
    notifyListeners();
  }

  List<Seat> get getTickets => _tickets!;

  void setTickets(List<Seat> value) {
    _tickets = value;
    notifyListeners();
  }

  int getTicketId() => _ticketId!;

  void setTicketId(int value) {
    _ticketId = value;
    notifyListeners();
  }

  void setOrderId(int value) {
    _orderId = value;
    notifyListeners();
  }

  List<Seat> getSeatList() => _seatList!;

  void setSeatList(List<Seat> value) {
    _seatList = value;
    notifyListeners();
  }

  initPR(BuildContext context) {
    getTwoWay().then((value) {
      _isTwoWay = value;
      if (_isTwoWay) {
        getTicketsListReturn(context).then((value) {
          if (_ticketsReturn!.isNotEmpty || _ticketsReturn != null) {
            _tickets = _tickets! + _ticketsReturn!;
          }
          notifyListeners();
        });
      }
    });
    _mapController = MapController();

    getTicketsList(context).then((val) {
      _loading = false;
      notifyListeners();
    });
  }

  Future<bool> getTicketsList(BuildContext context) async {
    _loading = true;
    _tickets = [];
    String token = await getToken();
    InvoiceArgs? invoiceArgs;
    http.Response result;
    if (authServiceType == AuthServiceType.mock) {
      result =
          await MockWebservice().getTicketsInfo(token, _ticketId!, _seatList!);
    } else {
      result = await Webservice()
          .getTicketsInfo(token, _ticketId!, _seatList!, _orderId);
    }
    print("getTicketsList ${result.body}");

    final bodyResponse = json.decode(result.body);
    int statusCode = result.statusCode;

    print(statusCode);

    switch (statusCode) {
      case 404:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        _loading = false;
        //notifyListeners();
        return false;
        break;
      case 403:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        _loading = false;
        //notifyListeners();
        return false;
        break;
      case 200:

        var data;
        var data2;
        try {
          data = (bodyResponse["data"]["ticketInfo"]);
          data2 = (bodyResponse["data"]["passengerInfo"]) as List;
        } catch (e) {
          print('e = $e');
          data = (bodyResponse["Data"]["ticketInfo"]);
          data2 = (bodyResponse["data"]["passengerInfo"]) as List;
        }

        if (data == null || data2 == null) {
          showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
          _loading = false;
          return false;
        }

        _base64QR = "";
        _base64QR = bodyResponse['data']["qrCode"];
        print('qrCode = $_base64QR');
        sourceCity = data["sourceTitle"];
        destinationCity = data["destTitle"];
        _basePrice = data["price"] ?? 0;
        departureDate = data["departureDatetime"].toString().substring(0, 10);
        departureTime = data["departureDatetime"].toString().substring(11, 16);

        arivalTime = (data["arrivedTime"] ?? '2021-06-04T02:00:00.000Z')
            .toString()
            .substring(11, 16);
        shamsiDepartureDate = getShamsiDate(departureDate!);
        distance = data["distance"] ?? 380;
        duration = data["duration"] ?? 240;
        purchaseDate = data["purchaseTime"].toString().substring(0, 10);
        purchaseTime = data["purchaseTime"].toString().substring(11, 16);

        shamsiPurchaseDate = getShamsiDate(purchaseDate!);

        data2.forEach((item) {
          //print("AQ ${item["passenger_name"]} ${item["id"]} ${item["national_code"]} ${item["gender_id"]} ${item["seat_number"]}");
          _tickets!.add(Seat(
              name: item["passengerFirstName"] ?? "",
              familyName:
                  item["passengerLastName"] ?? "", //TODO not included in API
              id: item["id"] ?? 0,
              nationalCode: item["passengerNationalCode"] ?? "",
              gender: item["gender"] ?? 0,
              seatNumber: item["seatNumber"] ?? 0));
        });
        _name = data["userFirstName"] ?? "";
        _family = data["userLastName"] ?? "";

        _loading = false;
        //notifyListeners();

        return true;
        break;
      default:
        _loading = false;

        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        //notifyListeners();
        return false;
    }
  }

  Future<bool> getTicketsListReturn(BuildContext context) async {
    _loading = true;
    _ticketsReturn = <Seat>[];
    final InvoiceArgs _invoiceArgs = InvoiceArgs();
    String token = await getToken();
    var result;
    List<Seat> tempList = _seatList!;
    for (int i = 0; i < _seatList!.length; i++) {
      tempList[i].seatNumber = _seatListReturn![i].seatNumber;
    }
    _seatListReturn = tempList;
    if (authServiceType == AuthServiceType.mock) {
      result = await MockWebservice()
          .getTicketsInfo(token, _ticketIdReturn!, _seatListReturn!);
    } else {
      result = await Webservice()
          .getTicketsInfo(token, _ticketIdReturn!, _seatListReturn!, _orderId);
    }
    print("getTicketsListReturn $result");

    final bodyResponse = json.decode(result);
    String statusCode;
    try {
      statusCode = bodyResponse["status"];
    } catch (e) {
      statusCode = bodyResponse[0]["i_passengers_seat_info"]["status"];
    }

    print(statusCode);

    switch (statusCode) {
      case "404":
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        _loading = false;
        return false;
        break;
      case "403":
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        _loading = false;
        return false;
        break;
      case "201":
        var data;
        var data2;
        var data3;
        try {
          data = bodyResponse[0]["i_passengers_seat_info"]["data"]
              ["Ticket_Info"] as List;
          data2 = bodyResponse[0]["i_passengers_seat_info"]["data"]
              ["Passenger_Info"] as List;
          data3 = bodyResponse[0]["i_passengers_seat_info"]["data"]
              ["Ticket_Code"] as List;
        } catch (e) {
          data = bodyResponse["data"]["Ticket_Info"] as List;
          data2 = bodyResponse["data"]["Passenger_Info"] as List;
          data3 = bodyResponse["data"]["Ticket_Code"].toString();
        }

        if (data == null || data2 == null) {
          showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
          _loading = false;
          return false;
        }
        List<int> list = data3.codeUnits;

        _base64QR = data3;
        print("bbbbbbbbv $_base64QR");
        _basePriceReturn = data.last["unit_price"] ?? 0;
        departureDateReturn =
            data.last["departure_datetime"].toString().substring(0, 10);
        departureTimeReturn =
            data.last["departure_datetime"].toString().substring(11, 16);
        shamsiDepartureDateReturn = getShamsiDate(departureDateReturn!);

        purchaseDateReturn =
            data.last["purchase_time"].toString().substring(0, 10);
        purchaseTimeReturn =
            data.last["purchase_time"].toString().substring(11, 16);
        shamsiPurchaseDateReturn = getShamsiDate(purchaseDateReturn!);

        data2.forEach((item) {
          _ticketsReturn!.add(Seat(
              name: item["passenger_name"] ?? "",
              familyName: item["passanger_family"] ?? "",
              id: item["id"] ?? "",
              nationalCode: item["national_code"] ?? "",
              gender: item["gender_id"] ?? 1,
              seatNumber: item["seat_number"] ?? ""));
        });

        _loading = false;

        return true;
        break;
      default:
        _loading = false;

        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        return false;
    }
  }

  Future<bool> getTicketsDetail(BuildContext context) async {
    _loading = true;
    _tickets = <Seat>[];
    String token = await getToken();
    var result;
    if (authServiceType == AuthServiceType.mock) {
      result =
          await MockWebservice().getTicketsInfo(token, _ticketId!, _seatList!);
    } else {
      result = await Webservice().getTravelHistoryDetail(_ticketId!);
    }

    final bodyResponse = json.decode(result);
    String statusCode;
    try {
      statusCode = bodyResponse["status"];
    } catch (e) {
      statusCode = bodyResponse[0]["get_ticket_detail"]["status"];
    }

    print(statusCode);

    switch (statusCode) {
      case "404":
        showInfoFlushbar(context, "خطای توکن", "خطای توکن", false,
            durationSec: 2);
        _loading = false;
        sharedPref.setLogout(context);
        _loading = false;
        //notifyListeners();
        return false;
        break;
      case "403":
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        _loading = false;
        //notifyListeners();
        return false;
        break;
      case "200":
        var data;
        try {
          data = bodyResponse[0]["get_ticket_detail"]["data"] as List;
        } catch (e) {
          data = bodyResponse["data"] as List;
        }

        if (data == null) {
          showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
          _loading = false;
          //notifyListeners();
          return false;
        }
        print("bbbbbbbbv $_base64QR");
        sourceCity = data.last["source_title"];
        destinationCity = data.last["dest_title"];

        data.forEach((item) {
          _tickets!.add(Seat(
              name: item["passenger_name"] ?? "",
              familyName: item["passanger_family"] ?? "",
              id: item["id"] ?? 0,
              nationalCode: item["national_code"] ?? "",
              gender: item["gender_id"] ?? 0,
              seatNumber: item["seat_number"] ?? 0));
        });

        _loading = false;
        notifyListeners();
        return true;
        break;
      default:
        _loading = false;
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        //notifyListeners();
        return false;
    }
  }

  Future<void> capturePng(GlobalKey _globalKey, BuildContext context) async {
    await initDownloadsDirectoryState();
    if (_downloadsDirectory == null) {
      _downloading = false;
      showInfoFlushbar(context, "خطای دسترسی به محل ذخیره بلیط", "", false,
          durationSec: 2);
      notifyListeners();
      return;
    }
    try {
      var status = await Permission.storage.status;
      PermissionStatus permissionStatus;
      if (!status.isGranted) {
        permissionStatus = await Permission.storage.request();
        if (!permissionStatus.isGranted) {
          showInfoFlushbar(context, "خطای اجازه دسترسی", "", false,
              durationSec: 2);
          _downloading = false;
          notifyListeners();
          return;
        }
      }
      print('inside');
      inside = true;
      RenderObject? boundary = _globalKey.currentContext!.findRenderObject();
      // ui.Image image = await boundary!.toImage(pixelRatio: 3.0);
      ui.Image image = boundary! as ui.Image;
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      print('_downloadsDirectory =  $_downloadsDirectory');
      File file = File('$_downloadsDirectory/ticket${_ticketId ?? 0}.jpeg');
      print('path = $_downloadsDirectory/ticket${_ticketId ?? 0}.jpeg');
      print('path = $_downloadsDirectory/ticket${_ticketId ?? 0}.jpeg');
      print('png done $pngBytes');
      await file.writeAsBytes(pngBytes.buffer
          .asUint8List(pngBytes.offsetInBytes, pngBytes.lengthInBytes));
      // await file.writeAsBytes(pngBytes);
      print('wrote file');
      imageInMemory = pngBytes;
      inside = false;
      _downloading = false;
      showInfoFlushbar(context, "بلیط شما در دستگاه ذخیره شد!", "", false,
          durationSec: 2);
      notifyListeners();
      // Timer(Duration(seconds: 2), () {
      //   Navigator.pushNamed(
      //     context,
      //     '/MainView',
      //   );
      // });

      return;
    } catch (e) {
      showInfoFlushbar(context, "خطای ذخیره سازی", "", false, durationSec: 2);
      _downloading = false;
      notifyListeners();
      print(e);
      return;
    }
  }

  Future<void> initDownloadsDirectoryState() async {
    var downloadsDirectory;
    try {
      //downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;

      downloadsDirectory = await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_PICTURES);
    } catch (e) {
      print('Could not get the downloads directory');
    }
    //if (!mounted) return;
    _downloadsDirectory = downloadsDirectory;
    notifyListeners();
  }

  bool get downloading => _downloading;
  void setDownloading(bool value) {
    _downloading = value;
    notifyListeners();
  }

  get family => _family;
  void setFamily(value) {
    _family = value;
    notifyListeners();
  }

  String? get name => _name;
  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  bool _isFirst = true;

  Future<bool> onWillPop(BuildContext context) async {
    if (_isFirst) {
      showInfoFlushbar(context,
          "برای بازگشت به ضفحه اصلی دوباره بازگشت را بزنید", " ", false,
          durationSec: 2);
      _isFirst = false;
      return false;
    } else {
      _isFirst = true;
      MainViewModel mainViewModel =
          Provider.of<MainViewModel>(context, listen: false);
      mainViewModel.getUserCurrentTravel();
      Navigator.popUntil(context, ModalRoute.withName('/MainView'));
      return true;
    }
  }
}
