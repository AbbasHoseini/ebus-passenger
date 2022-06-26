import 'dart:convert';
import 'package:ebus/helpers/HelperFunctions.dart';

class Passenger {
  int? id, genderId, seatNumber, travelTicketId;
  String? passengerName, nationalCode, passangerFamily;

  
  int? checkIn, checkOut;

  DateTime? createTime;

  Passenger({
    this.id,
    this.travelTicketId,
    this.passengerName,
    this.nationalCode,
    this.genderId,
    this.seatNumber,
    this.checkIn,
    this.checkOut,
    this.createTime,
    this.passangerFamily,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'travel_ticket_id': travelTicketId,
      'passenger_name': passengerName,
      'national_code': nationalCode,
      'gender_id': genderId,
      'seat_number': seatNumber,
      'check_in': checkIn,
      'check_out': checkOut,
      'create_time': createTime?.millisecondsSinceEpoch,
      'passanger_family': passangerFamily,
    };
  }

  factory Passenger.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Passenger(
      id: map['id'],
      travelTicketId: map['travelTicketId'],
      passengerName: map['passengerFirstName'],
      nationalCode: map['passengerNationalCode'],
      genderId: map['genderId'],
      seatNumber: map['seatNumber'],
      checkIn: map['checkIn'] ,
      checkOut: map['checkOut'],
      createTime: convertToDateWithTime(map['createdAt']),
      passangerFamily: map['passengerLastName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Passenger.fromJson(String source) =>
      Passenger.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Passenger(id: $id, travel_ticket_id: $travelTicketId, passenger_name: $passengerName, national_code: $nationalCode, gender_id: $genderId, seat_number: $seatNumber, check_in: $checkIn, check_out: $checkOut, create_time: $createTime, passanger_family: $passangerFamily)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Passenger &&
        o.id == id &&
        o.travelTicketId == travelTicketId &&
        o.passengerName == passengerName &&
        o.nationalCode == nationalCode &&
        o.genderId == genderId &&
        o.seatNumber == seatNumber &&
        o.checkIn == checkIn &&
        o.checkOut == checkOut &&
        o.createTime == createTime &&
        o.passangerFamily == passangerFamily;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        travelTicketId.hashCode ^
        passengerName.hashCode ^
        nationalCode.hashCode ^
        genderId.hashCode ^
        seatNumber.hashCode ^
        checkIn.hashCode ^
        checkOut.hashCode ^
        createTime.hashCode ^
        passangerFamily.hashCode;
  }
}
