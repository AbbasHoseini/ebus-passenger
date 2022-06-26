import 'dart:convert';

import 'package:ebus/helpers/HelperFunctions.dart';
import 'package:flutter/foundation.dart';

import 'Passenger.dart';

class CurrentTravel {
  DateTime? departureDatetime;
  double? srcLat, srcLon, destLat, destLon;
  String? destTitle, srcTitle, plaqueNumber, primaryDriverFirstName, primaryDriverLastName, primaryServantFirstName,
  primaryServantLastName, passengerSupervisorName, qrcode;
  List<Passenger>? listOfPassanger;
  int? ticketId, orginalPrice;

  CurrentTravel(
      {this.departureDatetime,
      this.srcLat,
      this.srcLon,
      this.destLat,
      this.destLon,
      this.plaqueNumber,
      this.primaryDriverFirstName,
      this.primaryDriverLastName,
      this.primaryServantFirstName,
      this.primaryServantLastName,
      this.listOfPassanger,
      this.srcTitle,
      this.destTitle,
      this.ticketId,
      this.passengerSupervisorName,
      this.orginalPrice,
      this.qrcode});

  Map<String, dynamic> toMap() {
    return {
      'departure_datetime': departureDatetime?.millisecondsSinceEpoch,
      'src_lat': srcLat,
      'src_lon': srcLon,
      'dest_lat': destLat,
      'dest_lon': destLon,
      'plaque_number': plaqueNumber,
      'primary_driver_first_name': primaryDriverFirstName,
      'primary_driver_last_name': primaryDriverLastName,
      'primary_servant_first_name': primaryServantFirstName,
      'primary_servant_last_name': primaryServantLastName,
      'list_of_passanger': listOfPassanger?.map((x) => x.toMap()).toList(),
      'src_title': srcTitle,
      'dest_title': destTitle,
      'ticket_id': ticketId,
      'passenger_supervisor_name': passengerSupervisorName,
      'orginal_price': orginalPrice,
      'qrcode': qrcode,
    };
  }

  factory CurrentTravel.fromMap(Map<String, dynamic> map) {
    // if (map == null) {
    //   return null;
    // }

    return CurrentTravel(
      departureDatetime: convertToDateWithTime(map['departureDatetime']),
      srcLat: map['sourceSpanData'] == null
          ? null
          : map['sourceSpanData']['coordinates'][0] ?? 0 * 1.0,
      srcLon: map['sourceSpanData'] == null
          ? null
          : map['sourceSpanData']['coordinates'][1] ?? 0 * 1.0,
      destLat: map['desSpanData'] == null
          ? null
          : map['desSpanData']['coordinates'][0] ?? 0 * 1.0,
      destLon: map['desSpanData'] == null
          ? null
          : map['desSpanData']['coordinates'][1] ?? 0 * 1.0,
      plaqueNumber: map['plateNumber'],
      primaryDriverFirstName: map['driverFirstName'],
      primaryDriverLastName: map['driverLastName'],
      // primaryServantFirstName: map['primary_servant_first_name'],
      // primaryServantLastName: map['primary_servant_last_name'],
      listOfPassanger: List<Passenger>.from(
          map['listOfPassenger']?.map((x) => Passenger.fromMap(x))),
      srcTitle: map['sourceTitle'],
      destTitle: map['destTitle'],
      ticketId: map['ticketId'],
      passengerSupervisorName: map['passengerSupervisorName'] ?? '',
      orginalPrice: map['orginalPrice'],
      qrcode: map['qrCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentTravel.fromJson(source) => CurrentTravel.fromMap(source);

  @override
  String toString() {
    return 'CurrentTravel(departure_datetime: $departureDatetime, src_lat: $srcLat, src_lon: $srcLon, dest_lat: $destLat, dest_lon: $destLon, plaque_number: $plaqueNumber, primary_driver_first_name: $primaryDriverFirstName, primary_driver_last_name: $primaryDriverLastName, primary_servant_first_name: $primaryServantFirstName, primary_servant_last_name: $primaryServantLastName, list_of_passanger: $listOfPassanger, src_title: $srcTitle, dest_title: $destTitle)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CurrentTravel &&
        o.departureDatetime == departureDatetime &&
        o.srcLat == srcLat &&
        o.srcLon == srcLon &&
        o.destLat == destLat &&
        o.destLon == destLon &&
        o.plaqueNumber == plaqueNumber &&
        o.primaryDriverFirstName == primaryDriverFirstName &&
        o.primaryDriverLastName == primaryDriverLastName &&
        o.primaryServantFirstName == primaryServantFirstName &&
        o.primaryServantLastName == primaryServantLastName &&
        listEquals(o.listOfPassanger, listOfPassanger) &&
        o.srcTitle == srcTitle &&
        o.destTitle == destTitle;
  }

  @override
  int get hashCode {
    return departureDatetime.hashCode ^
        srcLat.hashCode ^
        srcLon.hashCode ^
        destLat.hashCode ^
        destLon.hashCode ^
        plaqueNumber.hashCode ^
        primaryDriverFirstName.hashCode ^
        primaryDriverLastName.hashCode ^
        primaryServantFirstName.hashCode ^
        primaryServantLastName.hashCode ^
        listOfPassanger.hashCode ^
        srcTitle.hashCode ^
        destTitle.hashCode;
  }
}
