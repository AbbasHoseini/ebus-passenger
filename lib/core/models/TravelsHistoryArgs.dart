class TravelHistoryArgs {
  int? id, seatCount, travelTicketPrice;
  String? sourceTown, destTown;
  String? date, time, shamsiDate, qrCode;
  double? sourceLat, sourceLong, destLat, destLong;

  TravelHistoryArgs(
      {this.id,
      this.seatCount,
      this.travelTicketPrice,
      this.sourceTown,
      this.destTown,
      this.date,
      this.time,
      this.sourceLat,
      this.sourceLong,
      this.destLat,
      this.qrCode,
      this.destLong});
}
