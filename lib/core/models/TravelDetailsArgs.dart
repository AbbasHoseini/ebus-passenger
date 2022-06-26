import 'package:ebus/core/models/Bus.dart';
import 'package:ebus/core/models/Seat.dart';
import 'package:ebus/core/viewmodels/ResultViewModel.dart';

class TravelDetailsArgs {
  String? sourceName, destinationName;
  double? sourceLat, sourceLong, destLat, destLong;
  int? sourceId, destinationId, travelId;
  int? carTypeId;// 8 is vip
  int? basePrice;
  int? rowCount, colCount;
  int? seatCount;
  List<Seat>? seatList;
  ResultViewModel? resultViewModel;

  TravelDetailsArgs(
      {this.sourceName,
      this.destinationName,
      this.sourceLat,
      this.sourceLong,
      this.destLat,
      this.destLong,
      this.sourceId,
      this.destinationId,
      this.seatList});
}
