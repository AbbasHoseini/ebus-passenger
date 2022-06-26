import 'dart:convert';

import 'package:ebus/core/models/InvoiceArgs.dart';
import 'package:ebus/core/models/Seat.dart';
import 'package:ebus/core/models/SeatClass.dart';
import 'package:ebus/core/models/TravelDetailArgsNew.dart';
import 'package:ebus/core/services/MockWebservice.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:ebus/helpers/SharedPrefHelper.dart' as sharedPref;
import 'package:ebus/helpers/SharedPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'MainViewModel.dart';
// import 'package:persian_date/persian_date.dart';

class TravelDetailViewModelNew with ChangeNotifier {
  final AuthServiceType? authServiceType;
  TravelDetailViewModelNew({this.authServiceType});
  bool? _loading;
  LatLng? _sourcePoint, _destinationPoint;
  String? _sourceTitle, _destinationTitle;
  int? _ticketId;
  InvoiceArgs _invoiceArgs = InvoiceArgs(seats: []);
  int? _seatCount, _rowCount, _columnCount, _carTypeId;
  TravelDetailArgsNew? _travelDetailArgsNew;
  List<Seat>? _seats;
  TextEditingController? voucherCodeController;
  bool _shouldInit = true;
  List<bool> _toggleList = [true, false, false];
  LatLng? _currentPoint;
  MapController? _mapController;
  bool _isTwoWay = false;

  int? _childCount, _adultCount;

  int get childCount => _childCount!;
  int get adultCount => _adultCount!;

  LatLng? _destinationPointReturn, _currentPointReturn, _sourcePointReturn;
  bool? _loadingReturn;
  String? _sourceTitleReturn, _destinationTitleReturn;

  int? _seatCountReturn,
      _rowCountReturn,
      _columnCountReturn,
      _carTypeIdReturn,
      _ticketIdReturn;
  List<Seat>? _seatsReturn;
  List<bool>? _toggleListReturn = [true, false, false];

  MapController? _mapControllerReturn;

  LatLng get sourcePointReturn => _sourcePointReturn!;

  set sourcePointReturn(LatLng value) {
    _sourcePointReturn = value;
  }

  bool get isTwoWay => _isTwoWay;

  void setIsTwoWay(bool value) {
    _isTwoWay = value;
    notifyListeners();
  }

  InvoiceArgs get invoiceArgs => _invoiceArgs;

  MapController get mapController => _mapController!;

  LatLng get currentPoint => _currentPoint!;

  void setCurrentPoint(LatLng value) {
    _currentPoint = value;
    notifyListeners();
  }

  List<bool> get toggleList => _toggleList;

  void setToggleListTrue(int index) {
    _toggleList = [false, false, false];
    _toggleList[index] = true;
    index == 0
        ? _currentPoint = _destinationPoint
        : _currentPoint = _sourcePoint;
    _mapController!.move(_currentPoint!, 14);
    notifyListeners();
  }

  void setToggleListTrueReturn(int index) {
    _toggleListReturn = [false, false, false];
    _toggleListReturn![index] = true;
    index == 0
        ? _currentPointReturn = _destinationPointReturn
        : _currentPointReturn = _sourcePointReturn;
    _mapControllerReturn!.move(_currentPointReturn!, 14);
    notifyListeners();
  }

  bool get shouldInit => _shouldInit;

  void setShouldInit(bool value) {
    _shouldInit = value;
    notifyListeners();
  }

  int get ticketId => _ticketId!;

  void setTicketId(int value) {
    _ticketId = value;
    notifyListeners();
  }

