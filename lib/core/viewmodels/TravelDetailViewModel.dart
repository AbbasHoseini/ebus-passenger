import 'dart:convert';

import 'package:ebus/UI/widgets/SeatGenderDialog.dart';
import 'package:ebus/core/models/InvoiceArgs.dart';
import 'package:ebus/core/models/Seat.dart';
import 'package:ebus/core/models/TravelDetailsArgs.dart';
import 'package:ebus/core/services/Webservice.dart';
import 'package:ebus/helpers/Constants.dart';
import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TravelDetailViewModel with ChangeNotifier {
  bool? _loading;
  String _sourceName = "";
  String _destinationName = "";
  int? _priceEstimate = 10000, basePrice;
  LatLng _sourcePoint = LatLng(35.6892, 51.3890);
  LatLng _destinationPoint = LatLng(36.6830, 48.5087);
  MapController _mapSourceController = MapController();
  MapController _mapDestinationController = MapController();
  List<Seat> _seatList = [];
  int _currentSeatNumber = 0;
  int? _seatCount, _rowCount;

  InvoiceArgs? _invoiceArgs;

  InvoiceArgs get invoiceArgs => _invoiceArgs!;

  bool get loading => _loading!;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setInvoiceArgs(InvoiceArgs value) {
    _invoiceArgs = value;
    notifyListeners();
  }

  List<Seat> get seatList => _seatList;

  List<Widget>? columnRows;
  List<Widget>? columnRowsItems;

  List<Seat> sortedList(TravelDetailsArgs travelDetailsArgs) {
    List<Seat> sList = <Seat>[];
    int index = 0;
    for (int i = 1; i < travelDetailsArgs.rowCount! + 1; i++)
      for (int j = 1; j < travelDetailsArgs.rowCount! + 1; j++) {
        for (var item in travelDetailsArgs.seatList!) {
          if (item.rowId == i && item.colId == j) {
            item.index = index;
            sList.add(item);
            index++;
            break;
          }
        }
      }
    print(
        "sList.length ${sList.length} seatList.length ${travelDetailsArgs.seatList!.length}");
    return sList;
  }

  List<Widget> getSortedListWidget(
      TravelDetailsArgs travelDetailsArgs,
      double myWidth,
      TravelDetailViewModel travelDetailViewModel,
      bool sort,
      BuildContext context) {
    _sourcePoint =
        LatLng(travelDetailsArgs.sourceLat!, travelDetailsArgs.sourceLong!);
    _destinationPoint =
        LatLng(travelDetailsArgs.destLat!, travelDetailsArgs.destLong!);
    setSourceName(travelDetailsArgs.sourceName!);
    destinationName = travelDetailsArgs.destinationName!;
    if (sort) travelDetailsArgs.seatList = sortedList(travelDetailsArgs);
    _seatList = travelDetailsArgs.seatList!;
    columnRows = <Widget>[];
    columnRowsItems = <Widget>[];
    int index = 0;
    for (var seat in travelDetailsArgs.seatList!) {
      Color seatColor;
      if (seat.available == 1)
        seatColor = colorAccent;
      else if (seat.available == 0)
        seatColor = Colors.black12;
      else {
        seatColor = Colors.orange;
      }

      var door = Padding(
        padding: EdgeInsets.all(10.0),
        child: Image(
          width: myWidth / 4 * 0.6,
          height: myWidth / 4 * 0.6,
          fit: BoxFit.contain,
          color: Colors.black45,
          key: Key("exit"),
          image: AssetImage('images/exit.png'),
        ),
      );

      var availableSeat = Padding(
        padding: EdgeInsets.all(10),
        child: InkWell(
          child: Stack(
            children: <Widget>[
              Image(
                width: myWidth / 4 * 0.6,
                height: myWidth / 4 * 0.6,
                fit: BoxFit.contain,
                color: seatColor,
                image: AssetImage('images/seatnew.png'),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "${seat.seatNumber}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: colorTextTitle,
                        fontSize: textFontSizeSub,
                        fontFamily: 'Sans'),
                  ),
                ),
              ),
            ],
          ),
          onTap: () {
            if (seat.available == 0) {
              showInfoFlushbar(context, seatChooseError, seatChooseError, false,
                  durationSec: 2);
            } else {
              print("SeatGenderDialog index ${seat.index}");
              //TODO changes
              /*showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                SeatGenderDialog(travelDetailsArgs, seat.index));*/
              //travelDetailsArgs, myWidth, travelDetailViewModel, true, context
            }
          },
        ),
      );

      var emptySpace = Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          width: myWidth / 4 * 0.6,
          height: myWidth / 4 * 0.6,
        ),
      );

      var driverSeat = Center(
        child: Image(
          width: myWidth / 4 * 0.6,
          height: myWidth / 4 * 0.6,
          fit: BoxFit.contain,
          color: Colors.black45,
          key: Key("steer"),
          image: AssetImage('images/steer_wheel.png'),
        ),
      );

      if (seat.carLocationTypeId == 4) {
        columnRowsItems!.add(driverSeat);
      } else if (seat.carLocationTypeId == 3 || seat.carLocationTypeId == 6) {
        columnRowsItems!.add(availableSeat);
      } else if (seat.carLocationTypeId == 1) {
        columnRowsItems!.add(door);
      } else {
        columnRowsItems!.add(emptySpace);
      }

      if (travelDetailsArgs.colCount! <= columnRowsItems!.length) {
        print("travelDetailsArgs.colCount ${travelDetailsArgs.colCount}");
        columnRowsItems = columnRowsItems!.reversed.toList();
        columnRowsItems!.add(SizedBox(
          height: 5,
        ));
        columnRows!.add(Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: columnRowsItems!,
          ),
        ));
        columnRowsItems = <Widget>[];
      }
      index++;
    }

    notifyListeners();
    return columnRows!;
  }

  void setSeatList(List<Seat> value) {
    //_currentSeatNumber = 0;
    _seatList = value;
    notifyListeners();
  }

  int? _ticket_id;

  int get ticket_id => _ticket_id!;

  void setTicket_id(int value) {
    _ticket_id = value;
  }

  int currentSeatNumberPlus(int i) {
    seatList[i].seatNumber = _currentSeatNumber + 1;
    if (_currentSeatNumber + 1 > seatList.length - 6) _currentSeatNumber = 0;
    return ++_currentSeatNumber;
  }

  int get currentSeatNumber => _currentSeatNumber;

  void setCurrentSeatNumber(int value) {
    _currentSeatNumber = value;
    notifyListeners();
  }

  var voucherCodeController = TextEditingController();

  String get sourceName => _sourceName;

  void setSourceName(String value) {
    _sourceName = value;
    notifyListeners();
  }

  String get destinationName => _destinationName;

  set destinationName(String value) {
    _destinationName = value;
  }

  LatLng get sourcePoint => _sourcePoint;

  set sourcePoint(LatLng value) {
    _sourcePoint = value;
    notifyListeners();
  }

  LatLng get destinationPoint => _destinationPoint;

  set destinationPoint(LatLng value) {
    _destinationPoint = value;
    notifyListeners();
  }

  MapController get mapSourceController => _mapSourceController;

  set mapSourceController(MapController value) {
    _mapSourceController = value;
    notifyListeners();
  }

  MapController get mapDestinationController => _mapDestinationController;

  set mapDestinationController(MapController value) {
    _mapDestinationController = value;
    notifyListeners();
  }

  int priceEstimate(int value) {
    basePrice = value;
    return _priceEstimate! * getSelectedSeatsCount();
  }

  void setPriceEstimate(int value) {
    _priceEstimate = value;
    notifyListeners();
  }

  int getSelectedSeatsCount() {
    int count = 0;
    try {
      for (Seat item in seatList) {
        if (item.available == 2) count++;
      }
    } on Exception catch (e) {
      return 1;
    }
    return count;
  }

  Future<bool> getTicketId(
      int sourceId, int destId, int travelId, BuildContext context) async {
    List<Seat> selectedList = <Seat>[];
    for (Seat item in seatList) {
      if (item.available == 2) selectedList.add(item);
    }
    print("asddvvvc ${selectedList.length} asdsd ${seatList.length}");

    final result = await Webservice()
        .getTravelTicketId(travelId, sourceId, destId, selectedList);
    print("getTicketId $result");

    final bodyResponse = json.decode(result.body);
    String statusCode = bodyResponse["status"];
    print(statusCode);

    switch (statusCode) {
      case "404":
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        notifyListeners();
        return false;
        break;
      case "403":
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        notifyListeners();
        return false;
        break;
      case "201":
        var data = bodyResponse["data"] ?? null;
        if (data == null) {
          showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
          notifyListeners();
          return false;
        }
        _ticket_id = data["created ticket_id"];
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
    final result = await Webservice().getTravelTicketInvoice(
        ticket_id, ticket_id, voucherCodeController.text);
    print("getTicketInvoice $result");

    final bodyResponse = json.decode(result.body);
    String statusCode = bodyResponse["status"];
    print(statusCode);

    switch (statusCode) {
      case "404":
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        notifyListeners();
        return false;
      case "200":
        var data = bodyResponse["data"] ?? null;
        if (data == null) {
          showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
          notifyListeners();
          return false;
        }
        print('getTicketInvoice ranned::::');
        print('gggggggggggggggggggggggggggg ${data}');
        _invoiceArgs = InvoiceArgs();
        _invoiceArgs!.invoiceTotal = data["amount"] ?? 0;
        _invoiceArgs!.discountAmount = data["discounted_amount"] ?? 0;
        _invoiceArgs!.destinationName = _destinationName;
        _invoiceArgs!.sourceName = _sourceName;
        _invoiceArgs!.ticketId = _ticket_id;
        notifyListeners();
        return true;
      default:
        showInfoFlushbar(context, dialogErrorSTR, "", false, durationSec: 2);
        notifyListeners();
        return false;
    }
  }

  init() {}
}
