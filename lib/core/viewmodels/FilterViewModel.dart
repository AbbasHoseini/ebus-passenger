import 'package:ebus/core/models/Bus.dart';
import 'package:ebus/core/models/ResultArgs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FilterViewModel with ChangeNotifier {
  ResultArgs? resultArgs;

  double _minPrice = 0;
  double _maxPrice = 10000000;

  double _departureTime = 0;
  double _arrivalTime = 24.0;

  double get minPrice => _minPrice;
  double get maxPrice => _maxPrice;

  double get departureTime => _departureTime;
  double get arrivalTime => _arrivalTime;

  bool _vipChecked = true;
  bool _casualChecked = true;

  bool get vipChecked => _vipChecked;
  bool get casualChecked => _casualChecked;

  void setVipChecked(bool val) {
    _vipChecked = val;
    if (!_vipChecked && !_casualChecked) _casualChecked = true;
    notifyListeners();
  }

  void setCasualChecked(bool val) {
    _casualChecked = val;
    if (!_vipChecked && !_casualChecked) _vipChecked = true;
    notifyListeners();
  }

  void setDepartureTime(double val) {
    _departureTime = val;
    notifyListeners();
  }

  void setArrivalTime(double val) {
    _arrivalTime = val;
    notifyListeners();
  }

  void setMinPrice(double val) {
    _minPrice = val;
    notifyListeners();
  }

  void setMaxPrice(double val) {
    _maxPrice = val;
    notifyListeners();
  }

  void setArg(ResultArgs resultArgs) {
    this.resultArgs = resultArgs;
    // notifyListeners();
  }

  ResultArgs getFilteredList() {
    List<Bus> busList = <Bus>[];
    double gTime, gPrice;
    bool gBusTypeVip;
    for (int i = 0; i < resultArgs!.busList!.length; i++) {
      print(
          "asasd ${resultArgs!.busList![i].departureDateTime!.substring(11, 13)}.${resultArgs!.busList![i].departureDateTime!.substring(14, 16)}");
      gTime = double.parse(
          '${resultArgs!.busList![i].departureDateTime!.substring(11, 13)}.${resultArgs!.busList![i].departureDateTime!.substring(14, 16)}');
      gPrice = resultArgs!.busList![i].basePrice!.toDouble();
      gBusTypeVip = resultArgs!.busList![i].carTypeTitle!.contains('VIP');

      if (gTime >= _departureTime && gTime <= _arrivalTime) {
        if (gPrice >= _minPrice && gPrice <= _maxPrice) {
          if (_casualChecked && _vipChecked) {
            busList.add(resultArgs!.busList![i]);
          } else if (_casualChecked && !_vipChecked) {
            if (!gBusTypeVip) busList.add(resultArgs!.busList![i]);
          } else {
            if (gBusTypeVip) busList.add(resultArgs!.busList![i]);
          }
        }
      }
    }
    resultArgs!.busList = busList;
    return resultArgs!;
  }
}