  Future<bool> getTravelDetail(BuildContext context) async {
    http.Response result;
    try {
      if (authServiceType == AuthServiceType.mock) {
        result = await MockWebservice().getTravelDetails(
            _travelDetailArgsNew!.travelId!,
            _travelDetailArgsNew!.sourceId!,
            _travelDetailArgsNew!.destinationId!);
      } else {
        result = await Webservice().getTravelDetails(
            _travelDetailArgsNew!.travelId!,
            _travelDetailArgsNew!.sourceId!,
            _travelDetailArgsNew!.destinationId!);
      }
    } on Exception catch (e) {
      showInfoFlushbar(context, dialogErrorSTR, "خطای سرور", false,
          durationSec: 2);
      return false;
    }
    final bodyResponse = json.decode(result.body);
    int statusCode = result.statusCode;

    print(statusCode);

    switch (statusCode) {
      case 404:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        notifyListeners();
        return false;
        break;
      case 200:
        var data = bodyResponse["data"];
        if (data == null) {
          showInfoFlushbar(
              context, dialogErrorSTR, "اظلاعاتی برای نمایش وجود ندارد", false,
              durationSec: 2);
          notifyListeners();
          return false;
        }
        // print('00000000000000000000000000000::: ${data["TownshipsInfo"]["sourceTownshipLat"] * 1.0 ?? 0.0}');
        // print('00000000000000000000000000000::: ${data['stations'][0]['spanData']}');

        // _sourcePoint = LatLng(
        //     data["TownshipsInfo"]["sourceTownshipLat"] * 1.0 ?? 0.0,
        //     data["TownshipsInfo"]["sourceTownshipLon"] * 1.0 ?? 0.0);
        // _mapController = MapController();
        // _destinationPoint = LatLng(
        //     data["TownshipsInfo"]["destTownshipLat"] * 1.0 ?? 0.0,
        //     data["TownshipsInfo"]["destTownshipLon"] * 1.0 ?? 0.0);
        // _currentPoint = _destinationPoint;

        if (data["townshipsInfo"]['sourceSpanData'] != null &&
            data["townshipsInfo"]['destSpanData'] != null) {
          _sourcePoint = LatLng(
              (data["townshipsInfo"]["sourceTownshipLat"] ?? 0.0) * 1.0,
              (data["townshipsInfo"]["sourceTownshipLon"] ?? 0.0) * 1.0);
              
          _destinationPoint = LatLng(
              (data["townshipsInfo"]['sourceSpanData']['coordinates'][0] ??
                      0.0) *
                  1.0,
              (data["townshipsInfo"]['destSpanData']['coordinates'][1] ?? 0.0) *
                  1.0);
          _currentPoint = _destinationPoint;
        } else {}

        _sourceTitle = data["townshipsInfo"]["sourceTownshipTitle"] ?? "null";
        _destinationTitle =
            data["townshipsInfo"]["destTownshipTitle"] ?? "null";
        _seatCount = data["carDetails"]["carInfo"]["seatCount"] ?? 0;
        _rowCount = data["carDetails"]["carInfo"]["seatRowCount"] ?? 0;
        _columnCount = data["carDetails"]["carInfo"]["seatColumnCount"] ?? 0;
        _carTypeId = data["carDetails"]["carSchemaInfo"][0]["carTypeId"] ?? 0;

        _seats = <Seat>[];
        var busSeats = data["carDetails"]["carSchemaInfo"] as List;
        List<SeatClass> seatClasses = data["tripPrice"]
            .map<SeatClass>((json) => SeatClass.fromJson(json))
            .toList();

        busSeats.forEach((item) {
          SeatClass? _seatClass;

          for (var i = 0; i < seatClasses.length; i++) {
            if (seatClasses[i].classId == item["carSeatId"]) {
              _seatClass = seatClasses[i];
              break;
            } else {
              _seatClass = SeatClass(classId: 0, classTitle: '', seatPrice: 0);
            }
          }
          print('item["carLocationTypeId"] = ' +
              item["carLocationTypeId"].toString());
          _seats!.add(Seat(
              id: item['id'],
              gender: 0,
              name: "",
              familyName: "",
              nationalCode: "",
              available: item["carLocationTypeId"] == 6 ? 0 : 1,
              carLocationTypeId: item["carLocationTypeId"],
              colId: item["columnId"],
              rowId: item["rowId"],
              // seatClass: item["carSeatId"] == null ? null : _seatClass,
              seatClass: _seatClass,
              seatNumber: item["seatNumber"]));
        });

        var fixedSeats = data["fullSeats"] as List ;

        int searchCounter = 0;
        if (fixedSeats != null)
          for (int i = 0; i < _seats!.length; i++) {
            print(
                'searchCounter = $searchCounter | fixedSeats.length = ${fixedSeats.length}');
            if (searchCounter >= fixedSeats.length) break;
            fixedSeats.forEach((item) {
              if (_seats![i].seatNumber == item["seatNumber"]) {
                searchCounter++;
                _seats![i].available = 0;
                _seats![i].gender = item["genderId"];
              }
            });
          }

        sortList();
        return true;
        break;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        notifyListeners();
        return false;
    }
  }

