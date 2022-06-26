import 'package:ebus/core/models/SeatClass.dart';

class Seat {
  int? available;
  String? name, familyName, nationalCode;
  int? seatNumber, gender, id, rowId, colId, carLocationTypeId, index;
  SeatClass? seatClass;

  Seat(
      {this.available,
      this.name,
      this.familyName,
      this.nationalCode,
      this.seatNumber,
      this.gender,
      this.id,
      this.rowId,
      this.colId,
      this.carLocationTypeId,
      this.seatClass});

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
        name: json["name"] ?? "بدون نام",
        familyName: json["familyName"] ?? "بدون نام خانوادگی",
        nationalCode: json["nationalCode"] ?? 0,
        gender: json["man"] ?? 0,
        available: json["available"] ?? 0,
        seatNumber: json["seatNumber"] ?? 0,
        seatClass: SeatClass.fromJson(json["seatClass"]));
  }
}
