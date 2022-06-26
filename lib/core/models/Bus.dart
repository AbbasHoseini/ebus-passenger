class Bus {
  int? travelId,
      basePrice,
      emptySeatCount,
      durationMinute,
      sourceTownshipId,
      destTownshipId,
      seatCount,
      id,
      durationOverDistance,
      distanceFromSource;
  bool? isMidWay;
  String? ridingTime,
      arrivedTime,
      directionSourceTitle,
      directionDestTitle,
      departureDateTime,
      carTypeTitle,
      shamsiDate,
      sourceTownshipTitle,
      travelDate;

  Bus({
    this.travelId,
    this.departureDateTime,
    this.basePrice,
    this.carTypeTitle,
    this.emptySeatCount,
    this.durationMinute,
    this.isMidWay,
    this.sourceTownshipId,
    this.destTownshipId,
    this.travelDate,
    this.seatCount,
    this.id,
    this.durationOverDistance,
    this.ridingTime,
    this.arrivedTime,
    this.directionSourceTitle,
    this.directionDestTitle,
    this.distanceFromSource,
  });

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      travelId: json["travelId"],
      departureDateTime: json["departureDatetime"] ?? "2020-05-26T11:52:08",
      basePrice: json["basePrice"],
      carTypeTitle: json["carTypeTitle"] ?? "بدون مدل",
      emptySeatCount: json["emptySeatCount"] ?? 0,
      durationMinute: json["durationOverDistance"],
      isMidWay: json["isMidway"] ?? false,
      sourceTownshipId: json["sourceTownshipId"],
      destTownshipId: json["destTownshipId"],
      travelDate: json["travelDate"],
      seatCount: json["seatCount"],
      id: json["id"],
      durationOverDistance: json["durationOverDistance"],
      distanceFromSource: json["distanceFromSource"],
      ridingTime: json["ridingTime"],
      arrivedTime: json["arrivedTime"],
      directionSourceTitle: json["directionSourceTitle"],
      directionDestTitle: json["directionDestTitle"],
    );
  }
}
// response
// "travel_id": 69,
// "departure_datetime": "2020-09-02T00:00:00",
// "base_price": 2500000,
// "car_type_title": "اتوبوس VIP 25 صندلی",
// "empty_seat_count": 10,
// "is_midway": false,
// "duration_over_distance": 240,
// "source_township_id": 128,
// "source_township_title": "زنجان",
// "dest_township_id": 1018,
// "dest_township_title": "تهران",
// "riding_time": "2020-09-02T04:30:00",
// "arrived_time": "2020-09-02T08:30:00",
// "direction_source_title": "زنجان",
// "direction_dest_title": "تهران"