  init(TravelDetailArgsNew travelDetailViewModelNew, BuildContext context,
      [bool isRefresh = false]) {
    if (!_shouldInit && !isRefresh) return;
    voucherCodeController = TextEditingController();

    _loading = true;
    _travelDetailArgsNew = travelDetailViewModelNew;

    MainViewModel _mainViewModel =
        Provider.of<MainViewModel>(context, listen: false);
    _adultCount = _mainViewModel.getCurrentQuantity;
    _childCount = _mainViewModel.childCurrentQuantity;
    print('init getTravelDetail');
    print('child Count $_childCount');
    print('adult Count $_adultCount');
    if (isRefresh) {
      print('refresh getTravelDetail');
      notifyListeners();
    }
    getTravelDetail(context).then((val) {
      _loading = false;
      _shouldInit = false;
      notifyListeners();
    });

    sharedPref.getTwoWay().then((value) {
      _isTwoWay = value;
      if (value) {
        _loadingReturn = true;
        getReturnTravelDetail(context).then((val) {
          _loadingReturn = false;
          _shouldInit = false;
          notifyListeners();
        });
      }
      notifyListeners();
    });
  }

  void sortList() {
    List<Seat> sList = <Seat>[];
    int index = 0;
    for (int i = 0; i < _rowCount!; i++)
      for (int j = 0; j < _rowCount!; j++) {
        for (var item in _seats!) {
          if (item.rowId == i && item.colId == j) {
            item.index = index;
            sList.add(item);
            index++;
            break;
          }
        }
      }
    _seats = sList;
    notifyListeners();
  }

  void sortListReturn() {
    List<Seat> sList = <Seat>[];
    int index = 0;
    for (int i = 1; i < _rowCountReturn! + 1; i++)
      for (int j = 1; j < _rowCountReturn! + 1; j++) {
        for (var item in _seatsReturn!) {
          if (item.rowId == i && item.colId == j) {
            item.index = index;
            sList.add(item);
            index++;
            break;
          }
        }
      }
    _seatsReturn = sList;
    notifyListeners();
  }

  int _currentPrice = 0;
  int get currentPrice => _currentPrice;

  void setSeat(int index, int gender, int available, BuildContext context) {
    _seats![index].gender = gender;
    _seats![index].available = available;
    _seats!.forEach((item) {
      // print("paymentDIIII ${item.index} ${item.available}");
    });
    _currentPrice = getSelectedSeatsPrice();
    notifyListeners();
    Navigator.pop(context);
  }

  int getChildSeatsCount() {
    int count = 0;
    count = _seats!
        .where((seat) => (seat.available == 2 && (seat.gender == 2)))
        .toList()
        .length;
    print('childCount = $count');
    return count;
  }

  int getAdultSeatCount() {
    int count = 0;
    count = _seats!
        .where((seat) =>
            (seat.available == 2 && (seat.gender == 0 || seat.gender == 1)))
        .toList()
        .length;
    print('adultCount = $count');
    return count;
  }

  void setSeatReturn(
      int index, int gender, int available, BuildContext context) {
    _seatsReturn![index].gender = gender;
    _seatsReturn![index].available = available;
    _seatsReturn!.forEach((item) {
      print("setSeatReturn ${item.index} ${item.available}");
    });
    _currentPrice = getSelectedSeatsPriceReturn();
    notifyListeners();
    Navigator.pop(context);
  }

  int getSelectedSeatsPrice() {
    int price = 0;
    try {
      for (Seat item in _seats!) {
        if (item.available == 2) price += item.seatClass!.seatPrice!;
      }
    } on Exception catch (e) {
      return 1;
    }
    return price;
  }

  int getSelectedSeatsPriceReturn() {
    int price = 0;
    if (_seatsReturn != null) {
      try {
        for (Seat item in _seatsReturn!) {
          if (item.available == 2) price += item.seatClass!.seatPrice!;
        }
      } on Exception catch (e) {
        return 1;
      }
    }

    return price;
  }

  bool _isBuying = false;
  bool get isBuying => _isBuying;

