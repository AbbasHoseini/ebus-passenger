import 'package:ebus/core/models/Bus.dart';

class ResultArgs {
  String? sourceName, destinationName;
  int? sourceId, destinationId;
  int? sourceCode, destinationCode;
  bool? isRoundTrip;
  List<Bus>? busList;
  List<Bus>? busListReturn;
  String? goingDate;
  // String comingDate = '';
  String? comingDate;

  ResultArgs(
      this.busList,
      this.sourceName,
      this.sourceId,
      this.destinationName,
      this.destinationId,
      this.sourceCode,
      this.destinationCode,
      this.isRoundTrip,
      this.goingDate,
      this.comingDate,
      {this.busListReturn});
}