  Future<bool> getTicketId(BuildContext context) async {
    _isBuying = true;
    notifyListeners();
    List<Seat> selectedList = [];

    for (Seat item in _seats!) {
      if (item.available == 2) selectedList.add(item);
    }

    if (selectedList.length < 1) {
      notifyListeners();
      print('seat is not chosen');
      showInfoFlushbar(context, "حداقل یک صندلی انتخاب کنید",
          "حداقل یک صندلی انتخاب کنید", false,
          durationSec: 2);
      return false;
    }
    print('seat count = ${selectedList.length}');

    bool go = await getTicketIdReturn(context);
    if (!go) return false;

    http.Response result;
    try {
      if (authServiceType == AuthServiceType.mock) {
        result = await MockWebservice().getTravelTicketId(
            _travelDetailArgsNew!.travelId!,
            _travelDetailArgsNew!.sourceId!,
            _travelDetailArgsNew!.destinationId!,
            selectedList);
      } else {
        result = await Webservice().getTravelTicketId(
            _travelDetailArgsNew!.travelId!,
            _travelDetailArgsNew!.sourceId ?? 1018,
            _travelDetailArgsNew!.destinationId ?? 128,
            selectedList);
      }
      print("getTicketId $result");
    } on Exception catch (e) {
      showInfoFlushbar(context, dialogErrorSTR, "خطای سرور", false,
          durationSec: 2);
      _isBuying = false;
      notifyListeners();
      return false;
    }

    final bodyResponse = json.decode(result.body);
    print("bodyResponseGetTicketId $bodyResponse");
    int statusCode;
    var data;

    statusCode = result.statusCode;

    print(statusCode);

    _isBuying = false;
    notifyListeners();
    switch (statusCode) {
      case 404:
        init(_travelDetailArgsNew!, context, true);
        showInfoFlushbar(context, bodyResponse["message"] ?? dialogErrorSTR,
            bodyResponse["message"] ?? 'خطای سرور', false,
            durationSec: 4);
        sharedPref.setLogout(context);
        notifyListeners();
        return false;
        break;
      case 400:
        print('status 400, just init pls');
        init(_travelDetailArgsNew!, context, true);
        showInfoFlushbar(context, bodyResponse["message"] ?? dialogErrorSTR,
            bodyResponse["message"] ?? 'خطای سرور', false,
            durationSec: 4);
        notifyListeners();
        return false;
        break;
      case 403:
        showInfoFlushbar(context, dialogErrorSTR,
            'صندلی انتخاب شده قابل انتخاب نمی‌باشد', false,
            durationSec: 2);
        notifyListeners();
        return false;
        break;

      case 401:
        showInfoFlushbar(
            context, "لطفا دوباره وارد شوید", "لطفا دوباره وارد شوید", false,
            durationSec: 4);
        notifyListeners();
        sharedPref.setLogout(context);
        return false;
        break;
      case 200:
        //var data = bodyResponse["data"] ?? null;
        data = bodyResponse;

        if (data == null) {
          showInfoFlushbar(context, dialogErrorSTR,
              bodyResponse["message"] ?? 'خطای سرور', false,
              durationSec: 2);
          notifyListeners();
          return false;
        }

        _ticketId = data["ticketId"];
        // print("getTicketIdgetTicketId ${_ticketId}");
        notifyListeners();
        await getTicketInvoice(context);

        return true;
        break;
      default:
        showInfoFlushbar(
            context,
            bodyResponse["message"] == "Unauthorized!"
                ? "لطفا دوباره وارد شوید"
                : dialogErrorSTR,
            "",
            false,
            durationSec: 2);
        notifyListeners();
        return false;
    }
  }

  Future<bool> getTicketIdReturn(BuildContext context) async {
    if (!_isTwoWay) return true;
    int qnty = await sharedPref.getQnty();
    List<Seat> selectedListReturn = <Seat>[];
    for (Seat item in _seatsReturn!) {
      if (item.available == 2) selectedListReturn.add(item);
    }

    if (selectedListReturn.length < 1) {
      notifyListeners();
      showInfoFlushbar(context, "حداقل یک صندلی برگشت انتخاب کنید",
          "حداقل یک صندلی برگشت انتخاب کنید", false,
          durationSec: 2);
      return false;
    }

    if (selectedListReturn.length != qnty) {
      notifyListeners();
      showInfoFlushbar(context, "تعداد صندلی های انتخاب مجاز نیست",
          "تعداد صندلی های انتخاب مجاز نیست", false,
          durationSec: 2);
      return false;
    }

    var result;
    try {
      if (authServiceType == AuthServiceType.mock) {
        result = await MockWebservice().getTravelTicketId(
            _travelDetailArgsNew!.travelIdReturn!,
            _travelDetailArgsNew!.destinationId!,
            _travelDetailArgsNew!.sourceId!,
            selectedListReturn);
      } else {
        result = await Webservice().getTravelTicketId(
            _travelDetailArgsNew!.travelIdReturn!,
            _travelDetailArgsNew!.destinationId!,
            _travelDetailArgsNew!.sourceId!,
            selectedListReturn);
      }
      print("getTicketIdReturn $result");
    } on Exception catch (e) {
      showInfoFlushbar(
          context, "خطای سرور بلیط برگشت", "خطای سرور بلیط برگشت", false,
          durationSec: 2);
      return false;
    }

    final bodyResponse = json.decode(result);
    print("bodyResponseGetTicketIdReturn $bodyResponse");

    String statusCode = bodyResponse["status"];

    print(statusCode);

    switch (statusCode) {
      case "404":
        showInfoFlushbar(context, dialogErrorSTR, "خطای توکن", false,
            durationSec: 2);
        sharedPref.setLogout(context);
        notifyListeners();
        return false;
        break;
      case "403":
        showInfoFlushbar(context, "صندلی انتخاب شده برگشت قابل خرید نمی باشد.",
            "صندلی انتخاب شده برگشت قابل خرید نمی باشد.", false,
            durationSec: 2);
        notifyListeners();
        return false;
        break;
      case "201":
        var data = bodyResponse["data"];
        if (data == null) {
          showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
          notifyListeners();
          return false;
        }
        _ticketIdReturn = data["created ticket_id"];
        print("getTicketIdgetTicketIdReturn ${_ticketId}");
        notifyListeners();
        return true;
        break;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        notifyListeners();
        return false;
    }
  }

  Future<bool> getTicketInvoice(BuildContext context) async {
    http.Response response;
    try {
      if (authServiceType == AuthServiceType.mock) {
        response = await MockWebservice().getTravelTicketInvoice(_ticketId!,
            _ticketIdReturn, voucherCodeController!.text);
      } else {
        response = await Webservice().getTravelTicketInvoice(_ticketId!,
            _ticketIdReturn, voucherCodeController!.text);
      }
      print("getTicketInvoice $response");
    } on Exception catch (e) {
      showInfoFlushbar(context, dialogErrorSTR, "خطای سرور", false,
          durationSec: 2);
      return false;
    }

    var bodyResponse = jsonDecode(response.body);

    switch (response.statusCode) {
      case 401:
        showInfoFlushbar(context,
            bodyResponse["message"] ?? dialogErrorSTR, "", false,
            durationSec: 2);
        notifyListeners();
        return false;
        break;
      case 200:
        var data = bodyResponse;
        if (data == null) {
          showInfoFlushbar(context,
              bodyResponse["message"] ?? dialogErrorSTR, "", false,
              durationSec: 2);
          notifyListeners();
          return false;
        }
        List<Seat> selectedList = [];

        for (Seat item in _seats!) {
          if (item.available == 2) selectedList.add(item);
        }
        print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX: ${_sourcePoint}');
        _invoiceArgs = InvoiceArgs();
        _invoiceArgs.invoiceTotal = data["price"] ?? 0;
        _invoiceArgs.amount = data["amount"] ?? data["price"] ?? 0;
        _invoiceArgs.returnAmount = data["returnPrice"] ?? data["price"] ?? 0;
        _invoiceArgs.discountAmount =
            data["discountedPrice"] ?? data["price"] ?? 0;
        _invoiceArgs.destinationName = _destinationTitle;
        _invoiceArgs.sourceName = _sourceTitle;
        _invoiceArgs.ticketId = _ticketId;
        _invoiceArgs.ticketIdReturn = _ticketIdReturn ?? 0;
        _invoiceArgs.sourcePoint = _sourcePoint;
        _invoiceArgs.destinationPoint = _destinationPoint;
        _invoiceArgs.seats = selectedList;
        _invoiceArgs.orderId = data["orderId"];

        List<String> userInfoList = [];
        try {
          userInfoList = await getUserInfo();
          String name = (userInfoList[0] == null
                  ? ''
                  : userInfoList[0] == 'null'
                      ? ''
                      : userInfoList[0]) +
              ' ' +
              (userInfoList[1] == null
                  ? ''
                  : userInfoList[1] == 'null'
                      ? ''
                      : userInfoList[1]);
          _invoiceArgs.todayDate = PersianDate().getNow;
          _invoiceArgs.fullName = name;
        } catch (e) {}
        notifyListeners();
        // _seats.forEach((item) {
        //   print("pushnamee111e ${item.available}");
        // });

        return true;
        break;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        notifyListeners();
        return false;
    }
  }

  List<Seat> get seats => _seats!;

  void setSeats(List<Seat> value) {
    _seats = value;
    notifyListeners();
  }

  TravelDetailArgsNew get travelDetailArgsNew => _travelDetailArgsNew!;

  void setTravelDetailArgsNew(TravelDetailArgsNew value) {
    _travelDetailArgsNew = value;
    notifyListeners();
  }

  get carTypeId => _carTypeId;

  void setCarTypeId(value) {
    _carTypeId = value;
    notifyListeners();
  }

  get columnCount => _columnCount;

  void setColumnCount(value) {
    _columnCount = value;
    notifyListeners();
  }

  get rowCount => _rowCount;

  void setRowCount(value) {
    _rowCount = value;
    notifyListeners();
  }

  int get seatCount => _seatCount!;

  void setSeatCount(int value) {
    _seatCount = value;
    notifyListeners();
  }

  String get destinationTitle => _destinationTitle ?? ' ';

  void setDestinationTitle(String value) {
    _destinationTitle = value;
    notifyListeners();
  }

  String get sourceTitle => _sourceTitle ?? ' ';

  void setSourceTitle(String value) {
    _sourceTitle = value;
    notifyListeners();
  }

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

  bool get loading => _loading!;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<bool> getReturnTravelDetail(BuildContext context) async {
    var result;
    try {
      if (authServiceType == AuthServiceType.mock) {
        result = await MockWebservice().getTravelDetails(
          _travelDetailArgsNew!.travelIdReturn!,
          _travelDetailArgsNew!.destinationId!,
          _travelDetailArgsNew!.sourceId!,
        );
      } else {
        result = await Webservice().getTravelDetails(
          _travelDetailArgsNew!.travelIdReturn!,
          _travelDetailArgsNew!.destinationId!,
          _travelDetailArgsNew!.sourceId!,
        );
      }
      print("getReturnTravelDetail $result");
    } on Exception catch (e) {
      showInfoFlushbar(context, dialogErrorSTR, "خطای سرور", false,
          durationSec: 2);
      return false;
    }
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
          showInfoFlushbar(context, "اظلاعاتی برای نمایش وجود ندارد",
              "اظلاعاتی برای نمایش وجود ندارد", false,
              durationSec: 2);
          notifyListeners();
          return false;
        }
        _sourcePointReturn = LatLng(
            data["TownshipsInfo"]["sourceTownshipLat"] * 1.0 ?? 0.0,
            data["TownshipsInfo"]["sourceTownshipLon"] * 1.0 ?? 0.0);
        _mapControllerReturn = MapController();
        _destinationPointReturn = LatLng(
            data["TownshipsInfo"]["destTownshipLat"] * 1.0 ?? 0.0,
            data["TownshipsInfo"]["destTownshipLon"] * 1.0 ?? 0.0);
        _currentPointReturn = _destinationPointReturn;
        _sourceTitleReturn =
            data["TownshipsInfo"]["sourceTownshipTitle"] ?? "null";
        _destinationTitleReturn =
            data["TownshipsInfo"]["destTownshipTitle"] ?? "null";
        _seatCountReturn = data["CarInfo"]["Car"]["seatCount"] ?? 0;
        _rowCountReturn = data["CarInfo"]["Car"]["seatRowCount"] ?? 0;
        _columnCountReturn = data["CarInfo"]["Car"]["seatColumnCount"] ?? 0;
        _carTypeIdReturn = data["CarInfo"]["Schema"][0]["carTypeId"] ?? 8;

        _seatsReturn = <Seat>[];
        var busSeats = data["CarInfo"]["Schema"] as List;
        List<SeatClass> seatClasses = data["TripPrice"]
            .map<SeatClass>((json) => SeatClass.fromJson(json))
            .toList();
        busSeats.forEach((item) {
          SeatClass? _seatClass;

          for (var i = 0; i < seatClasses.length; i++) {
            // print('seatClass $i = ' + seatClasses[i].toString());
            if (seatClasses[i].classId == item["carSeatId"]) {
              _seatClass = seatClasses[i];
              break;
            }
          }

          _seats!.add(Seat(
              gender: 0,
              name: "",
              familyName: "",
              nationalCode: "",
              available: item["carLocationTypeId"] == 6 ? 0 : 1, // 0: Deactive 1: Active
              carLocationTypeId: item["carLocationTypeId"],
              colId: item["columnId"],
              rowId: item["rowId"],
              seatNumber: item["seatNumber"],
              seatClass: item["carSeatId"] == null ? null : _seatClass));
        });

        var fixedSeats = data["FullSeats"] as List;
        int searchCounter = 0;
        if (fixedSeats != null)
          for (int i = 0; i < _seatsReturn!.length; i++) {
            if (searchCounter >= fixedSeats.length) break;
            fixedSeats.forEach((item) {
              if (_seatsReturn![i].seatNumber == item["seatNumber"]) {
                searchCounter++;
                _seatsReturn![i].available = 0;
                _seatsReturn![i].gender = item["genderId"];
              }
            });
          }
        sortListReturn();
        return true;
        break;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        notifyListeners();
        return false;
    }
  }

  LatLng get destinationPointReturn => _destinationPointReturn!;

  void setDestinationPointReturn(LatLng value) {
    _destinationPointReturn = value;
    notifyListeners();
  }

  bool get loadingReturn => _loadingReturn!;

  void setLoadingReturn(bool value) {
    _loadingReturn = value;
    notifyListeners();
  }

  String get sourceTitleReturn => _sourceTitleReturn!;

  void setSourceTitleReturn(String value) {
    _sourceTitleReturn = value;
    notifyListeners();
  }

  String get destinationTitleReturn => _destinationTitleReturn!;

  void setDestinationTitleReturn(String value) {
    _destinationTitleReturn = value;
    notifyListeners();
  }

  int get ticketIdReturn => _ticketIdReturn!;

  void setTicketIdReturn(int value) {
    _ticketIdReturn = value;
    notifyListeners();
  }

  int get seatCountReturn => _seatCountReturn!;

  void setSeatCountReturn(int value) {
    _seatCountReturn = value;
    notifyListeners();
  }

  get rowCountReturn => _rowCountReturn;

  void setRowCountReturn(value) {
    _rowCountReturn = value;
    notifyListeners();
  }

  get columnCountReturn => _columnCountReturn;

  void setColumnCountReturn(value) {
    _columnCountReturn = value;
    notifyListeners();
  }

  get carTypeIdReturn => _carTypeIdReturn;

  void setCarTypeIdReturn(value) {
    _carTypeIdReturn = value;
    notifyListeners();
  }

  List<Seat>? get seatsReturn => _seatsReturn;

  void setSeatsReturn(List<Seat> value) {
    _seatsReturn = value;
    notifyListeners();
  }

  List<bool> get toggleListReturn => _toggleListReturn!;

  void setToggleListReturn(List<bool> value) {
    _toggleListReturn = value;
    notifyListeners();
  }

  LatLng get currentPointReturn => _currentPointReturn!;

  void setCurrentPointReturn(LatLng value) {
    _currentPointReturn = value;
    notifyListeners();
  }

  MapController get mapControllerReturn => _mapControllerReturn!;

  void setMapControllerReturn(MapController value) {
    _mapControllerReturn = value;
    notifyListeners();
  }

  IconData getGenderIcon(int gender) {
    switch (gender) {
      case 0:
        return MdiIcons.humanFemale;
        break;
      case 1:
        return MdiIcons.humanMale;
        break;
      case 2:
        return Icons.child_care;
        break;
      default:
        return Icons.help_outline_rounded;
        break;
    }
  }
}
